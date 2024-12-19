**Prometheus Deployment on Kubernetes with Helm**

This guide provides the steps for deploying Prometheus with Helm on a Kubernetes cluster, along with the installation of Node Exporter for system metrics collection.

### Prerequisites

Before you begin, ensure you have the following:

*   A running Kubernetes cluster.
*   `kubectl` configured to access the cluster.
*   `Helm` installed on your local machine.
*   Sufficient permissions to deploy resources on the cluster.

### 1\. Prometheus Installation

**Add Prometheus Helm Chart Repository**

First, you need to add the Prometheus Helm chart repository. Run the following commands to add the repository and update your Helm charts:

 

```bash
kubectl create ns monitoring
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts  
helm repo update  
```

This will add the Prometheus community charts to your Helm repositories.

**Install Prometheus Using Helm**

To install Prometheus along with the `kube-prometheus-stack`, run the following command:

```bash
helm install prometheus prometheus-community/kube-prometheus-stack -n monitoring
```
 
 This will deploy Prometheus, Alertmanager, and Grafana, along with the necessary configurations for monitoring Kubernetes resources.

### 2\. Install Node Exporter with Helm

Prometheus can collect system metrics using the **Node Exporter**.

**Install Node Exporter Using Helm**

To install Node Exporter, which exposes system metrics like CPU usage, memory usage, and disk I/O, run the following command:


```bash
helm install node-exporter prometheus-community/prometheus-node-exporter -n monitoring
```

Prometheus will automatically discover the Node Exporter instance and start scraping the metrics. The Helm chart automatically configures Prometheus to scrape the Node Exporter metrics.

### 3\. Verify Metrics Collection

**Check Pods Status**

To verify that Prometheus and Node Exporter are running properly, you can use the following command:


```bash
kubectl get pods -n monitoring
```

Ensure that all Prometheus-related pods are in the **Running** state.

**Access Prometheus Web Interface**

To access the Prometheus web interface, use port forwarding. Run the following command:


 

```bash
kubectl port-forward svc/prometheus-operated 9090:9090 -n monitoring
``` 

You can now access the Prometheus web interface at `http://localhost:9090`. From here, you can query metrics and configure alerts.

### 4\. Documentation

**Metrics Collected**

Prometheus will collect various metrics, including but not limited to:

*   Kubernetes cluster metrics (pods, nodes, deployments, etc.)
*   System metrics (CPU, memory, disk usage) from Node Exporter.

**Troubleshooting**

*   If you cannot access the Prometheus interface, ensure that your Kubernetes cluster is running and the port-forwarding command is executed correctly.
*   If the pods are not running, check the logs of the Prometheus and Node Exporter pods for any errors.

### Conclusion

You have successfully deployed Prometheus with Helm on Kubernetes, along with Node Exporter for system metrics collection. You can now use Prometheus to monitor your Kubernetes cluster and system performance.