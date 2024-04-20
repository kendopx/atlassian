
### The config for VPC is found here. It creates:

1. A VPC
2. Two subnets
3. A Terraform security group with public ingress settings

```sh
helm repo add atlassian-data-center https://atlassian.github.io/data-center-helm-charts
helm repo update

helm show values atlassian-data-center/jira > values.yaml
helm install jira atlassian-data-center/jira -f values.yaml -n jira

helm install confluence atlassian-data-center/confluence -n atlassian
helm install jira atlassian-data-center/jira  -n atlassian -f jira-values.yaml 
helm uninstall jira  -n atlassian 

kubectl patch svc jira -n atlassian -p '{"spec": {"type": "LoadBalancer"}}' > /dev/null 2>&1 
kubectl patch svc confluence -n atlassian -p '{"spec": {"type": "LoadBalancer"}}' > /dev/null 2>&1 
kubectl get pod -n atlassian 
kubectl get svc -n atlassian 

helm get values jira -n atlassian
export POD_NAME=$(kubectl get pods --namespace atlassian -l "app.kubernetes.io/instance=jira" -o jsonpath="{.items[0].metadata.name}")
echo POD_NAME: $POD_NAME && echo POD_STATUS: $(kubectl get pod $POD_NAME -o jsonpath='{.status.phase}')
kubectl --namespace atlassian port-forward $POD_NAME 8080

Could not find driver with class name: com.mysql.cj.jdbc.Driver


http://localhost:8080


http://localhost:8080

aws s3 mb s3://atlassian-project

https://github.com/sumeetninawe/tf-rds.git

aws rds describe-db-instances --db-instance-identifier jiradb | jq '.DBInstances[].Endpoint.Address'
aws elb describe-tags --load-balancer-name xxxx | jq '.TagDescriptions[].LoadBalancerName'

aws rds describe-db-engine-versions \
  --engine mysql \
  --engine-version version-number \
  --query "DBEngineVersions[*].ValidUpgradeTarget[*].{EngineVersion:EngineVersion}" --output text