ARCH ?= x86_64

# Validate ARCH
ifeq ($(filter $(ARCH),x86_64 arm64),)
$(error ARCH must be x86_64 or arm64, got: $(ARCH))
endif

.PHONY: test deploy clean

build:
	mkdir -p build

test:
	uv run pytest --cov

build/lambda-venv-$(ARCH).zip: build uv.lock
	./scripts/build_env.sh $(ARCH)

build/lambda-lib.zip: build $(shell find src -type f)
	./scripts/build-lib.sh

build/template.yml: build template.yml
	sed 's/\${ARCH}/$(ARCH)/g' template.yml > build/template.yml

deploy: build/template.yml build/lambda-venv-$(ARCH).zip build/lambda-lib.zip src/aws_lambda.py 
	sam build -t build/template.yml
	sam deploy -t build/template.yml

clean:
	rm -rf build/