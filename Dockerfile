FROM nvidia/cuda:10.1-devel-ubuntu18.04

LABEL com.nvidia.volumes.needed="nvidia_driver"

############################### end nvidia cuda driver ################################

ENV HASHCAT_VERSION        v6.1.1
ENV HASHCAT_UTILS_VERSION  v1.9
ENV HCXTOOLS_VERSION       6.1.0
ENV HCXDUMPTOOL_VERSION    6.1.0
ENV HCXKEYS_VERSION        master

# Install packages for installing hashcat
RUN apt-get update
RUN apt-get install -y curl htop wget make clinfo build-essential git libcurl4-openssl-dev libssl-dev zlib1g-dev libcurl4-openssl-dev libssl-dev p7zip-full p7zip-rar screen

WORKDIR /root

RUN git clone https://github.com/hashcat/hashcat.git && cd hashcat && git checkout ${HASHCAT_VERSION} && make install -j4

RUN git clone https://github.com/hashcat/hashcat-utils.git && cd hashcat-utils/src && git checkout ${HASHCAT_UTILS_VERSION} && make
RUN ln -s /root/hashcat-utils/src/cap2hccapx.bin /usr/bin/cap2hccapx

RUN git clone https://github.com/ZerBea/hcxtools.git && cd hcxtools && git checkout ${HCXTOOLS_VERSION} && make install

RUN git clone https://github.com/ZerBea/hcxdumptool.git && cd hcxdumptool && git checkout ${HCXDUMPTOOL_VERSION} && make install

RUN git clone https://github.com/hashcat/kwprocessor.git && cd kwprocessor && git checkout ${HCXKEYS_VERSION} && make
RUN ln -s /root/kwprocessor/kwp /usr/bin/kwp

RUN curl -OJL "https://github.com/Cynosureprime/rling/raw/master/rling" && chmod +x rling && mv rling /bin/

# GET Wordlists

RUN wget "https://raw.githubusercontent.com/fa1rid/docker-hashcat/master/script.sh?v3" -O script.sh
RUN chmod +x script.sh
RUN ./script.sh
RUN rm ./script.sh

RUN touch ~/.no_auto_tmux

