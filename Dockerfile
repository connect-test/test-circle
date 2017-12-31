FROM ruby:2.4.1-slim

RUN apt-key adv --keyserver ha.pool.sks-keyservers.net --recv-keys B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8 \
  && echo 'deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main' 9.6 > /etc/apt/sources.list.d/pgdg.list \
  && apt-get update -qy && apt-get upgrade -yq && apt-get install -y --no-install-recommends \
    build-essential \
    libpq-dev \
    nodejs \
    postgresql-client-9.6 \
    git-core \
    ssh \
    imagemagick \
# INSTALL BUNDLER
    && gem install bundler \
# Clean cache and temp files, fix permissions
    && apt-get clean -qy \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /circleci-test
WORKDIR /circleci-test
ADD Gemfile /circleci-test/Gemfile
ADD Gemfile.lock /circleci-test/Gemfile.lock

ENV BUNDLE_GEMFILE=/circleci-test/Gemfile \
    BUNDLE_JOBS=20

RUN bundle install

ADD . /circleci-test
