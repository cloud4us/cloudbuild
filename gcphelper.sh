#!/bin/bash

#set Google variables
export PROJECT_ID=blog-cloud4us
export ZONE="compute/zone us-central1-a"
export REGION="compute/region us-central1"
gcloud config set project ${PROJECT_ID}
gcloud config set ${ZONE}
gcloud config set ${REGION}

export GIT_EMAIL=blogcloud4us@gmail.com
export RSA_FILE="cloud4us_id_rsa"
export RSA_KEY=${HOME}/.ssh/${RSA_FILE}
echo $RSA_KEY
export RSA_PUB_KEY="${HOME}/.ssh/${RSA_FILE}.pub"

# Generate rsa pair with an empty paraphrase
ssh-keygen -t rsa -b 4096 -C ${GIT_EMAIL} -f ${RSA_KEY} -q -N ""

# start ssh-agent add generated key to ssa agent
eval $(ssh-agent -s)
ssh-add ${RSA_PUB_KEY}

# output the public key to be added to github.com
cat ${RSA_PUB_KEY}

# Enable Cloud Key Management Service (KMS)
gcloud services enable cloudkms.googleapis.com

#Enable Cloud Build
gcloud services enable  cloudbuild.googleapis.com 

# We need to encrypt our ssh key so nobody can use it
# except us. We will use KMS service for that
# create an encryption key
# 1. Create a ring
gcloud kms keyrings create my-keyring  --location=global
# 2. Create a key
gcloud kms keys create github-key --location=global --keyring=my-keyring --purpose=encryption
echo RSA_KEY: ${RSA_KEY}
gcloud kms encrypt --plaintext-file=${RSA_KEY} \
--ciphertext-file=./${RSA_FILE}.enc --location=global \
--keyring=my-keyring --key=github-key

ssh-keyscan -t rsa github.com > known_hosts


 