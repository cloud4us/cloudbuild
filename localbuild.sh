#!/bin/bash

#update the cloud build components
gcloud components install cloud-build-local

#submits your build
gcloud builds submit --config cloudbuild.yaml .