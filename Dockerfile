from openjdk:8

RUN apt-get update \
    && apt-get install -y ssh \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* var/tmp/*

# Install Docker
RUN curl -sSL https://get.docker.com/ | sh    

RUN useradd -m -d /home/jenkins -s /bin/sh jenkins &&\
    echo "jenkins:jenkins" | chpasswd

# Allow jenkins to run docker commands
RUN usermod -aG docker jenkins

EXPOSE 22

VOLUME /var/out


RUN mkdir /var/run/sshd && chmod 0755 /var/run/sshd

CMD ["/usr/sbin/sshd", "-D"]