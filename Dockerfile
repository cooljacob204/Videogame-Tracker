FROM ubuntu:18.04
RUN apt-get update \
    && apt-get install -y ruby \
    && apt-get install -y ruby-dev \
    && apt-get install -y make g++ gcc libssl-dev \
    && apt-get install -y zlib1g-dev libpq-dev\
    && apt-get install -y git

RUN gem install bundler

COPY ./ ./

RUN bundle install

ENV RACK_ENV production

CMD ["bundle", "exec", "thin", "--rackup", "config.ru", "-p", "3000", "start"]