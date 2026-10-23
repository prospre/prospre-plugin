#!/bin/sh
# Builds the ChatGPT package: one top-level folder "prospre" holding plugin.json, mcp.json,
# the shared skills from ../skills plus the onboarding skill, and the assets.
set -eu
here="$(cd "$(dirname "$0")" && pwd)"
out="${1:-$here/prospre-chatgpt.zip}"
stage="$(mktemp -d)"
trap 'rm -rf "$stage"' EXIT

mkdir -p "$stage/prospre/skills"
cp "$here/plugin.json" "$here/mcp.json" "$stage/prospre/"
cp -R "$here/assets" "$stage/prospre/assets"
cp -R "$here/../skills/." "$stage/prospre/skills/"
cp -R "$here/skills/." "$stage/prospre/skills/"

rm -f "$out"
(cd "$stage" && zip -qr -X "$out" prospre)
echo "wrote $out"
unzip -l "$out"
