#!/bin/bash

if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <record_id>"
  exit 1
fi

record_id="$1"

get_ts_link () {
  wget "https://live.shopee.co.id/api/v1/replay/${record_id}" \
    --quiet \
    --output-document='-' \
    --header='Accept-Encoding: gzip' \
    --header='Connection: Keep-Alive' \
    --header='Host: live.shopee.co.id' \
    --header='X-Livestreaming-Source: shopee' \
    --header='X-Shopee-Client-Timezone: Asia/Jakarta' \
    --compression=gzip \
    --max-redirect='0' \
    --user-agent='okhttp/3.12.4 app_type=1' \
    --no-cookies
}

get_ts_link 2>&1 | jq -r '.data.replay_info.record_url'
