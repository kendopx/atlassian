
### The config for VPC is found here. It creates:

eksctl create cluster --name dev-cluster  --node-type t3a.xlarge
kubectl get nodes
aws eks list-clusters

eks update-kubeconfig --name demo-cluster 
eksctl delete cluster  --name demo-cluster

```sh
helm repo add atlassian-data-center https://atlassian.github.io/data-center-helm-charts
helm repo update

helm upgrade -i jira atlassian-data-center/jira --namespace jira --create-namespace --values values.yaml

kubectl create ns jira
helm install jira atlassian-data-center/jira  -n jira -f 1_jira-values.yaml 
kubectl describe po jira-0 -n jira
kubectl get po -n jira
kubectl get svc -n jira
kubectl get ing -n jira

helm uninstall jira -n jira
kubectl delete ns jira 

 export POD_NAME=$(kubectl get pods --namespace jira -l "app.kubernetes.io/instance=jira" -o jsonpath="{.items[0].metadata.name}")
 echo POD_NAME: $POD_NAME && echo POD_STATUS: $(kubectl get pod $POD_NAME -o jsonpath='{.status.phase}')
 kubectl --namespace jira port-forward $POD_NAME 8080
 http://localhost:8080

helm fetch atlassian-data-center/jira --untar 

helm install jira atlassian-data-center/jira  -n jira -f 1_jira-values.yaml 
kubectl patch svc jira -n jira -p '{"spec": {"type": "LoadBalancer"}}' > /dev/null 2>&1 
kubectl get pod -n jira
kubectl get svc -n jira
kubectl get ing -n jira

helm get values jira -n atlassian
export POD_NAME=$(kubectl get pods --namespace atlassian -l "app.kubernetes.io/instance=jira" -o jsonpath="{.items[0].metadata.name}")
echo POD_NAME: $POD_NAME && echo POD_STATUS: $(kubectl get pod $POD_NAME -o jsonpath='{.status.phase}')
kubectl --namespace atlassian port-forward $POD_NAME 8080

Could not find driver with class name: com.mysql.cj.jdbc.Driver
http://localhost:8080

aws s3 mb s3://atlassian-project
https://github.com/sumeetninawe/tf-rds.git

aws rds describe-db-instances --db-instance-identifier jiradb | jq '.DBInstances[].Endpoint.Address'
aws elb describe-tags --load-balancer-name xxxx | jq '.TagDescriptions[].LoadBalancerName'

aws rds describe-db-engine-versions \
  --engine mysql \
  --engine-version version-number \
  --query "DBEngineVersions[*].ValidUpgradeTarget[*].{EngineVersion:EngineVersion}" --output text

  ### Uninstall
  helm uninstall jira -n atlassian
  helm uninstall confluence -n atlassian

### login to pod 
kubectl -n atlassian exec -it jira-0 -- /bin/bash

### Copy from local to pod 
kubectl cp mysql-connector-j-8.3.0.jar -n atlassian jira-0:/opt/atlassian/jira/lib

  kubectl exec -i -t --container jira-0  -- /bin/bash -n atlassian
kubectl exec -it cassandra -- sh
kubectl exec --stdin --tty aks-helloworld-one-56c7b8d79d-xqx5t -- /bin/bash
kubectl exec -i -t jira-0 --container <container name> -- /bin/bash

### Restart Kubernetes Pods With Kubectl

## Restart a pod

## Method 1
kubectl rollout restart
kubectl rollout restart deployment <deployment_name> -n <namespace>

### Method 2
kubectl scale
kubectl scale deployment <deployment name> -n <namespace> --replicas=0

### Method 3
kubectl delete pod and kubectl delete replicaset

### Each pod can be deleted individually if required:
kubectl delete pod <pod_name> -n <namespace>


kubectl get pod jira-0 -n atlassian -o yaml | kubectl replace --force -f -


Review the prerequisites for Cluster Autoscaler
Create an EKS cluster in AWS
Create IAM OIDC provider
Create IAM policy for Cluster Autoscaler
Create IAM role for Cluster Autoscaler
Deploy Kubernetes Cluster Autoscaler
Create an Nginx deployment to test the CA functionality