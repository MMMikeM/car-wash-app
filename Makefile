default: test

setup: build bundle yarn-install db-setup

build:
	docker-compose build

bundle:
	docker-compose run --rm web bundle install

dev:
	docker-compose run --rm web ash

console:
	docker-compose run --rm web rails c

db-setup:
	docker-compose run --rm web bundle exec rake db:reset
	docker-compose run --rm web bundle exec rake db:setup

db-create:
	docker-compose run --rm web bundle exec rake db:create

db-migrate:
	docker-compose run --rm web bundle exec rake db:migrate

db-seed:
	docker-compose run --rm web bundle exec rake db:seed

yarn-install:
	docker-compose run --rm web yarn install --check-files

run:
	docker-compose up

up:
	docker-compose up -d

stop:
	docker-compose down

restart:
	docker-compose down && docker-compose up -d

test:
	docker-compose run --rm web rake
