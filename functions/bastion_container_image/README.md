### Publish

```
docker login -u AWS --password "$(aws ecr get-login-password --region ap-northeast-1 --profile kis9a)" https://xxxxxxxxxx.dkr.ecr.ap-northeast-1.amazonaws.com
docker build -t xxxxxxxxxx.dkr.ecr.ap-northeast-1.amazonaws.com/kis9a/bastion:v1.0 .
docker push xxxxxxxxxx.dkr.ecr.ap-northeast-1.amazonaws.com/kis9a/bastion:v1.0
```
