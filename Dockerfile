FROM armhf/alpine:3.5

COPY requirements_all.txt requirements_all.txt
COPY files/bin/homeassistant-install.sh ./homeassistant-install.sh

RUN ["chmod +x ./homeassistant-install.sh", "homeassistant-install.sh"]


VOLUME /data
WORKDIR /data

# Define default command
CMD ["hass", "--config", "/data/.homeassistant"]

EXPOSE 8123
