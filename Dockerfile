FROM centos:centos7
MAINTAINER Marcin Ryzycki marcin@m12.io, Przemyslaw Ozgo linux@ozgo.info

RUN \
    yum update -y && \
    yum install -y tar java-1.7.0-openjdk openssl && \
    mkdir -p /opt/logstash && \
    cd /opt/logstash && \
    curl -O https://download.elastic.co/logstash/logstash/logstash-1.5.2.tar.gz && \
    tar zxvf logstash-1.5.2.tar.gz -C /opt/logstash --strip-components=1 && \
    rm -f logstash-1.5.2.tar.gz && \
    yum remove -y tar && \
    yum clean all

RUN curl -O https://repos.chromeriver.com/repo/sources/logstash/s3.rb 
RUN mv s3.rb /opt/logstash/vendor/bundle/jruby/1.9/gems/logstash-output-s3-1.0.0/lib/logstash/outputs/


ENV SERVER_CN logstash

COPY container-files /

CMD /start.sh

EXPOSE 5043 12201
