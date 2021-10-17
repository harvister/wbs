set -e

playlist_id=$1

if [[ $playlist_id == "" ]]; then
  echo 1>&2 "bad playlist"
  exit 1
fi

echo 1>&2 "playlist: $playlist_id"

token=`curl -s "https://open.spotify.com/playlist/$playlist_id" \
  -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.77 Safari/537.36' \
  --compressed | tail -n 1 | perl -pe 's|.*accessToken\":\"(.*?)\".*|\1|'`

echo 1>&2 "using token $token"

skip=0
for i in {1..4}; do
  url=`printf '%s' \
    "https://api.spotify.com/v1/playlists/$playlist_id/tracks" \
    "?offset=$skip&limit=100&additional_types=track%2Cepisode&market=US"`
  echo 1>&2 $url
  data+=`curl -s "$url" \
    -H "authorization: Bearer $token" \
    --compressed`
  ((skip += 100))
done

jq -s "[.[].items[] | { \
    name: .track.name, \
    artist: .track.artists[0].name, \
    album: .track.album.name, \
    released: .track.album.release_date, \
    duration: .track.duration_ms, \
    added: .added_at \
  }]" <<< $data
