start:
	docker compose up -d

stop:
	docker compose down

restart:
	make stop
	make start

rebuild:
	docker compose up --build -d code-challenge-api

setup:
	docker exec code-challenge-api rails db:create db:migrate db:seed

reset:
	make restart && docker exec code-challenge-api rails db:drop db:create db:migrate db:seed

reset-test:
	rails db:environment:set RAILS_ENV=test db:drop db:create db:migrate

c:
	docker exec -it code-challenge-api rails c

exec:
	docker exec code-challenge-api $(cmd)

logs:
	docker logs -f code-challenge-api

rspec:
	bundle exec rspec spec
