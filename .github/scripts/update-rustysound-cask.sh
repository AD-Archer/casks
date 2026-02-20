#!/usr/bin/env bash
set -euo pipefail

SOURCE_REPO="${SOURCE_REPO:-AD-Archer/RustySound}"
CASK_FILE="${CASK_FILE:-Casks/rustysound.rb}"
ASSET_NAME="${ASSET_NAME:-Rustysound.dmg}"
RELEASE_TAG="${RELEASE_TAG:-}"

if [[ ! -f "$CASK_FILE" ]]; then
  echo "Cask file not found: $CASK_FILE" >&2
  exit 1
fi

if [[ -n "$RELEASE_TAG" && "$RELEASE_TAG" != v* ]]; then
  RELEASE_TAG="v${RELEASE_TAG}"
fi

if [[ -n "$RELEASE_TAG" ]]; then
  release_api="https://api.github.com/repos/${SOURCE_REPO}/releases/tags/${RELEASE_TAG}"
else
  release_api="https://api.github.com/repos/${SOURCE_REPO}/releases/latest"
fi

release_json="$(curl -fsSL \
  -H "Accept: application/vnd.github+json" \
  "$release_api")"

tag_name="$(jq -r '.tag_name' <<<"$release_json")"
if [[ -z "$tag_name" || "$tag_name" == "null" ]]; then
  echo "Could not resolve release tag for ${SOURCE_REPO}" >&2
  exit 1
fi

version="${tag_name#v}"
dmg_url="$(jq -r --arg asset "$ASSET_NAME" '.assets[] | select(.name == $asset) | .browser_download_url' <<<"$release_json")"

if [[ -z "$dmg_url" || "$dmg_url" == "null" ]]; then
  echo "Could not find ${ASSET_NAME} in ${SOURCE_REPO} release ${tag_name}" >&2
  exit 1
fi

sha256="$(curl -fsSL -L "$dmg_url" | sha256sum | awk '{print $1}')"

sed_in_place() {
  local expr="$1"
  local file="$2"
  if sed --version >/dev/null 2>&1; then
    sed -i "$expr" "$file"
  else
    sed -i '' "$expr" "$file"
  fi
}

sed_in_place "s/^  version \".*\"$/  version \"${version}\"/" "$CASK_FILE"
sed_in_place "s/^  sha256 \".*\"$/  sha256 \"${sha256}\"/" "$CASK_FILE"

if git diff --quiet -- "$CASK_FILE"; then
  echo "changed=false" >> "$GITHUB_OUTPUT"
else
  echo "changed=true" >> "$GITHUB_OUTPUT"
fi

echo "version=${version}" >> "$GITHUB_OUTPUT"
echo "sha256=${sha256}" >> "$GITHUB_OUTPUT"
echo "dmg_url=${dmg_url}" >> "$GITHUB_OUTPUT"
