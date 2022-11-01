FROM docker/for-desktop-kernel:5.15.49-13422a825f833d125942948cf8a8688cef721ead as ksrc

FROM ubuntu:20.04

WORKDIR /
COPY --from=ksrc /kernel-dev.tar /
RUN tar xf kernel-dev.tar && rm kernel-dev.tar

RUN apt-get update
RUN apt install -y kmod python3-bpfcc wget
RUN apt install -y make gcc flex bison libelf-dev bc 
RUN apt install -y libssl-dev vim curl


WORKDIR /usr/src
RUN curl -SL https://mirrors.edge.kernel.org/pub/linux/kernel/v5.x/linux-5.15.49.tar.gz \
    | tar -xzC .
RUN mv linux-5.15.49/ 5.15.49-linuxkit
RUN mkdir -p /lib/modules/5.15.49-linuxkit 
WORKDIR  /lib/modules/5.15.49-linuxkit


RUN echo "download success"

COPY linuxkit-complier.sh /root
RUN sh /root/linuxkit-complier.sh
RUN echo "compiler successs"

WORKDIR  /lib/modules/5.15.49-linuxkit 
RUN rm -rf source build 
RUN cp -r /usr/src/5.15.49-linuxkit/ . \
    && mv 5.15.49-linuxkit source 
RUN cp -r /usr/src/5.15.49-linuxkit/ . \
    && mv 5.15.49-linuxkit build 
WORKDIR /root
CMD mount -t debugfs debugfs /sys/kernel/debug && /bin/bash
