# Repetier Server for RPi

### Installation

```sh
$ docker run -it -v /dev:/dev --privileged -p 3344:3344 -p 8888:8080 -d gochit/rpi-repetier-server-camera/
```
And you get Repetier Server on `:3344` port and your stream on `:8888` port.

Reference:
[Repetier tutorial](https://www.repetier-server.com/setting-webcam-repetier-server-linux/)

