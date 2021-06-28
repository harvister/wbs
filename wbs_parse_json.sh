set -e

jq "[.[].items[] | { \
    name: .track.name, \
    artist: .track.artists[0].name, \
    album: .track.album.name, \
    released: .track.album.release_date, \
    duration: .track.duration_ms, \
    added: .added_at \
  }]" \
  raw.json > playlist.json

jq "[.[].items[] | { \
    name: .track.name, \
    popularity: .track.popularity
  }]" \
  raw.json > popularity.json

rm raw.json
