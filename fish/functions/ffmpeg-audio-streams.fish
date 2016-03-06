function ffmpeg-audio-streams
  # relies on ffprobe (part of ffmpeg)
  # jq - a json parser
  # both are available via homebrew
  find . -iname "*.m4a" -o -iname "*.aif" | while read file; echo "$file"; ffprobe "$file" -v quiet -print_format json -show_streams | jq '.streams[] | {index,codec_name,codec_type,sample_fmt,sample_rate,channels,duration,bit_rate,bits_per_raw_sample}'; end
end

