FROM ubuntu:20.04

LABEL maintainer="Andrew Christensen <andrew20190@gmail.com>"

RUN  apt-get update \
  && apt-get install -y wget \
  && apt-get install -y unzip \
  && apt-get install -y xvfb \
  && apt-get install -y libxtst6 \
  && apt-get install -y libxrender1 \
  && apt-get install -y libxi6 \
	&& apt-get install -y x11vnc \
  && apt-get install -y software-properties-common \
  && apt-get install -y dos2unix \
  && apt-get install -y xdotool \
  && apt-get install -y fluxbox

# Download TWS
RUN mkdir -p /opt/TWS
WORKDIR /opt/TWS
RUN wget -q https://download2.interactivebrokers.com/installers/tws/latest-standalone/tws-latest-standalone-linux-x64.sh
#COPY tws-latest-standalone-linux-x64.sh /opt/TWS/
RUN chmod a+x  tws-latest-standalone-linux-x64.sh
# install TWS, replies to prompt about where to install to, n to whether to run
# the final "|| true" is to fool Docker into not erroneously thinking the installer failed,
# because it was getting some unusual return code
RUN (echo /root/Jts/ && echo n) | ./tws-latest-standalone-linux-x64.sh || true

WORKDIR /

ENV DISPLAY :0

ADD ./vnc/xvfb_init /etc/init.d/xvfb
ADD ./vnc/vnc_init /etc/init.d/vnc
ADD ./vnc/xvfb-daemon-run /usr/bin/xvfb-daemon-run

RUN chmod -R 777 /usr/bin/xvfb-daemon-run \
  && chmod 777 /etc/init.d/xvfb \
  && chmod 777 /etc/init.d/vnc

RUN dos2unix /usr/bin/xvfb-daemon-run /etc/init.d/xvfb /etc/init.d/vnc 

# cleanup. No need to keep big fat file around
#RUN rm /opt/TWS/tws-latest-standalone-linux-x64.sh


# a couple missing dependencies the TWS Java setup needs
RUN apt-get install -y libgtk-3-0 libnss3 openjfx libgbm1

COPY fluxboxstartup.sh /startup.sh
RUN chmod ugo+rx  /startup.sh

COPY ib/jts.ini /root/Jts/jts.ini

CMD /usr/bin/xvfb-daemon-run /startup.sh 





