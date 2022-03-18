## Development

### profile

```sh
# aws configure
aws configure --profile kis9a
```

### docker

```sh
# make
make help
make build
make init dir=service
make plan dir=service
make fmt dir=service
make destroy dir=service
make apply dir=service

# optional and edit
cp .tfenv.default .tfenv
cp .tfvars.default .tfvars
```

### tfenv

```sh
# install tfenv
## brew
brew install tfenv

# install terraform
tfenv install $VERSION

# run
terraform $SUBCOMAND -chdir=$DIRECTORY -backend-config=.tfenv
```
