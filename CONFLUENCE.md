
### DB requirements

```sh
https://confluence.atlassian.com/doc/database-setup-for-sql-server-9258.html
Microsoft JDBC Driver for SQL Server

helm repo add atlassian-data-center https://atlassian.github.io/data-center-helm-charts
helm repo update
helm install confluence atlassian-data-center/confluence -n atlassian confluence-values.yaml 

```sh
export POD_NAME=$(kubectl get pods --namespace atlassian -l "app.kubernetes.io/instance=confluence" -o jsonpath="{.items[0].metadata.name}")
echo POD_NAME: $POD_NAME && echo POD_STATUS: $(kubectl get pod $POD_NAME -o jsonpath='{.status.phase}')
kubectl --namespace atlassian port-forward $POD_NAME 8090
http://localhost:8090

aws rds describe-db-instances --db-instance-identifier jiradb | jq '.DBInstances[].Endpoint.Address'


### LB
kubectl patch svc confluence -n atlassian -p '{"spec": {"type": "LoadBalancer"}}' > /dev/null 2>&1 
kubectl get pod -n atlassian 
kubectl get svc -n atlassian 
```