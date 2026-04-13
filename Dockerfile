FROM python:3.13-alpine3.22

# Установка ВСЕХ пакетов в ОДНОЙ команде
RUN apk update && \
    apk add --no-cache \
        chromium \
        chromium-chromedriver \
        openjdk11-jre \
        curl \
        tar \
        wget && \
    rm -rf /var/cache/apk/*

# Установка glibc
RUN wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub && \
    wget -P /tmp https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.30-r0/glibc-2.30-r0.apk && \
    wget -P /tmp https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.30-r0/glibc-bin-2.30-r0.apk && \
    apk add --allow-untrusted /tmp/glibc-2.30-r0.apk /tmp/glibc-bin-2.30-r0.apk && \
    rm /tmp/glibc-*.apk

# Установка Allure
RUN ALLURE_VERSION=2.15.3 && \
    curl -o /tmp/allure.tgz -Ls https://repo.maven.apache.org/maven2/io/qameta/allure/allure-commandline/${ALLURE_VERSION}/allure-commandline-${ALLURE_VERSION}.tgz && \
    tar -zxvf /tmp/allure.tgz -C /opt/ && \
    ln -s /opt/allure-${ALLURE_VERSION}/bin/allure /usr/bin/allure && \
    rm /tmp/allure.tgz

WORKDIR /usr/workspace
COPY ./requirements.txt /usr/workspace
RUN pip install -r requirements.txt