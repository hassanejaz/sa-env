#!/bin/bash

set -e 

cd env

echo '######################################'
echo "##### Building ENV"
echo '######################################'
terraform init 
terraform validate 
terraform plan 
terraform apply -auto-approve 
terraform output  > output.txt 