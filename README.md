NGINX RTMP Push to Multiple Stream services
=====================

This Dockerfile installs NGINX configured with `nginx-rtmp-module`, ffmpeg
and some default settings for multiple stream services.


How to use:
-----------

1. Add your stream keys to the nginx.conf file and customize the RTMP ingest servers to RTMP servers near you.
    - [RTMP ingest servers for many streaming services](https://github.com/jp9000/obs-studio/blob/master/plugins/rtmp-services/data/services.json)
    - Thanks mcsmike for the list link :)

2. Secure access to your streaming server by uncommenting and changing the allow and deny parameters within the nginx.conf file.
    - allow publish 0.0.0.0/24 <--- change to your ip address
    - deny publish all <---- leave this alone

3. Build and run the container (`docker build -t nginx_rtmp .` &
   `docker run -d -p 1935:1935 nginx_rtmp`).

4. Stream your live content to `rtmp://localhost:1935/stream/CHOOSE_STREAM_KEY` where
   `CHOOSE_STREAM_KEY` is a name of your choosing.

5. Check Stream services to see if we are live!

Deploy to Digitalocean using CoreOS cloud-config:

1. Visit https://discovery.etcd.io/new to get a new auto-discovery token and replace within core-config.yml
2. Visit Digitalocean and start creating a Droplet choosing CoreOS as your distrobution
3. Under the "user-data" section of Droplet creation wizard paste the entire core-config.yml file
4. Log-in to your CoreOS droplet and follow the "How to use" instructions above.
    - All files from this repo should already be in /home/core/docker/nginx-rtmp

More Links
-----

* http://nginx.org/
* https://github.com/arut/nginx-rtmp-module
* https://www.ffmpeg.org/
* https://obsproject.com/
