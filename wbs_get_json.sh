set -e

token="BQAq23-b_BjgjVl8dgkqF4HXrAkQZgp9Tg2Ltd7eCcWjvyX0Ry8EHohjAiflsoX5Xc2ufTwOgO4fy6bxR0Q"

skip=0
for i in {1..4}; do
  url=`printf '%s' \
    "https://api.spotify.com/v1/playlists/44c831zcVMnzLHIatXe4N4/tracks" \
    "?offset=$skip&limit=100&additional_types=track%2Cepisode&market=US"`
  echo $url
  curl -s "$url" \
    -H "authorization: Bearer $token" \
    > "temp_$i.json"
  ((skip += 100))
done
