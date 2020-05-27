.PHONY : build

include .env
export

all: test build

init:
	go mod vendor

build:
	docker build -t devxz/goim -f goim.Dockerfile .
	docker build -t devxz/discovery -f discovery.Dockerfile .

up:
	docker-compose up -d

stop:
	docker-compose stop

down:
	docker-compose down

logs:
	docker-compose logs -f

test:
	go test -v ./...