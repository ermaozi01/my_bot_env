FROM ubuntu:latest

ARG DEBIAN_FRONTEND=noninteractive

ENV LANG=zh_CN.UTF-8 \
    LANGUAGE=zh_CN.UTF-8 \
    LC_CTYPE=zh_CN.UTF-8 \
    LC_ALL=zh_CN.UTF-8 \
    TZ=Asia/Shanghai

ADD . .

RUN apt update &&\
    apt upgrade -y &&\
    apt install -y language-pack-zh-hans gcc python3.10 python3-dev python3-pip libcurl4-openssl-dev &&\
    ln -sf /bin/python3 /bin/python &&\
    apt install -y tzdata libnss3-dev libxss1 libasound2 libxrandr2 libatk1.0-0 libgtk-3-0 libgbm-dev libxshmfence1 &&\
    ln -fs /usr/share/zoneinfo/${TZ} /etc/localtime &&\
    echo ${TZ} > /etc/timezone &&\
    dpkg-reconfigure --frontend noninteractive tzdata &&\
    rm -rf /var/lib/apt/lists/* &&\
    python3 -m pip install -r requirements.txt &&\
    python3 -m pip install ./pkg/alipay_sdk_python-3.6.72-py3-none-any.whl &&\
    cp ./pkg/msyh.ttc /usr/share/fonts/ &&\
    python3 -m playwright install chromium
