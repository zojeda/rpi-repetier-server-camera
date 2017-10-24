FROM resin/rpi-raspbian

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get dist-upgrade -y \
    && apt-get install wget git ca-certificates \
    && apt-get install libjpeg8-dev imagemagick libv4l-dev make gcc git cmake g++

RUN wget --output-document repetier-server.deb -q http://download.repetier.com/files/server/debian-armel/Repetier-Server-0.86.2-Linux.deb
RUN dpkg -i repetier-server.deb

RUN git clone https://github.com/jacksonliam/mjpg-streamer.git
WORKDIR /mjpg-streamer/mjpg-streamer-experimental/
RUN cmake -G "Unix Makefiles"
RUN make
RUN make install
RUN /usr/local/bin/mjpg_streamer -i input_uvc.so -o "output_http.so -w /usr/local/share/mjpg-streamer/www" -b
WORKDIR /etc/init.d
RUN wget -O mjpgstreamer http://www.repetier-server.com/en/software/extras/mjpgstreamer-init-debian/mjpgstreamer
RUN chmod 755 mjpgstreamer
RUN update-rc.d mjpgstreamer defaults

RUN touch /var/lib/Repetier-Server/logs/server.log

WORKDIR /
COPY entrypoint.sh /entrypoint.sh
RUN chmod 755 /entrypoint.sh
RUN ls -lh /

VOLUME /var/lib/Repetier-Server
VOLUME /dev

EXPOSE 3344
EXPOSE 8080
EXPOSE 22

ENTRYPOINT ["/entrypoint.sh"]

CMD tail -f /var/lib/Repetier-Server/logs/server.log
