
# An assignment for Discount bank - Rachel

## Step one:
- I authenticated with my Azure account using the command:
```
az login
```
- I created an AKS module in my project:
```

## Aks cluster

resource "azurerm_kubernetes_cluster" "aks_discount_cluster" {
  name                = var.cluster_name
  location            = var.cluster_location
  resource_group_name = var.rg_name
  dns_prefix          = var.dns_prefix

  default_node_pool {
    name       = var.node_pool_name
    node_count = 1
    vm_size    = var.d_vmsize  # Smallest possible machine size

    os_disk_size_gb = 30
  }

  service_principal {
    client_id     = var.client_id
    client_secret = var.client_secret
  }
}
```
- Initialization Terraform: I opened a terminal or command prompt, navigated to the setup directory and run the following command:
```
terraform init
```
This command initializes Terraform and downloads the necessary Azure provider plugins.


- To apply the Terraform configuration: I Ran the following command to apply the Terraform configuration and create the AKS cluster:
``` 
terraform apply

```
I Confirmed the execution by typing `yes` and pressing Enter

## Step two

- I Configured `kubectl` to connect to the cluster: To connect my local environment to the newly created AKS cluster using `kubectl`, I ran the following command in my terminal or command prompt:

```
az aks get-credentials --resource-group discount_rg --name aks-cluster
```

This command retrieves the cluster credentials and merges them into my local `kubectl` configuration.

- Verifying the connection: I Ran the following command to verify the connection to the AKS cluster
```
kubectl get nodes
```

I saw the details of the single node in my AKS cluster.

## Step three

- Initialization Helm: I Ran the following command to initialize Helm in my local environment:

  ```
  helm init
  ```

  This set up the necessary components in the AKS cluster to use Helm.

- Verifying Helm installation: I Ran the following command to verify that Helm is correctly installed and configured:

  ```
  helm version
  ```

  I saw the client and server versions of Helm displayed.

## Step four

- Identifying a Helm chart for a simple open-source application: I deployed a basic HTTP server called "httpbin" using a Helm chart. The httpbin chart is available in the official Helm repository and provides a simple HTTP request/response service.

- Search for the httpbin Helm chart: I Ran the following command to search for the httpbin chart in the Helm stable repository:

  ```
  helm search repo httpbin
  ```
  I saw the httpbin chart listed.
- I Added the official Helm stable repository by running the following command:
  ```
  helm repo add stable https://charts.helm.sh/stable
  ```


- Installing the httpbin Helm chart: I used the following command to install the httpbin Helm chart:
  ```
  helm install httpbin stable/httpbin
  ```
  This command deployed the httpbin application in my AKS cluster using the Helm chart.

- Verifying the deployment: I ran the following command to check the status of the httpbin deployment:

  ```
  kubectl get deployments
  ```

  I saw the httpbin deployment listed, along with other details like the number of replicas and current status.
## Step five

- I Listed the available Helm releases by running the following command:
  ```
  helm list
  ```

- I Identified the release name of the httpbin application I deployed.

- I upgraded the application using Helm by executing the following command:
  ```
  helm upgrade httpbin stable/httpbin
  ```
  This command upgrades the httpbin application to the latest version available in the Helm repository.
- I Verified the upgrade by running the following command:
  ```
  kubectl get deployments
  ```
  I ensured that the httpbin deployment is running and updated to the new version.

## Step six

To ensure that the httpbin application is functioning correctly after the upgrade, I performed the following checks:

- I checked the status of the httpbin deployment by running the following command:

  ```
  kubectl get deployments
  ```
  I verified that the deployment has the desired number of replicas and that they are running and ready.
- I accessed the httpbin service by obtaining the service URL. I ran the following command:

  ```
  kubectl get service httpbin-httpbin
  ```
- I noted down the External IP of the service
- I sent HTTP requests to the httpbin server using web browser
- I ensured that I receive valid HTTP responses from the httpbin server.
- I inspected the httpbin server logs and any associated application logs using commands like kubectl logs to check for any errors or anomalies.


## Step seven

- To increase the number of application instances and ensure that the configuration persists even if the application is redeployed, I needed to modify the Helm release's values.

- I ran the following command to retrieve the release's values:
  ```
  helm get values httpbin
  ```
  This command display the current configuration values for the httpbin release.
Modify the values:
- I edited the values file to increase the number of application instances. I created a file named httpbin-values.yaml and add the following content:
  ```
  replicaCount: 3
  ```
  I set the replicaCount to 3, which will create three instances of the httpbin application.

Upgrading the Helm release:
- I ran the following command to upgrade the Helm release with the modified values:
  ```
  helm upgrade httpbin stable/httpbin -f httpbin-values.yaml
  ```
  This command upgrades the httpbin release using the new values file.
Verify the application instances:
- I ran the following command to check the status and number of application instances:
  ```
  kubectl get pods
  ```
  This command display the pods running in my cluster. I saw multiple instances of the httpbin application.

## Step eight

- I deleted the application release from the Kubernetes cluster using Helm:
  ```
  helm uninstall httpbin
  ```

- After the release is deleted, I ran the following command to delete the AKS cluster using Terraform:
  ```
  terraform destroy
  ```

  This command removed all the resources created by Terraform, including the AKS cluster.

