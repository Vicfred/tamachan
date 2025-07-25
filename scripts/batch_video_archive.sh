#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# allow globs to “vanish” if nothing matches, and be case-insensitive
shopt -s nullglob nocaseglob

### ─── Configuration ──────────────────────────────────────────────────────────
# Video codec: libsvtav1 for AV1 (default), or switch to libx265 for H.265:
video_codec="libsvtav1"

# Quality / speed settings:
crf=18            # AV1 default is 35; lower = better quality
                  # 18-20 is archival quality
                  # 22-24 is good for normal videos
preset=3          # default is 10; lower = slower encoding, better efficiency
                  # 4 is good enough for normal videos
                  # 0 is for important videos

# Audio settings:
audio_codec="libopus"
audio_bitrate="192k"      # 192k is for important audio
                          # 128 is good enough for normal audio

# Metadata preservation during encoding:
metadata_opts=(-map_metadata 0 -movflags use_metadata_tags)

# Output directory:
output_dir="compressed"
mkdir -p "$output_dir"
### ────────────────────────────────────────────────────────────────────────────

# Process mp4 and mkv files
for video_file in *.{mp4,mkv}; do
  [[ -f "$video_file" ]] || continue

  # extract extension (normalizing to lowercase)
  ext="${video_file##*.}"
  ext="${ext,,}"

  # strip off extension for base name
  base="${video_file%.*}"

  # define output filename
  output_file="$output_dir/${base}.$ext"

  # ── Encode video/audio with FFmpeg (preserving non-rewrite metadata) ────
  ffmpeg -i "$video_file" \
    "${metadata_opts[@]}" \
    -c:v "$video_codec" \
    -crf "$crf" \
    -preset "$preset" \
    -c:a "$audio_codec" \
    -b:a "$audio_bitrate" \
    "$output_file"

  # ── Extract and write embedded XML GPS into the original file ────────────
  exiftool -overwrite_original \
           -extractEmbedded \
           --duplicates \
           -TagsFromFile "$video_file" \
           -all:all \
           -time:all \
           -gps:all \
           -GPSLatitude \
           -GPSLongitude \
           -FNumber \
           -ExposureTime \
           -ISO \
           -FocalLength \
           -Lens \
           -LensMake \
           -LensModel \
           -LensSerialNumber \
           -FocalLengthIn35mmFormat \
           "$output_file"

  # ── Extract camera model name and set it on the encoded file ─────────────
  camera_model=$(exiftool -s3 -DeviceModelName "$video_file" 2>/dev/null || echo "")
  if [[ -n "$camera_model" ]]; then
    exiftool -overwrite_original \
             -Model="$camera_model" \
             "$output_file"
  fi

  # ── Extract lens model name and set it on the encoded file ─────────────
  lens_model=$(exiftool -s3 -LensModelName "$video_file" 2>/dev/null || echo "")
  if [[ -n "$lens_model" ]]; then
    exiftool -overwrite_original \
             -QuickTime:LensModel="$lens_model" \
             "$output_file"
  fi

  printf "Encoded '%s' → '%s'  (vcodec=%s crf=%s preset=%s | acodec=%s bitrate=%s)\n" \
    "$video_file" "$output_file" \
    "$video_codec" "$crf" "$preset" \
    "$audio_codec" "$audio_bitrate"
done

