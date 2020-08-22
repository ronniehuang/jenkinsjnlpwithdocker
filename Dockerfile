FROM jenkinsci/jnlp-slave

ENV DOCKER_CHANNEL=stable \
    DOCKER_VERSION=18.06.1-ce \
    DOCKER_COMPOSE_VERSION=1.22.0 \
    DOCKER_SQUASH=0.2.0

# COPY startdocker.sh /bin/startdocker.sh

# Install Docker, Docker Compose, Docker Squash

RUN apk --update --no-cache add \
        bash \
        curl \
        device-mapper \
        py-pip \
        iptables \
        ca-certificates \
        && \
    apk upgrade && \
    curl -fL "https://download.docker.com/linux/static/${DOCKER_CHANNEL}/x86_64/docker-${DOCKER_VERSION}.tgz" | tar zx && \
    mv /docker/* /bin/ && chmod +x /bin/docker* && \
    pip install docker-compose==${DOCKER_COMPOSE_VERSION} && \
    curl -fL "https://github.com/jwilder/docker-squash/releases/download/v${DOCKER_SQUASH}/docker-squash-linux-amd64-v${DOCKER_SQUASH}.tar.gz" | tar zx && \
    mv /docker-squash* /bin/ && chmod +x /bin/docker-squash* && \
    rm -rf /var/cache/apk/* && \
    rm -rf /root/.cache && \
    chmod +x /bin/startdocker.sh
