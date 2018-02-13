# CoreML self driving car

This project is a POC for a talk about CoreML during App Builders 2018.

## Useful Info

#### Raspberry PI Instance info

```
hostname: kitt
username: pi
password: kitt
```

to login
```sh
$ ssh pi@kitt.local
```
### Wifi

```
SSID: Driving
Pass: [no password]
```

#### Packages to install

Install uv4l
```
sudo apt-get install uv4l uv4l-raspicam uv4l-raspicam-extras uv4l-server uv4l-uvc uv4l-xscreen uv4l-mjpegstream
```

Run uv4l
```
sudo uv4l -nopreview --auto-video_nr --driver raspicam --encoding mjpeg --width 640 --height 480 --framerate 20 --rotation 180 --server-option '--port=9090' --server-option '--max-queued-connections=30' --server-option '--max-streams=25' --server-option '--max-threads=29'
```

Start on boot edit rc.local