#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# allow globs to “vanish” if nothing matches, and be case-insensitive
shopt -s nullglob nocaseglob

### ─── Configuration ──────────────────────────────────────────────────────────
# Video codec: libsvtav1 for AV1 (default), or switch to libx265 for H.265:
video_codec="libsvtav1"
#video_codec="libx265"

# Quality / speed settings:
crf=28            # AV1 default is 35; lower = better quality
preset=4          # SVT-AV1 preset 4; lower = slower encoding, better efficiency
#preset="slow"   # for x265 you'd typically use "slow", "medium", etc.

# Audio settings:
audio_codec="libopus"
#audio_codec="aac"
audio_bitrate="128k"

# Metadata preservation:
metadata_opts=(-map_metadata 0 -movflags use_metadata_tags)

# Output directory:
output_dir="compressed"
mkdir -p "$output_dir"
### ────────────────────────────────────────────────────────────────────────────

# Now include both mp4 and mkv files (any case)
for video_file in *.{mp4,mkv}; do
  [[ -f "$video_file" ]] || continue

  # extract extension (e.g. "MP4" or "mkv") and normalize to lowercase
  ext="${video_file##*.}"
  ext="${ext,,}"

  # strip off original extension to get base name
  base="${video_file%.*}"

  # re-use the same extension for output
  output_file="$output_dir/${base}.$ext"

  ffmpeg -i "$video_file" \
    -c:v "$video_codec" \
    "${metadata_opts[@]}" \
    -crf "$crf" \
    -preset "$preset" \
    -c:a "$audio_codec" \
    -b:a "$audio_bitrate" \
    "$output_file"

  printf "Encoded '%s' → '%s'  (vcodec=%s crf=%s preset=%s | acodec=%s bitrate=%s)\n" \
    "$video_file" "$output_file" \
    "$video_codec" "$crf" "$preset" \
    "$audio_codec" "$audio_bitrate"
done

