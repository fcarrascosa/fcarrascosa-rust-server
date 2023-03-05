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

RUN mkdir -p /app/rust && mkdir -p /app/scripts
WORKDIR /app/scripts

COPY ./scripts/install_rust_cmd.sh /app/scripts/install_rust_cmd
RUN chmod +x ./install_rust_cmd && ./install_rust_cmd

COPY ./scripts/start_server.sh /app/scripts/start_server
RUN chmod +x ./start_server

USER steam

WORKDIR /app/rust

ENTRYPOINT ["/app/scripts/start_server"]
