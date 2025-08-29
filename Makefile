# Makefile - Email Template Generator POC
# Comandos para gerenciamento do ambiente Docker

# Variáveis
DOCKER_COMPOSE = docker-compose
CONTAINER_NAME = email-template-poc
APP_URL = http://localhost:3000
DEVTOOLS_URL = http://localhost:24678

# Cores para output
GREEN = \033[0;32m
YELLOW = \033[1;33m
RED = \033[0;31m
NC = \033[0m # No Color

# Comando padrão
.DEFAULT_GOAL := help

# Garante uso do bash
SHELL := /bin/bash

.PHONY: help
help: ## Mostra esta mensagem de ajuda
	@echo ""
	@echo "$(GREEN)📧 Email Template Generator - POC$(NC)"
	@echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
	@echo ""
	@echo "$(YELLOW)Comandos disponíveis:$(NC)"
	@echo ""
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | \
		awk 'BEGIN {FS = ":.*?## "}; {printf "  $(GREEN)%-15s$(NC) %s\n", $$1, $$2}'
	@echo ""
	@echo "$(YELLOW)URLs da aplicação:$(NC)"
	@echo "  📍 App:      $(APP_URL)"
	@echo "  🔧 DevTools: $(DEVTOOLS_URL)"
	@echo ""

.PHONY: setup
setup: ## Instala dependências e cria o container
	@echo "$(GREEN)🔧 Configurando ambiente...$(NC)"
	@echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
	@echo ""
	@echo "$(YELLOW)→ Criando arquivo .dockerignore...$(NC)"
	@if [ ! -f .dockerignore ]; then \
		echo "node_modules" > .dockerignore; \
		echo ".nuxt" >> .dockerignore; \
		echo ".git" >> .dockerignore; \
		echo ".env.local" >> .dockerignore; \
		echo "*.log" >> .dockerignore; \
		echo "$(GREEN)  ✓ .dockerignore criado$(NC)"; \
	else \
		echo "$(YELLOW)  ⚠ .dockerignore já existe$(NC)"; \
	fi
	@echo ""
	@echo "$(YELLOW)→ Construindo imagem Docker...$(NC)"
	@$(DOCKER_COMPOSE) build --no-cache
	@echo ""
	@echo "$(GREEN)✅ Setup concluído com sucesso!$(NC)"
	@echo ""
	@echo "Execute '$(YELLOW)make up$(NC)' para iniciar a aplicação"

.PHONY: up
up: ## Inicializa a aplicação
	@echo "$(GREEN)🚀 Iniciando aplicação...$(NC)"
	@$(DOCKER_COMPOSE) up -d
	@echo ""
	@echo "$(GREEN)✅ Aplicação rodando!$(NC)"
	@echo ""
	@echo "  📍 App:      $(APP_URL)"
	@echo "  🔧 DevTools: $(DEVTOOLS_URL)"
	@echo ""
	@echo "  Ver logs:    $(YELLOW)make logs$(NC)"
	@echo "  Parar:       $(YELLOW)make down$(NC)"

.PHONY: down
down: ## Interrompe a execução do container
	@echo "$(YELLOW)🛑 Parando aplicação...$(NC)"
	@$(DOCKER_COMPOSE) down
	@echo "$(GREEN)✅ Aplicação parada$(NC)"

.PHONY: restart
restart: ## Reinicializa a aplicação
	@echo "$(YELLOW)🔄 Reiniciando aplicação...$(NC)"
	@$(DOCKER_COMPOSE) restart
	@echo "$(GREEN)✅ Aplicação reiniciada$(NC)"
	@echo ""
	@echo "  📍 App: $(APP_URL)"

.PHONY: logs
logs: ## Mostra logs em tempo real
	@echo "$(YELLOW)📜 Mostrando logs (Ctrl+C para sair)...$(NC)"
	@$(DOCKER_COMPOSE) logs -f

.PHONY: shell
shell: ## Acessa o terminal do container
	@echo "$(YELLOW)🖥️  Acessando container...$(NC)"
	@echo "Digite 'exit' para sair"
	@$(DOCKER_COMPOSE) exec app sh

.PHONY: status
status: ## Mostra status dos containers
	@echo "$(GREEN)📊 Status dos containers:$(NC)"
	@echo "━━━━━━━━━━━━━━━━━━━━━━━━━"
	@$(DOCKER_COMPOSE) ps

.PHONY: rebuild
rebuild: ## Reconstrói a imagem do zero
	@echo "$(YELLOW)🔨 Reconstruindo imagem...$(NC)"
	@$(DOCKER_COMPOSE) down
	@$(DOCKER_COMPOSE) build --no-cache
	@$(DOCKER_COMPOSE) up -d
	@echo "$(GREEN)✅ Rebuild completo!$(NC)"

.PHONY: clean
clean: ## Remove containers e volumes
	@echo "$(RED)⚠️  Isto irá remover containers e volumes!$(NC)"
	@read -p "Continuar? [y/N]: " confirm && \
	if [ "$$confirm" = "y" ] || [ "$$confirm" = "Y" ]; then \
		echo "$(YELLOW)🧹 Limpando ambiente...$(NC)"; \
		$(DOCKER_COMPOSE) down -v; \
		echo "$(GREEN)✅ Limpeza concluída$(NC)"; \
	else \
		echo "$(YELLOW)Operação cancelada$(NC)"; \
	fi

.PHONY: test
test: ## Testa os endpoints da API
	@echo "$(GREEN)🧪 Testando endpoints...$(NC)"
	@echo "━━━━━━━━━━━━━━━━━━━━━━━━"
	@echo ""
	@echo "$(YELLOW)→ Testando health check...$(NC)"
	@curl -s -o /dev/null -w "  Status HTTP: %{http_code}\n" $(APP_URL)/api/health || echo "$(RED)  ✗ Falha no health check$(NC)"
	@echo ""
	@echo "$(YELLOW)→ Testando preview de template...$(NC)"
	@curl -s -o /dev/null -w "  Status HTTP: %{http_code}\n" "$(APP_URL)/api/preview?template=/email-template" || echo "$(RED)  ✗ Falha no preview$(NC)"
	@echo ""
	@echo "$(GREEN)✅ Testes concluídos$(NC)"

.PHONY: dev
dev: up logs ## Atalho para desenvolvimento (up + logs)

.PHONY: quick
quick: setup up ## Setup + Start rápido