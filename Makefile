setup: build bundle db-setup

build:
	touch .env
	docker-compose build

bundle:
	docker-compose run --rm web bundle install

dev:
	docker-compose up -d
	docker-compose exec web ash

db-setup:
	docker-compose down
	docker-compose run --rm web ./bin/db_setup

db-migrate:
	docker-compose up -d
	docker-compose run --rm web rails db:migrate

db-seed:
	docker-compose up -d
	docker-compose run --rm web rails db:seed

run:
	docker-compose run --service-ports --rm web

stop:
	docker-compose down

restart:
	docker-compose down && docker-compose up -d
	docker-compose logs -f web

test:
	docker-compose run --rm web rake

deploy:
	docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD}
	docker build --target staging -t carwashapp:staging .
	docker tag carwashapp:staging mmmikem/car-wash-app:staging
	docker push mmmikem/car-wash-app:staging

image = $(shell cat .version)
prod_deploy:
	docker build --target prod -t $(image) .
	docker tag $(image) mmmikem/$(image)
	docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD}
	docker push mmmikem/${image}
