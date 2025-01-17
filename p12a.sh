#!/bin/bash
#----------------------------------------------------start--------------------------------------------------#
read -p "Enter ZONE: " ZONE

export REGION="${ZONE%-*}"
export PROJECT_ID=$(gcloud config get-value project)
export PROJECT_NUMBER=$(gcloud projects describe $PROJECT_ID --format='value(projectNumber)')
gcloud config set compute/region $REGION

gcloud services enable \
  cloudresourcemanager.googleapis.com \
  container.googleapis.com \
  artifactregistry.googleapis.com \
  containerregistry.googleapis.com \
  containerscanning.googleapis.com

sleep 10

git clone https://github.com/GoogleCloudPlatform/cloud-code-samples/
cd ~/cloud-code-samples

gcloud container clusters create container-dev-cluster --zone=$ZONE

gcloud artifacts repositories create container-dev-repo --repository-format=docker \
  --location=$REGION \
  --description="Docker repository for Container Dev Workshop"

gcloud auth configure-docker $REGION-docker.pkg.dev

cd ~/cloud-code-samples/java/java-hello-world

docker build -t $REGION-docker.pkg.dev/$PROJECT_ID/container-dev-repo/java-hello-world:tag1 .

docker push $REGION-docker.pkg.dev/$PROJECT_ID/container-dev-repo/java-hello-world:tag1

cd ~/cloud-code-samples/
cloudshell workspace .

echo "Open Editor -> Cloud Code -> Compute Engine Dropdown -> Select Project"
echo " "
echo "3lines -> View -> Command Palette -> Run on Kubernetes"
echo " "
echo "java/java-hello-world/skaffold.yaml -> Wait..."
echo " "
echo "dockerfile -> Yes -> Enter the address of repo as below"
echo " "
echo "Region: ${REGION}"
echo "Project_ID: ${PROJECT_ID}"
echo " "
echo "REGION-docker.pkg.dev/PROJECT_ID/container-dev-repo"
echo " "
echo "Wait for deploy to complete" 

echo "Execute p12b. sh"
