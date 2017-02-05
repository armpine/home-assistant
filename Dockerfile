FROM armhf/alpine:3.5

COPY requirements_all.txt requirements_all.txt
COPY files/bin/. /usr/local/bin/

RUN ["docker-build-start"]


VOLUME /data
WORKDIR /data

# Define default command
CMD ["hass", "--config", "/data/.homeassistant"]

EXPOSE 8123
