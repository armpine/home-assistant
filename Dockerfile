FROM armhf/alpine:3.5

ENV HOME_ASSISTANT_VERSION 0.37.1

#COPY tmp/qemu-arm-static /usr/bin/qemu-arm-static
COPY requirements_all.txt requirements_all.txt

RUN echo "http://dl-2.alpinelinux.org/alpine/v3.5/community" >> /etc/apk/repositories; \
    echo "http://dl-3.alpinelinux.org/alpine/v3.5/community" >> /etc/apk/repositories; \
    echo "http://dl-4.alpinelinux.org/alpine/v3.5/community" >> /etc/apk/repositories; \
    echo "http://dl-5.alpinelinux.org/alpine/v3.5/community" >> /etc/apk/repositories; \


    #####
    # Installing Alpine packages
    #####
    apk add --no-cache \
        bash \
        ca-certificates \
        freetype-dev \
        g++ \
        gcc \
        jpeg-dev \
        libffi-dev \
        libjpeg-turbo-dev \
        libpng-dev \
        libpq \
        libxml2-dev \
        libxslt-dev \
        linux-headers \
        net-tools \
        nmap \
        openssh-client \
        postgresql-dev \
        python3 \
        python3-dev \
        yaml \
    ; \


    #####
    # Installing Python packages
    #####
    python3 -m ensurepip; \
    rm -r /usr/lib/python*/ensurepip; \
    pip3 install --no-cache-dir --upgrade \
        pip \
        setuptools \
        mysqlclient \
        pillow \
        psycopg2 \
        uvloop \
    ; \
    pip3 install --no-cache-dir -r requirements_all.txt; \


    #####
    # Installing Home Assistant 0.37.1
    #####
    pip3 install homeassistant==0.37.1; \


    #####
    # Cache clean
    #####
    rm -r /root/.cache; \
    rm -rf /var/cache/apk/*;


VOLUME /data
WORKDIR /data

# Define default command
CMD ["hass", "--config", "/data/.homeassistant"]

EXPOSE 8123
