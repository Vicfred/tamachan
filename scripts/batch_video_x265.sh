#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

# allow globs to “vanish” if nothing matches, and be case-insensitive
shopt -s nullglob nocaseglob

### ─── Configuration ──────────────────────────────────────────────────────────
# Video codec: libsvtav1 for AV1 (default), or switch to libx265 for H.265:
video_codec="libx265"

# Quality / speed settings:
crf=28            # x265 default is 28; lower = better quality
preset=slow       # default is medium; lower = slower encoding, better efficiency
                  # ultrafast, superfast, veryfast, faster,
                  # fast, medium, slow, slower, veryslow

# Audio settings:
audio_codec="libfdk_aac"
audio_bitrate="96k"

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

  # check if the video is rotated using metadata
  rotate=$(ffprobe -v error \
  -select_streams v:0 \
  -show_entries stream_tags=rotate \
  -of csv=p=0 "$video_file")

  # scale the video
  scale="960:540:flags=lanczos"

  if [ -z "$rotate" ]; then
    echo "No rotation tag present"
  else
    echo "Rotated video"
    scale="-2:960:flags=lanczos"
  fi

  # ── Encode video/audio with FFmpeg (preserving non-rewrite metadata) ────
  ffmpeg -i "$video_file" \
    -vf "scale=$scale,format=yuv420p" \
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

  printf "Encoded '%s' → '%s'  (scale=%s | vcodec=%s crf=%s preset=%s | acodec=%s bitrate=%s)\n" \
    "$video_file" "$output_file" \
    "$scale" \
    "$video_codec" "$crf" "$preset" \
    "$audio_codec" "$audio_bitrate"
done

