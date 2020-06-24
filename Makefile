setup: build bundle db-setup

build:
	docker-compose build

bundle:
	docker-compose run --rm web bundle install

dev:
	docker-compose run --rm web ash

console:
	docker-compose run --rm web rails c

db-setup:
	docker-compose run --rm web bundle exec rake db:create
	docker-compose run --rm web bundle exec rake db:migrate
	docker-compose run --rm web bundle exec rake db:seed

run:
	docker-compose up -d

stop:
	docker-compose down

restart:
	docker-compose down && docker-compose up -d

test:
	docker-compose run --rm web rake