#!/bin/bash
#----------------------------------------------------start--------------------------------------------------#

export REGION="${ZONE%-*}"

gcloud artifacts repositories create container-dev-java-repo \
    --repository-format=maven \
    --location=$REGION \
    --description="Java package repository for Container Dev Workshop"

#-----------------------------------------------------end----------------------------------------------------------#
