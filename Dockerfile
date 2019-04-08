FROM ruby:2.4.1

MAINTAINER m3career.com

ARG RUN_USER_NAME
ARG RUN_USER_GROUP
ARG RUN_USER_PASSWORD
ARG LOGSTASH_SERVICE

RUN sed -ri 's/main/main contrib/g' /etc/apt/sources.list && \
    sed -ri 's/httpredir.debian.org/ftp.jp.debian.org/g' /etc/apt/sources.list && \
    curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
    curl -sL https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
    echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list && \
    apt-get update && \
    apt-get install -y automake autotools-dev g++ git libcurl4-gnutls-dev libfuse-dev libssl-dev libxml2-dev make pkg-config gzip bzip2 --no-install-recommends && \
    apt-get install -y sudo logrotate monit vim gawk --no-install-recommends && \
    apt-get install -y nodejs yarn --no-install-recommends && \
    apt-get install -y mysql-client --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/s3fs-fuse/s3fs-fuse.git /usr/src/s3fs-fuse && \
    cd /usr/src/s3fs-fuse && \
    ./autogen.sh && \
    ./configure --prefix=/usr && \
    make && \
    make install

COPY docker/monit/monitrc /etc/monit/
COPY docker/monit/unicorn /etc/monit/conf.d/
RUN chmod 700 /etc/monit/monitrc etc/monit/conf.d/unicorn && \
    cp /etc/monit/monitrc.d/cron /etc/monit/conf.d/


COPY docker/logrotate/rails /etc/logrotate.d/
COPY docker/logrotate/nginx /etc/logrotate.d/
COPY docker/logrotate/logstash /etc/logrotate.d/
RUN sed -ri "s/su RUN_USER_NAME RUN_USER_GROUP/su ${RUN_USER_NAME} ${RUN_USER_GROUP}/g" /etc/logrotate.d/rails && \
    sed -ri "s/LOGSTASH_SERVICE_/${LOGSTASH_SERVICE}_/g" /etc/logrotate.d/nginx && \
    chmod 644 /etc/logrotate.d/rails /etc/logrotate.d/nginx /etc/logrotate.d/logstash && \
    groupadd -g 1000 ${RUN_USER_GROUP} && \
    useradd -g ${RUN_USER_GROUP} -G sudo -m -s /bin/bash ${RUN_USER_NAME} && \
    echo ${RUN_USER_NAME}:${RUN_USER_PASSWORD} | chpasswd
# 突如Cronが動かなくなるのを避けるための対応
RUN sed -ri "/pam_loginuid.so/s/^#*?(.*)/#\1/g" /etc/pam.d/cron

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

COPY Gemfile /usr/src/app/
COPY Gemfile.lock /usr/src/app/
RUN gem install bundler -v=1.17.3 && bundle install --clean
RUN gem update --system 3.0.2 && \
    sed -ie 's/Gem.activate_bin_path/Gem.bin_path/g' /usr/local/bin/bundle
RUN update_rubygems --version=2.6.8

EXPOSE 80 2812 3000
