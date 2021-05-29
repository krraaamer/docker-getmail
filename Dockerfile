FROM debian:10-slim
LABEL maintainer="krraaamer"
LABEL name="Kramer's Getmail Image"
LABEL version="2021-05-29"

ENV SLEEP_TIME="600"
ENV TZ="Etc/UTC"

RUN apt update -y && apt upgrade -y && apt install -y nano getmail
RUN useradd -m -u 1000 -s /bin/bash getmail
USER getmail

ADD --chown=getmail:getmail entrypoint.sh /entrypoint.sh

WORKDIR /
CMD ["bash", "./entrypoint.sh"]
