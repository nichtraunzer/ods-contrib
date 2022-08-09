#!/bin/bash

##################################################
## This script can be used to set required environment
## paramaters for the Terraform backend in order to
## use the AWS Quickstarter outside of ODS.
###################################################
# params:
#   PROJECT
#   COMPONENT
#   ENVIRONEMT
#

while [[ $# -gt 0 ]]; do
  key="$1"

  case $key in
    -p|--project)
      PROJECT="$2"
      shift; shift
      ;;
    -c|--component)
      COMPONENT="$2"
      shift; shift
      ;;
    -e|--environment)
      ENVIRONMENT="$2"
      shift; shift
      ;;
    *)    # unknown option
      exit 1
     ;;
  esac
done


ACCOUNT=$(aws sts  get-caller-identity --output text)
set -- $ACCOUNT

export TF_BACKEND_PREFIX=$1
export TF_BACKEND_S3KEY=$1/$PROJECT/$COMPONENT/$ENVIRONMENT
export TF_WORKSPACE=DEVELOPMENT
export INSTALL_REPORT_HOME=.

echo "TF_BACKEND_PREFIX="$TF_BACKEND_PREFIX
echo "TF_BACKEND_S3KEY ="$TF_BACKEND_S3KEY

