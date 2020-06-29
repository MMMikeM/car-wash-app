setup: build bundle db-setup

build:
	docker-compose build

bundle:
	docker-compose run --rm web bundle install

dev:
	docker-compose up -d
	docker-compose exec web ash

db-setup:
	docker-compose down
	docker-compose run --rm web ./bin/db_setup

run:
	docker-compose up -d
	docker-compose logs -f web

stop:
	docker-compose down

restart:
	docker-compose down && docker-compose up -d
	docker-compose logs -f web

test:
	docker-compose run --rm web rake

deploy:
	docker build -t carwashapp:0.0.2 --target prod .
	docker tag carwashapp:0.0.2 mmmikem/car-wash-app:0.0.2
	docker push mmmikem/car-wash-app:0.0.2
