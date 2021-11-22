SERVICE := me-tf
TFVERSION := 1.0.9
.DEFAULT_GOAL := help
PWD = $(shell realpath $(dir $(lastword $(MAKEFILE_LIST))))
DIRS := $(filter-out $(EXCLUDES), $(wildcard ??*))
TFVARS = $(shell realpath --relative-to $(dir) $(PWD)/.tfvars)
TFENV = $(shell realpath --relative-to $(dir) $(PWD)/.tfenv)
IMAGE_NAME := $(SERVICE)-$(TFVERSION)
IMAGE := $(shell docker images $(IMAGE_NAME) -q)

env:
	@echo terraform version $(TFVERSION)
	@echo service version $(SERVICE)
	@echo pwd $(PWD)
	@echo dirs $(DIRS)
	@echo image terraform $(IMAGE)
	@echo image name $(IMAGE_NAME)

dirs: ### list of directory
	@$(foreach val, $(DIRS), /bin/ls -dF $(val);)

help: ### display help
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

build: ## build terraform image
	@docker build -t $(IMAGE_NAME) . --file Dockerfile.dev

init: ## terraform init
	docker run --rm -w /terraform -v $(PWD):/terraform -v ~/.aws:/.aws -it $(IMAGE) \
	-chdir=$(dir) init -backend-config=$(TFENV)

plan: ## terraform plan
	docker run --rm -w /terraform -v $(PWD):/terraform -v ~/.aws:/.aws -it $(IMAGE) \
	 -chdir=$(dir) plan -var-file=$(TFVARS)

apply: ## terraform apply
	docker run --rm -w /terraform -v $(PWD):/terraform -v ~/.aws:/.aws -it $(IMAGE) \
	 -chdir=$(dir) apply -var-file=$(TFVARS)

destroy: ## terraform destroy
	docker run --rm -w /terraform -v $(PWD):/terraform -v ~/.aws:/.aws -it $(IMAGE) \
	 -chdir=$(dir) destroy -var-file=$(TFVARS)

fmt: ## terraform fmt
	docker run --rm -w /terraform -v $(PWD):/terraform -v ~/.aws:/.aws -it $(IMAGE) \
	 -chdir=$(dir) fmt

sec: ## tfsec
	(cd $(dir); tfsec .)
