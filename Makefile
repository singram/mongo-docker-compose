.PHONY: initiate help

help: ## print this message
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-10s\033[0m %s\n", $$1, $$2}'

up: ## Start Mongo cluster (without init)
	docker-compose up -d

init: ## Launch mongo cluster init
	./initiate

clean: ## Stop docker containers and clean volumes
	docker-compose down -v

start: up init ## Start containers and launch init

stop: ## Stop docker containers
	docker-compose stop

watch: ## Watch logs
	docker-compose logs -f

restart: clean start ## Clean and restart

