FROM ruby:2.6.1-alpine AS dev

RUN apk add postgresql-dev tzdata nodejs nodejs-npm build-base yarn

ENV BUNDLE_PATH=/bundle \
    BUNDLE_BIN=/bundle/bin \
    GEM_HOME=/bundle
ENV PATH="${BUNDLE_BIN}:${PATH}"
ENV INSTALL_PATH /usr/src/app

RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH

RUN gem install bundler

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock

COPY . .

FROM dev AS prod

RUN bundle install

RUN yarn install --check-files

RUN bundle exec rake assets:precompile
