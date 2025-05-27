FROM rockylinux:8
ARG TARGETARCH
WORKDIR /pulsar/asp-playgroud-sample/bin
RUN #yum  -y update curl glibc platform-python
RUN yum -y install java-11-openjdk sudo procps
ADD asp-playgroud-sample-*.tar.gz /pulsar
RUN chmod +x ./poc.sh