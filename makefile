.PHONY: build
build: 
	docker image build -t issassembler-app -f infra/Dockerfile .

.PHONY: run
run:
	docker container run -it --name issassembler-app -p 8080:80 issassembler-app

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
