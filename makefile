.PHONY: up-development
up-development:
	docker compose -f infra/compose/compose.common.yaml -f infra/compose/compose.development.yaml up

.PHONY:down-development
down-development:
	docker compose -f infra/compose/compose.common.yaml -f infra/compose/compose.development.yaml down

.PHONY:down-development-v
down-development-v:
	docker compose -f infra/compose/compose.common.yaml -f infra/compose/compose.development.yaml down -v

.PHONY: up-production
up-production:
	docker compose -f infra/compose/compose.common.yaml -f infra/compose/compose.production.yaml up

.PHONY: deploy
deploy:
	docker compose -f infra/compose/compose.common.yaml -f infra/compose/compose.production.yaml up --build --force-recreate -d

.PHONY:down-production
down-production:
	docker compose -f infra/compose/compose.common.yaml -f infra/compose/compose.production.yaml down

.PHONY:down-production-v
down-production-v:
	docker compose -f infra/compose/compose.common.yaml -f infra/compose/compose.production.yaml down -v
