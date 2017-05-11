## cmds

### vim
```
syntax on
"filetype indent plugin on
set tabstop=4
set expandtab
set shiftwidth=4
set softtabstop=4
set background=dark
set ruler

nnoremap <buffer> <F8> :exec '!python2' shellescape(@%, 1)<cr>
nnoremap <buffer> <F9> :exec '!python3' shellescape(@%, 1)<cr>

" Uncomment the following to have Vim jump to the last position when reopening a file "
if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
```

### osx things
```
# pipe to copy+paste buffer
cat fiele_name | pbcopy
```

### compression
```sh
tar -cvf output.tar /dirname
tar -cvzf output.tar.gz /dirname
tar -xvf /tmp/data.tar
```

#### unix time stamp in secounds
``` sh
date +%s
```
#### cd to resolved symlink position
``` sh
cd $(pwd -P)
cd -P some_link
```
#### diff 2 folders
``` sh
diff -rq folderN folderM
```

#### shell magic
```sh
diff <(ssh foo ls -1 bar) <(ls -1 rand)
```

#### extract attachment from mail
```sh
munpack
```

#### runn terrafrom with N threads in parallel
``` sh
terraform plan -parallelism=2

# https://github.com/Yleisradio/homebrew-terraforms  # effortless use multiple terraform versions on osx 
```

#### jq print without quotes
```sh
jq -r
jq --raw-output
```


#### /* no comment */
``` sh
aws opsworks --region us-east-1 describe-stacks
aws opsworks --region us-east-1 describe-stacks --output=json | jq '.Stacks | .[].Arn '

aws ec2 describe-vpcs
aws ec2 describe-vpcs --region=$region --output=json | jq ".Vpcs | .[].VpcId "

aws ec2 describe-regions --output=json
aws ec2 describe-regions --output=json | jq '.Regions[].RegionName '


for region in $(aws ec2 describe-regions --output=json | jq -r '.Regions[].RegionName ' ); do  aws ec2 describe-vpcs --region=$region --output=json ; done

for region in $(aws ec2 describe-regions --output=json | jq -r '.Regions[].RegionName ' ); do  aws ec2 describe-vpcs --region=$region --output=json | jq ".Vpcs | .[].VpcId "  ; done

# list regions and their vpcs
for region in $(aws ec2 describe-regions --output=json | jq -r '.Regions[].RegionName ' ); do echo; echo region: $region;  aws ec2 describe-vpcs --region=$region --output=json | jq ".Vpcs[].VpcId "  ; done

aws s3api list-buckets --query 'Buckets[].Name'

for e  in $(aws s3api list-buckets --query 'Buckets[].Name' ) ; do  aws s3api list-objects --bucket $e --output json --query "[sum(Contents[].Size), length(Contents[])]"  ; done

aws iam list-server-certificates
aws iam upload-server-certificate --server-certificate-name some_wild_pizza --certificate-body file://pizza.pem --certificate-chain file://cheeze.rand  --private-key file://salami.key

#### find instances
aws ec2 describe-instances  | grep IAMINSTANCEPROFILE | grep rabbit
aws ec2 describe-instances  --instance-ids i-xzxzxxzxzxxzxzxzx 
aws ec2 describe-instances  --instance-ids i-xzxzxxzxzxxzxzxzx | grep SECURITYGROUPS

#### security groups
aws ec2 describe-security-groups
aws ec2 describe-security-groups | grep rabbit
aws ec2 describe-security-groups --group-id sg-afafafaf

```



