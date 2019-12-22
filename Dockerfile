FROM ich777/winehq-baseimage

MAINTAINER ich777

RUN dpkg --add-architecture i386
RUN apt-get update
RUN apt-get -y install lib32gcc1 wget screen xvfb

ENV DATA_DIR="/serverdata"
ENV STEAMCMD_DIR="${DATA_DIR}/steamcmd"
ENV SERVER_DIR="${DATA_DIR}/serverfiles"
ENV GAME_ID="template"
ENV MAX_PLAYERS=64
ENV SRV_NAME="Docker Grav"
ENV SRV_PWD="Docker"
ENV STEAM_SOCK=7785
ENV GAME_PORT=7786
ENV QUERY_PORT=27015
ENV WS_CONTENT=""
ENV GAME_PARAMS=""
ENV VALIDATE=""
ENV UMASK=000
ENV UID=99
ENV GID=100
ENV USERNAME=""
ENV PASSWRD=""

RUN mkdir $DATA_DIR
RUN mkdir $STEAMCMD_DIR
RUN mkdir $SERVER_DIR
RUN useradd -d $DATA_DIR -s /bin/bash --uid $UID --gid $GID steam
RUN chown -R steam $DATA_DIR

RUN ulimit -n 2048

ADD /scripts/ /opt/scripts/
RUN chmod -R 770 /opt/scripts/
RUN chown -R steam /opt/scripts

USER steam

#Server Start
ENTRYPOINT ["/opt/scripts/start-server.sh"]