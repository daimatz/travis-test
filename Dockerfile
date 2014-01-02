FROM centos

RUN yum install -y passwd openssh openssh-server openssh-clients sudo

## create user
RUN useradd test
RUN echo test:pass | chpasswd

## setup sudoers
RUN echo "test ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers.d/test

## setup sshd and generate ssh-keys by init script
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/g' /etc/ssh/sshd_config
RUN sed -i 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN sed -i 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config
RUN /etc/init.d/sshd start
RUN /etc/init.d/sshd stop

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
