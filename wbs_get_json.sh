set -e

token=`curl -s 'https://open.spotify.com/playlist/44c831zcVMnzLHIatXe4N4?si=f3d13f6441ae476a&nd=1' \
  -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.77 Safari/537.36' \
  --compressed | tail -n 1 | perl -pe 's|.*accessToken\":\"(.*?)\".*|\1|'`

echo "using token $token"

skip=0
for i in {1..4}; do
  url=`printf '%s' \
    "https://api.spotify.com/v1/playlists/44c831zcVMnzLHIatXe4N4/tracks" \
    "?offset=$skip&limit=100&additional_types=track%2Cepisode&market=US"`
  echo $url
  data+=`curl -s "$url" \
    -H "authorization: Bearer $token" \
    --compressed`
  ((skip += 100))
done

jq -s "." <<< $data > raw.json
