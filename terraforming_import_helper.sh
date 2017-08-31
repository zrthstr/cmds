#!/bin/bash
## this script imports AWS resources into terraform
## creating both the terraform.tfstater and the *.tf files

set -e

profile='--profile=xxx'
#profile=''

#all_cmds="alb asg cwa dbpg dbsg dbsn ec2 ecc ecsn efs eip elb iamg iamgm iamgp iamip iamp iampa iamr iamrp iamu iamup igw kmsa kmsk lc nacl nat nif r53r r53z rds rs rt rta s3 sg sn sqs vgw vpc"

## no r53r in here, we have to start with one manally
all_cmds="alb asg cwa dbpg dbsg dbsn ec2 ecc ecsn efs eip elb iamg iamgm iamgp iamip iamp iampa iamr iamrp iamu iamup igw kmsa kmsk lc nacl nat nif r53z rds rs rt rta s3 sg sn sqs vgw vpc"


if [ -f terraform.tfstate ]
then
    mv terraform.tfstate terraform.tfstate_bu_`date +%s`
fi


terraforming r53r $profile > r53r.tf
terraforming r53r $profile --tfstate > terraform.tfstate


for cmd in $all_cmds; do
    file=${cmd}.tf.out
    echo "### getting: $cmd. Saving to file: $file"

    ### avoid having 1Byte only newline containing files
    terraforming $cmd $profile | sed '/^$/d' > $file

    ### rm empty out_file
    if [ ! -s $file ]
    then
        ls -lah
        rm  $file
    else
        terraforming $cmd $profile --tfstate --merge=terraform.tfstate > ${cmd}_tmp
        mv ${cmd}_tmp terraform.tfstate
    fi
done
