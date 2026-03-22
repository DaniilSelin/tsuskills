.PHONY: up down build logs ps health clean init pull

up:
	docker compose up --build -d

down:
	docker compose down

clean:
	docker compose down -v --remove-orphans

build:
	docker compose build --no-cache

logs:
	docker compose logs -f

log:
	docker compose logs -f $(s)

ps:
	docker compose ps

health:
	@curl -s http://localhost:8000/health | python3 -m json.tool 2>/dev/null || curl -s http://localhost:8000/health

init:
	git submodule update --init --recursive

pull:
	git submodule update --remote --merge
