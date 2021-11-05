### Developement

##### required

```sh
# aws configure
aws configure

# edit env
cp .tfenv.default .tfenv
cp .tfvars.default .tfvars
```

##### docker

```
# make
make help
make build
make init dir=service
make plan dir=service
make fmt dir=service
make destroy dir=service
make apply dir=service
```

##### pre commit

```
# format
make fmt

# tfsec
make sec dir=service
```
