SERVICES_SPEC_FILE=services.openapi.yaml

.PHONY: generate-go
generate-go:
	docker run --rm -v "${PWD}:/local" \
    openapitools/openapi-generator-cli generate \
    -i /local/${SERVICES_SPEC_FILE} \
    -g go \
    -o /local/gen/go

.PHONY: oapi-codegen
oapi-codegen:
	docker run --rm -v "${PWD}:/mnt" \
    alexleonhardt/oapi-codegen oapi-codegen \
    /mnt/${SERVICES_SPEC_FILE} \
    -generate types,client \
    -package client > go/services/client.go
