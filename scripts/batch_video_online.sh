#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# allow globs to vanish if nothing matches, and be case-insensitive
shopt -s nullglob nocaseglob

### ─── Configuration ──────────────────────────────────────────────────────────
# Video codec:
video_codec="libsvtav1"             # AV1 encoder
# To switch to H.265 instead, uncomment the next two lines and comment out the libsvtav1 line:
# video_codec="libx265"
# # for x265 you might use a slower preset, e.g.:
# # preset="slow"

# Scaling filter (2/3 of original resolution, e.g. 1080p → 720p)
scale_filter="scale=trunc(iw*2/3/2)*2:trunc(ih*2/3/2)*2"

# Quality / speed settings:
crf=35                              # lower = better quality (AV1 default is 35; x265 default ~28)
preset=6                            # SVT-AV1 presets 0–8 (lower = slower/more efficient)
# For x265, you could choose presets like "medium", "slow", "veryslow", etc.

# Audio settings:
audio_codec="libopus"               # Opus audio
# audio_codec="aac"                # uncomment to use AAC instead
audio_bitrate="96k"                 # audio bitrate

# Metadata preservation:
metadata_opts=( -map_metadata 0 -movflags use_metadata_tags )

# Output directory:
output_dir="compressed"
mkdir -p "$output_dir"
### ────────────────────────────────────────────────────────────────────────────

# Process both mp4 and mkv (any case)
for video_file in *.{mp4,mkv}; do
  [[ -f "$video_file" ]] || continue

  # grab and normalize extension
  ext="${video_file##*.}"
  ext="${ext,,}"      # lowercase

  # strip extension for base name
  base="${video_file%.*}"

  # output file with same container
  output_file="$output_dir/${base}.$ext"

  ffmpeg -i "$video_file" \
    -c:v "$video_codec" \
    -vf "$scale_filter" \
    "${metadata_opts[@]}" \
    -crf "$crf" \
    -preset "$preset" \
    -c:a "$audio_codec" \
    -b:a "$audio_bitrate" \
    "$output_file"

  printf "Re-encoded '%s' → '%s'\n    (vcodec=%s scale=%s crf=%s preset=%s | acodec=%s bitrate=%s)\n" \
    "$video_file" "$output_file" \
    "$video_codec" "$scale_filter" "$crf" "$preset" \
    "$audio_codec" "$audio_bitrate"
done
