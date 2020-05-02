#!/bin/bash

set -e 

cd env

echo '######################################'
echo "##### Destroy ENV"
echo '######################################'

terraform destroy -auto-approve 