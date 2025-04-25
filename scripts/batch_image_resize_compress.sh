#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# allow *.jpg, *.jpeg (any case) to vanish if no matches, and match case-insensitively
shopt -s nullglob nocaseglob

# configuration
compression=75
height=3456
width=1944
output_dir="compressed"

# ensure output directory exists
mkdir -p "$output_dir"

# process both .jpg and .jpeg (thanks to nocaseglob, this grabs JPG/Jpeg/JPEG too)
for image_file in *.{jpg,jpeg}; do
  [[ -f "$image_file" ]] || continue

  output_file="$output_dir/$image_file"

  # compress, blur, interlace, and resize in one go (will overwrite)
  magick \
    "$image_file" \
    -interlace Plane \
    -gaussian-blur 0.05 \
    -quality "$compression" \
    -resize "${height}x${width}>" \
    "$output_file"

  # neat, predictable logging
  printf "Compressed '%s' by %d%% and resized to %dx%d → %s\n" \
    "$image_file" "$compression" "$height" "$width" "$output_file"
done
