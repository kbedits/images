FROM        ubuntu:18.04

LABEL       author="Isaac A." maintainer="isaac@isaacs.site"

RUN         apt update \
            && apt upgrade -y \
            && apt install -y lib32gcc1 lib32stdc++6 gnupg2 unzip curl iproute2 libgdiplus \
            && curl -sL https://deb.nodesource.com/setup_8.x | bash - \
            && apt install -y nodejs \
            && mkdir /node_modules \
            && cd /src; npm install --prefix / ws \
            && useradd -d /home/container -m container

USER        container
ENV         USER=container HOME=/home/container

WORKDIR     /home/container

COPY        ./entrypoint.sh /entrypoint.sh
COPY        ./wrapper.js /wrapper.js

CMD         ["/bin/bash", "/entrypoint.sh"]
