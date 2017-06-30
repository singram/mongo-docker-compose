# -----------------------------------------------------------------
#        Main targets
# -----------------------------------------------------------------

help:
	@echo
	@echo "----- BUILD ------------------------------------------------------------------------------"
	@echo "up                   Start Mongo cluster (without init)"
	@echo "init                 Launch mongo cluster init"
	@echo "clean                Stop docker containers and clean volumes"
	@echo "start                Start containers and launch init"
	@echo "stop                 Stop docker containers"
	@echo "watch                Watch logs"
	@echo "restart              Clean and restart"
	@echo "----- OTHERS -----------------------------------------------------------------------------"
	@echo "help                 print this message"

.PHONY: initiate

up:
	docker-compose up -d

init:
	./initiate

clean:
	docker-compose down -v

stop:
	docker-compose stop

start: up init

restart: clean start

watch:
	docker-compose logs -f
