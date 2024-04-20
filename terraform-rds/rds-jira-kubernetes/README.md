### Provision an Amazon RDS for PostgreSQL database instance

```sh
kubectl create ns jira1 
APP_NAMESPACE="jira1"
RDS_DB_USERNAME="jirauser"
RDS_DB_PASSWORD="jira123!"

kubectl create secret generic -n jira1 jira-mysql-creds --from-literal=username="jirauser" --from-literal=password="jira123!"

### Add the helm chat 
helm repo add atlassian-data-center \
  https://atlassian.github.io/data-center-helm-charts
helm repo update

### Install Jira 
helm install jira atlassian-data-center/jira -n "${APP_NAMESPACE}" \
  --version="${JIRA_VERSION}" --values=jira.yaml

### You can get the name of the endpoint to access Jira in your web browser using the following command:
kubectl get ingress -n "${APP_NAMESPACE}" jira \
  -o jsonpath='{.status.loadBalancer.ingress[0].hostname}'