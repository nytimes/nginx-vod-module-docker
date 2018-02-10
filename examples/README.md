# HLS & DASH example

## Running this example locally

You can run this example locally with Docker

```
% docker run -p 3030:80 -v $PWD/videos:/opt/static/videos -v $PWD/nginx.conf:/usr/local/nginx/conf/nginx.conf nytimes/nginx-vod-module
```

After running this command, you should be able to play the following URLs:

- HLS: http://localhost:3030/hls/devito,360p.mp4,480p.mp4,720p.mp4,.en_US.vtt,.urlset/master.m3u8
- Dash: http://localhost:3030/dash/devito,360p.mp4,480p.mp4,720p.mp4,.en_US.vtt,.urlset/manifest.mpd
- Thumbnail: http://localhost:3030/thumb/devito360p.mp4/thumb-1000.jpg
