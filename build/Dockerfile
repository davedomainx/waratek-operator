#FROM quay.io/operator-framework/ansible-operator:v0.15.0
FROM registry.access.redhat.com/ubi8/ubi

### Required OpenShift Labels
LABEL name="Waratek Operator" \
      vendor="Waratek Ltd" \
      version="1.0.0" \
      release="1" \
      summary="Waratek Operator" \
      description="Waratek Operator is a foundation for deploying the Waratek security suite of products."

# Required Licenses
COPY licenses /licenses

COPY watches.yaml ${HOME}/watches.yaml

COPY roles/ ${HOME}/roles/
