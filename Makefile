#################################
# Application workflow
#################################

SERVICES="openresty-app"

# Mount dev volumes and port forwarding for development
docker-compose-dev.yml: docker-compose.yml dc-dev.yml
	yq merge docker-compose.yml dc-dev.yml > docker-compose-dev.yml

# Run all containers
.PHONY: up
up: docker-compose-dev.yml
	@docker-compose -f docker-compose-dev.yml up -d ${SERVICES}

# Stop all containers
.PHONY: down
down:
	@docker-compose -f docker-compose-dev.yml down

# Rebuild
.PHONY: rebuild
rebuild: docker-compose-dev.yml
	@docker-compose -f docker-compose-dev.yml up -d --build ${SERVICES}

# Test
.PHONY: test
test: up docker-compose-dev.yml
	@docker-compose -f docker-compose-dev.yml up --build test

# Restart
.PHONY: restart
restart: down up

# Reload all services
.PHONY: reload
reload: openresty-reload

# Openresty reload
.PHONY: openresty-reload
openresty-reload:
	@docker-compose exec openresty-app sh -c 'openresty -s reload'

#################################
# Test & debug
#################################

# Healthcheck
.PHONY: openresty-healthcheck
openresty-healthcheck: up
	@docker-compose exec openresty-app sh -c 'curl -v http://localhost/healthcheck'
