SERVICES_SPEC_FILE=services.openapi.yaml

.PHONY: codegen-go
codegen-go:
	docker build -t pco-openapi-spec/oapi-codegen -f go/Dockerfile .
	docker run --rm -v "${PWD}:/mnt" \
	pco-openapi-spec/oapi-codegen \
	oapi-codegen \
	-generate types,client \
	-package client \
	/mnt/${SERVICES_SPEC_FILE} > go/client.go
