FROM rockylinux:8
ARG TARGETARCH
WORKDIR /pulsar/asp-pulsar-sample/bin
RUN #yum  -y update curl glibc platform-python
RUN yum -y install java-11-openjdk sudo procps
ADD asp-pulsar-sample-*.tar.gz /pulsar