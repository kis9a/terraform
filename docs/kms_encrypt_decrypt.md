## example

```
# decrypt encrypted file
kms_decrypt $input_filepath $profile $region

# encrypted
kms_encrypt $alias_suffix $input_filepath $profile $region

```

## functions

~/.zshrc

```
function kms_encrypt() {
  if [[ "$#" -lt 1 ]]; then
    echo 'kms_encrypt $alias_suffix $input_filepath $profile $region'
  else
    keyId=$(aws kms describe-key --key-id alias/"$1" --profile "${3:=default}" --region "${4:=ap-northeast-1}" --output json | jq -r .KeyMetadata.KeyId)
    aws kms encrypt --key-id "$keyId" --region "${4:=ap-northeast-1}" --plaintext fileb://"$2" \
      --output text --query CiphertextBlob --profile "${3:=default}"
  fi
}

function kms_decrypt() {
  if [[ "$#" -lt 1 ]]; then
    echo 'kms_decrypt $input_filepath $profile $region'
  else
    aws kms decrypt --ciphertext-blob fileb://<(cat "$1" | base64 -D) --output json --profile "$2" --region "${3:=ap-northeast-1}" |
      jq .Plaintext --raw-output | base64 -D
  fi
}
```
