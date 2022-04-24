### What

Refer to the task definition when initializing the ECS service, which is a mock server for simplifying verification and operation check in the infrastructure.

### Local

```
docker build -t mock_server_go_docker . --file Dockerfile
export SERVER_PORT=22000
docker run --env SERVER_PORT -p $SERVER_PORT:$SERVER_PORT -it $(docker images mock_server_go_docker -q)
curl localhost:22000
```

### Publish

```
docker login -u AWS --password "$(aws ecr get-login-password --region ap-northeast-1 --profile kis9a)" https://426411783327.dkr.ecr.ap-northeast-1.amazonaws.com
docker build -t 426411783327.dkr.ecr.ap-northeast-1.amazonaws.com/kis9a/mock-server-go-docker:v1.0 .
docker push 426411783327.dkr.ecr.ap-northeast-1.amazonaws.com/kis9a/mock-server-go-docker:v1.0
```
