

all : v1.24.1 v1.24 latest

v1.24.1 : Dockerfile
	docker buildx build --platform linux/amd64,linux/arm64 --build-arg MPY_VERSION=v1.24.1 --push -t codingfragments/micropython-buildenv:v12.4.1_esp .

v1.24 : Dockerfile
	docker buildx build --platform linux/amd64,linux/arm64 --build-arg MPY_VERSION=v1.24.1 --push -t codingfragments/micropython-buildenv:v12.4_esp .

latest : Dockerfile
	docker buildx build --platform linux/amd64,linux/arm64 --build-arg MPY_VERSION=v1.24.1 --push -t codingfragments/micropython-buildenv:latest .
