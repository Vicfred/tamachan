#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# allow *.jpg, *.jpeg (any case) to vanish if no matches, and match case-insensitively
shopt -s nullglob nocaseglob

# configuration
compression=85
output_dir="compressed"

# ensure output dir exists
mkdir -p "$output_dir"

# process both .jpg and .jpeg (thanks to nocaseglob, this grabs JPG/Jpeg/JPEG too)
for image_file in *.{jpg,jpeg}; do
  [[ -f "$image_file" ]] || continue

  output_file="$output_dir/$image_file"

  # perform the compression (will overwrite existing output_file)
  magick \
    "$image_file" \
    -quality "$compression" \
    "$output_file"

  printf "Compressed '%s' by %d%% → %s\n" \
    "$image_file" "$compression" "$output_file"
done
