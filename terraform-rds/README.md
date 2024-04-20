```sh
EKS_CLUSTER_NAME="<your cluster name>"
REGION="<your region>"

eksctl create cluster \
  --name "${EKS_CLUSTER_NAME}" \
  --region "${REGION}" \
  --with-oidc \
  --instance-selector-vcpus 4 \
  --instance-selector-memory "8Gi"
```