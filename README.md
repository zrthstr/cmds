## cmds

### iptables
```
for e in filter nat mangle raw ; do sudo iptables -t $e -L ; done

## really show ALL iptables rules
iptables -vL -t filter
iptables -vL -t nat
iptables -vL -t mangle
iptables -vL -t raw
iptables -vL -t security

iptables-save > <filename>
/sbin/service iptables save 
```


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

### dns stuff
```
### get specific record
dig  -t txt _spf.gmail.com
### show full tree
dig +trace heise.de
### all reccords
dig +nocmd heise.de any  +noall +answer

```
### SElinux
```
ls -Z
restorecon -R -v <file>
```

### network stuff
```
ifconfig -a
ip a
netstat -tulpn
ss -tuna
```


### lvm funn
```
lvmdiskscan

vgdisplay
lvdisplay

lvcreate -L 10G VolGroup00 -n lvolhome /dev/sdc1
vgreduce  --removemissing <vg>
```

### just osx things
```
# pipe to copy+paste buffer
cat fiele_name | pbcopy
# paste again
pbpaste > foo

## show open ports aka. netstat -tulpn 
sudo netstat -atp tcp | grep -i "listen"
sudo lsof -i -P | grep -i "listen"

## set file append only, so chattr +a foo on a sane os 
sudo chflags uappend passwd

# arch    "archived flag"
# opaque  "opaque flag"
# nodump  "nodump flag"
# sappnd  "system append-only flag"
# schg    "system immutable flag"
# uappnd  "user append-only flag"
# uchg    "user immutable flag"

## show .dotfiles in finder
defaults write com.apple.finder AppleShowAllFiles YES
### do so in finder --> CMD + SHIFT + . 

### screen resolution quik changer
https://github.com/avibrazil/RDM

### install aws tools
brew install python3
pip3 install --user --upgrade awscli
# export PATH=~/Library/Python/3.6/bin/:$PATH  

### osx docker
brew services start docker-machine
# docker-machine env default
eval $(docker-machine env default)
docker-machine ssh default

### screen shot
# [command] + [shift] + [3] or [4]

```

### python
```
source virtualenvwrapper.sh
mkvirtualenv $project_name
workon $project_name
virtualenvwrapper_get_python_version
lssitepackages
pip list
pip freeze
lsvirtualenv
echo $VIRTUAL_ENV
deactivate
pip freeze > requirements.txt
pip install -r requirements.txt
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

#### terraform
``` sh
### general tf things
terraform plan -parallelism=2
terraform apply
terraform graph | dot -Tpng > graph.png
terraform import aws_vpc.test_vpc vpc-acabacab

### terraform helpers
# effortless use multiple terraform versions on osx
# https://github.com/Yleisradio/homebrew-terraforms

### tool to generate TF configs and TFstate files from AWS
# https://github.com/dtan4/terraforming
gem install --user-install terraforming
terraforming <s3|vpc|ec2....> [--region=foo]

terraform import aws_route53_record.youroutnamehere  ZXXXXXzonenzmeXXXX_dnsentry.tld_RECCORTYPE

### full terraforming import
terraforming r53r > r.tf
terraforming r53z > z.tf
terraforming r53z --tfstate > z.tfstate
terraforming r53r --tfstate --merge=z.tfstate  > all.tfstate
cat all.tfstate | sed -e 's/\.-/\./g' > all.tfstate_tmp
rm z.tfstate
mv all.tfstate_tmp all.tfstate

### terraforming aws iam_s
terraforming iamg > iamg.tf
terraforming iamgm > iamgm.tf
terraforming iamgp > iamgp.tf
terraforming iamr > iamr.tf
terraforming iamrp | tee iamrp.tf
terraforming iamp | tee iamp.tf
terraforming iampa | tee iampa.tf
terraforming iamu | tee iamu.tf
terraforming iamup | tee iamup.tf

terraforming iamg --tfstate > iamg.tfstate
mv iamg.tfstate terraform.tfstate
terraforming iamgm --overwrite --tfstate --merge=terraform.tfstate
terraforming iamgp --overwrite --tfstate --merge=terraform.tfstate
terraforming iamp --overwrite --tfstate --merge=terraform.tfstate
terraforming iampa --overwrite --tfstate --merge=terraform.tfstate
terraforming iamrp --overwrite --tfstate --merge=terraform.tfstate
terraforming iamr --overwrite --tfstate --merge=terraform.tfstate
terraforming iamu --overwrite --tfstate --merge=terraform.tfstate
terraforming iamup --overwrite --tfstate --merge=terraform.tfstate

terraform output <output>


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

### dns backup from AWS
for domain in $(cli53 list -format json | jq -r '.[].Name' | sed 's/.$//g' ); do cli53 export $domain ; done

```

#### finding fulfillment, meaning and happiness with, through or thus ansible
```
ansible -m ping -i inventory all
ansible all -a "/bin/echo hello"  -i inventory
```
