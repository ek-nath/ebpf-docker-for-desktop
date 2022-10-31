FROM docker/for-desktop-kernel:5.15.49-13422a825f833d125942948cf8a8688cef721ead AS ksrc

FROM ubuntu:20.04

WORKDIR /
COPY --from=ksrc /kernel-dev.tar /
RUN tar xf kernel-dev.tar && rm kernel-dev.tar

RUN apt-get update
RUN apt install -y kmod python3-bpfcc wget
RUN apt install -y make gcc flex bison libelf-dev bc 
RUN apt install -y libssl-dev vim


COPY linuxkit-dl.sh /root
COPY linuxkit-complier.sh /root

RUN sh /root/linuxkit-dl.sh 
RUN echo "download success"

RUN sh /root/linuxkit-complier.sh
RUN echo "complier successs"

CMD mount -t debugfs debugfs /sys/kernel/debug && /bin/bash
