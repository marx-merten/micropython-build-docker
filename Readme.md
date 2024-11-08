# Create Images

## local Docker

docker build -t micropython-buildenv:v1.24.0_esp .

## multiplatform push

docker buildx build --platform linux/amd64,linux/arm64 --push -t codingfragments/micropython-buildenv:v1.24.0_esp .doc