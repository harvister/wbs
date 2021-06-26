# jq "[.items[] | { \
#     name: .track.name, \
#     artist: .track.artists[0].name, \
#     album: .track.album.name, \
#     duration: .track.duration_ms, \
#     added: .added_at \
#   }]" \
#   temp_4.json

jq -s "[.[].items[] | { \
    name: .track.name, \
    artist: .track.artists[0].name, \
    album: .track.album.name, \
    duration: .track.duration_ms, \
    added: .added_at \
  }]" \
  temp_1.json temp_2.json temp_3.json temp_4.json
  # temp_4.json temp_4_copy.json

# jq -s ".[0] + .[1]" temp.json "temp copy.json" > tempx.json