FROM ruby:2.7.1-alpine AS dev

RUN apk add postgresql-dev tzdata build-base

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

#######################################
#Staging
#######################################
FROM dev AS staging

RUN bundle install

CMD ["sh", "entrypoint.sh"]

#######################################
#Production
#######################################
FROM dev AS prod

ENV RAILS_ENV=production

RUN bundle install

CMD ["sh", "bin/start.sh"]
