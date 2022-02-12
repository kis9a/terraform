## example

```
# ssm start session
ssm_start_session bastion-bastion-dev kis9a

# describe instances
ec2_instances "**bastion*" kis9a

[
  {
    "Id": "i-0axxxxxxxxxxxxxxx",
    "PublicIp": "13xxxxxxxxxxxx",
    "PrivateIp": "10xxxxxxxxx",
    "Name": "bastion-bastion-dev"
  },
  {
    "Id": "i-0axxxxxxxxxxxxxxx",
    "PublicIp": "13xxxxxxxxxxxx",
    "PrivateIp": "10xxxxxxxxx",
    "Name": "bastion-bastion-stag"
  }

]
```

## functions

~/.zshrc

```
function ec2_instances() {
  if [[ "$#" -lt 1 ]]; then
    echo 'ec2_instances $instance_tag_name $profile'
  else
    aws ec2 describe-instances --filters "Name=tag:Name,Values=$1" --profile "${2:=default}" --output json | jq -r '.Reservations|.[].Instances|.[] |{Id: .InstanceId,PublicIp: .PublicIpAddress, PrivateIp: .PrivateIpAddress,Name: (.Tags[] | select(.Key=="Name").Value)}' | jq -s
  fi
}

function ssm_start_session() {
  if [[ "$#" -lt 1 ]]; then
    echo 'ssm_start_session $instance_tag_name $profile'
  else
    instance=$(aws ec2 describe-instances --filters "Name=tag:Name,Values=$1" --profile "$2" --output json |
      jq -r ".Reservations|.[].Instances|.[].InstanceId")
    aws ssm start-session --target "$instance" --profile "${2:=default}"
  fi
}
```
