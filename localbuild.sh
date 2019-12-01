#!/bin/bash
gcloud components install cloud-build-local
cloud-build-local --config=cloudbuild.yaml .