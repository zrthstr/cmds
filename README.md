## cmds
commands i keep forgetting

#### unix time stamp in secounds
``` sh
date +%s
```

#### extract attachment from mail
```sh
munpack
```

#### runn terrafrom with N threads in parallel
``` sh
terraform plan -parallelism=2
```

#### /* no comment */
``` sh
aws opsworks --region us-east-1 describe-stacks
aws opsworks --region us-east-1 describe-stacks --output=json | jq '.Stacks | .[].Arn '
```
