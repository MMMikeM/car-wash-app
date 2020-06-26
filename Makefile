default: test

setup: build bundle yarn-install db-setup create-dev-records

build:
	docker-compose build

bundle:
	docker-compose run --rm web bundle install

dev:
	docker-compose exec web ash

console:
	docker-compose exec web rails c

create-dev-records:
	docker-compose run --rm web rake create_dev_records:basic_user

db-reset:
	rm -rf postgres-data
	docker-compose run --rm web bundle exec rake db:create
	docker-compose run --rm web bundle exec rake db:migrate
	docker-compose run --rm web bundle exec rake db:seed
	docker-compose run --rm web rake create_dev_records:basic_user

db-setup:
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
