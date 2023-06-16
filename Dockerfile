FROM ruby:3.0.4-alpine3.14

WORKDIR /openflab

COPY . .

RUN apk add --update \
    build-base \
    mariadb-dev \
    sqlite-dev \
    nodejs \
    tzdata \
    && rm -rf /var/cache/apk/*

RUN gem install bundler

RUN bundle install

EXPOSE 3000

CMD rm -f tmp/pids/server.pid && rails s -b 'ssl://0.0.0.0:3000?key=localhost.key&cert=localhost.crt'