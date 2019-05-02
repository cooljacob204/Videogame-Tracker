FROM ruby:2.6.3

RUN gem install bundler

COPY ./Gemfile ./Gemfile

RUN bundle install

COPY ./ ./

ENV RACK_ENV production

CMD ["bundle", "exec", "thin", "--rackup", "config.ru", "-p", "3000", "start"]