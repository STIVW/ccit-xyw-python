FROM ubuntu:18.04
MAINTAINER shenyoutao <869862584@qq.com>

COPY chrom.py /root
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY tt-cron /etc/cron.d/tt-cron

RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get install -y tzdata \
    && ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && dpkg-reconfigure --frontend noninteractive tzdata

RUN apt update && \
    apt install -y openssh-server   python3  python3-pip   chromium-browser chromium-chromedriver cron vim supervisor rsyslog curl ca-certificates jq -y --no-install-recommends && \
    sed -i "s/#cron.*/cron.*/g" /etc/rsyslog.d/50-default.conf  && \
    pip3 install selenium &&\
    chmod 0644 /etc/cron.d/tt-cron && \
    crontab /etc/cron.d/tt-cron && \
    touch /var/log/cron.log && \
    apt-get clean && \
    apt-get purge -y --auto-remove

#CMD ["/usr/sbin/sshd","-D"]
#CMD ["cron", "-f"]


CMD ["/usr/bin/supervisord"]




