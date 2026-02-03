FROM ruby:2.7.1-alpine AS dev

RUN apk add postgresql-dev tzdata build-base shared-mime-info

ENV BUNDLE_PATH=/bundle \
    BUNDLE_BIN=/bundle/bin \
    GEM_HOME=/bundle
ENV PATH="${BUNDLE_BIN}:${PATH}"
ENV INSTALL_PATH /usr/src/app

RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH

RUN gem install bundler -v 2.4.22

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock

COPY . .

FROM dev AS staging

RUN bundle install

CMD ["sh", "entrypoint.sh"]

FROM dev AS prod

ENV RAILS_ENV=production

COPY --from=staging /bundle /bundle

CMD ["sh", "bin/start"]
