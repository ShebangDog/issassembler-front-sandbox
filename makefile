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

.PHONY: deploy
deploy:
	docker compose -f compose/common/compose.yaml -f compose/production/compose.override.yaml up --build --force-recreate -d

.PHONY:down-production
down-production:
	docker compose -f compose/common/compose.yaml -f compose/production/compose.override.yaml down

.PHONY:down-production-v
down-production-v:
	docker compose -f compose/common/compose.yaml -f compose/production/compose.override.yaml down -v
