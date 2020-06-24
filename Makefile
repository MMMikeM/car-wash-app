default: test

setup: build bundle db-setup

build:
	docker-compose build

bundle:
	docker-compose run --rm web bundle install

dev:
	docker-compose run --rm web ash

console:
	docker-compose run --rm web rails c

db-setup: db-create db-migrate db-seed

db-create:
	docker-compose run --rm web bundle exec rake db:create

db-migrate:
	docker-compose run --rm web bundle exec rake db:migrate

db-seed:
	docker-compose run --rm web bundle exec rake db:seed

run:
	docker-compose up

stop:
	docker-compose down

restart:
	docker-compose down && docker-compose up -d

test:
	docker-compose run --rm web rake