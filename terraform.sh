#!/bin/bash

WORKSPACE=$1
ACTION=${2:-plan} # def action for now


#validating the workspace
if [[ ! "$WORKSPACE" =~ ^(dev|prod)$ ]]; then 
    echo "Invalid workspace. must be dev or prod"
    exit 1
fi

# Check if the tfvars file existss

if [[ ! -f "environments/${WORKSPACE}.tfvars" ]]; then
    echo "Environment file not found in environments/${WORKSPACE}.tfvars not found"
    exit 1
fi

terraform workspace select $WORKSPACE || terraform workspace new $WORKSPACE

case $ACTION in 
    plan)
        terraform plan -var-file="environments/${WORKSPACE}.tfvars"
        ;;
    apply) 
        terraform apply -var-file="environments/${WORKSPACE}.tfvars" -auto-approve
        ;;
    destroy) 
        terraform destroy -var-file="environments/${WORKSPACE}.tfvars" -auto-approve
        ;;
    *)
        echo "Invalid actions. must be one of plan destroy or apply"
        exit 1
        ;;
esac

