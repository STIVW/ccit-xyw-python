FROM ubuntu:18.04
MAINTAINER stivw <869862584@qq.com>

COPY chrom.py /root

# Install the ssh
RUN apt update && \
    apt install	-y openssh-server && \
    echo "root:123456" | chpasswd && \
    sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config && \
    mkdir -p /var/run/sshd

# Install the python3
RUN apt-get install python3 -y && \
    apt-get install python3-pip -y &&\
    pip3 install selenium 


# Install the chrome   
RUN apt install chromium-browser -y && \
    apt install chromium-chromedriver -y  &&\
    apt install vim  -y

    
# Install Cron
RUN apt-get install cron

# Install the crontab
#COPY crontab /etc/cron.d/crontab


#Install supervisor
RUN apt install supervisor -y
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

#Install rsyslog
RUN apt-get install rsyslog -y && \
    sed -i "s/#cron.*/cron.*/g" /etc/rsyslog.d/50-default.conf 

RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get install -y tzdata \
    && ln -fs /usr/share/zoneinfo/Asia/Shanghai /etc/localtime \
    && dpkg-reconfigure --frontend noninteractive tzdata

EXPOSE 22 

#CMD ["/usr/sbin/sshd","-D"]
#CMD ["cron", "-f"]
CMD ["/usr/bin/supervisord"]
