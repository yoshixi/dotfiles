FROM ruby:2.4.1-onbuild

RUN bundle config --global frozen 1
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

# このイメージをもとにしたイメージからコンテナをビルドしたあとに実行する
ONBUILD COPY Gemfile /usr/src/app/
ONBUILD COPY Gemfile.lock /usr/src/app/
ONBUILD RUN bundle install
ONBUILD COPY . /usr/src/app
