######################################################################
######################################################################
####                           SteamCMD                           ####
######################################################################
######################################################################

FROM ubuntu:jammy as steamcmd

### Install Steam Dependencies and SteamCMD

RUN dpkg --add-architecture i386 && \
    apt update && \
    apt install -y lib32gcc-s1 lib32stdc++6 libc6-i386 libcurl4-gnutls-dev:i386 libsdl2-2.0-0:i386 && \
    echo steam steam/question select "I AGREE" | debconf-set-selections && \
	echo steam steam/license note '' | debconf-set-selections && \
    apt install -y steamcmd

### Add steam utils/safeties and direcrtories

RUN ln -s /usr/games/steamcmd /usr/local/bin/steamcmd
RUN adduser --gecos "" --disabled-password steam
RUN mkdir /app
RUN chown -R steam:steam /app

### Add steam user

WORKDIR /app
### Run steam

ENTRYPOINT ["steamcmd" "+quit"]

######################################################################
######################################################################
####                       Rust Game Server                       ####
######################################################################
######################################################################

FROM steamcmd as rust-game-server

### Install RustCMD Dependencies
RUN apt install -y sqlite3

RUN mkdir -p /app/scripts
WORKDIR /app/scripts

COPY ./scripts/install_rust_cmd.txt /app/scripts/install_rust_cmd.txt
COPY ./scripts/start_server.sh /app/scripts/start_server.sh

RUN chown -R steam:steam . && chmod +x ./*.sh

USER steam
RUN mkdir -p /app/rust 
RUN steamcmd +runscript /app/scripts/install_rust_cmd.txt

ENV SERVER_ID=fcarrascosa-rust-server
ENV SERVER_PORT=28015
ENV SERVER_QUERY_PORT=28016
ENV SERVER_NAME="Fcarrascosa Rust Server"
ENV SERVER_DESCRIPTION="A cool rust game server powered by docker."
ENV SERVER_LEVEL="Procedural Map"
ENV SERVER_SEED=12345
ENV SERVER_WORLDSIZE=3500
ENV SERVER_URL="https://github.com/fcarrascosa"
ENV SERVER_MAXPLAYERS=200
ENV RCON_PORT=28017
ENV RCON_PASSWORD=changeMe
ENV RCON_WEB=1

WORKDIR /app/rust

ENTRYPOINT ["/app/scripts/start_server.sh"]
