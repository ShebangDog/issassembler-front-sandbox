.PHONY: build
build: 
	docker image build -t issassembler-app -f infra/Dockerfile .

.PHONY: run
run:
	docker container run -it --name issassembler-app -p 8080:80 issassembler-app

.PHONY: deploy
deploy:
	docker container run -d --name issassembler-app -p 80:80 issassembler-app


.PHONY: clean
clean:
	docker container rm -f issassembler-app

.PHONY: build-app-web
build-app-web:
	docker image build -t issassembler-app-web -f app-web/Dockerfile .

.PHONY: run-app-web
run-app-web:
	docker container run -d --name issassembler-app-web issassembler-app-web

.PHONY: clean-app-web
clean-app-web:
	docker container rm -f issassembler-app-web

.PHONY: up-development
up-development:
	docker compose -f compose/common/compose.yaml -f compose/development/compose.override.yaml up

.PHONY:down-development
down-development:
	docker compose -f compose/common/compose.yaml -f compose/development/compose.override.yaml down

.PHONY:down-development-v
down-development-v:
	docker compose -f compose/common/compose.yaml -f compose/development/compose.override.yaml down -v

.PHONY: up-production
up-production:
	docker compose -f compose/common/compose.yaml -f compose/production/compose.override.yaml up

.PHONY:down-production
down-production:
	docker compose -f compose/common/compose.yaml -f compose/production/compose.override.yaml down

.PHONY:down-production-v
down-production-v:
	docker compose -f compose/common/compose.yaml -f compose/production/compose.override.yaml down -v
