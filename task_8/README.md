

  
##  Grafana Installation
####  **Install Grafana with the Helm Chart by Bitnami**
1.  **Add the Bitnami Helm Repository**:
```bash
helm repo add bitnami https://charts.bitnami.com/bitnami helm repo update
```

2.  **Install Grafana**:
```bash
helm install grafana bitnami/grafana \ 
--namespace monitoring \
--create-namespace \
--set admin.password=yourpassword \
--set service.type=NodePort
```
3.  **Verify Installation**:
```bash
kubectl get pods -n monitoring
```
####  **Access Grafana**

* Check the Grafana service for the NodePort :
```bash
kubectl get svc -n monitoring
```

* * *

###  **Configure Grafana**
####  **Add a Data Source for Prometheus**
1. Log in to Grafana using the admin user credentials (`admin` and the password set above).
2. Navigate to **Configuration > Data Sources > Add Data Source**.
3. Select **Prometheus**, and configure the URL to point to your Prometheus service:
`http://<prometheus-service-name>:<port>`
4. Click **Save & Test** to confirm the configuration.
* * *
###   Create a Dashboard 
####  **Dashboard Metrics**
*  **Create a new Dashboard**:
* Navigate to **Create > Dashboard > Add a New Panel**.
* Add the following metrics:
*  **CPU Utilization**: `node_cpu_seconds_total`
*  **Memory Usage**: `node_memory_MemAvailable_bytes` and `node_memory_MemTotal_bytes`
*  **Customize Panels**:
* Add titles and proper labels for each panel.
* Use visualization options like graphs, singlestats, and gauges for better presentation.
*  **Save the Dashboard** and export its JSON layout:


##  Install promotheus for kubernetes metrics and node exporter
Step 1: Set up a Kubernetes cluster

Step 2: Create a namespace

-   Open your terminal or command prompt.
-   Run the following command to create a namespace for Prometheus:

```bash
kubectl create namespace monitoring

```

Step 3: Create a Prometheus configuration file

-   Create a file named `prometheus-config.yaml` and open it.
-   Add the following YAML configuration to the file:

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: prometheus-server-conf
  namespace: monitoring
data:
  prometheus.yml: |
    global:
      scrape_interval: 15s
      evaluation_interval: 15s
    scrape_configs:
      - job_name: 'prometheus'
        static_configs:
          - targets: ['localhost:9090']

```

Step 4: Apply the Prometheus configuration
-   Run the following command to apply the Prometheus configuration:

```bash
kubectl apply -f prometheus-config.yaml -n prometheus

```
Step 5: Create a Prometheus deployment

-   Create a file named `prometheus-deployment.yaml` and open it.
-   Add the following YAML configuration to the file:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: prometheus-server
  namespace: monitoring
spec:
  replicas: 1
  selector:
    matchLabels:
      app: prometheus-server
  template:
    metadata:
      labels:
        app: prometheus-server
    spec:
      containers:
        - name: prometheus
          image: prom/prometheus
          ports:
            - containerPort: 9090
          volumeMounts:
            - name: config-volume
              mountPath: /etc/prometheus
      volumes:
        - name: config-volume
          configMap:
            name: prometheus-server-conf
            defaultMode: 420

```

Step 6: Apply the Prometheus deployment

-   Run the following command to apply the Prometheus deployment:

```bash
kubectl apply -f prometheus-deployment.yaml -n prometheus
```

Step 7: Expose Prometheus as a service
-   Create a file named `prometheus-service.yaml` and open it.
-   Add the following YAML configuration to the file:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: prometheus-service
  namespace: monitoring
spec:
  selector:
    app: prometheus-server
  ports:
    - protocol: TCP
      port: 80
      targetPort: 9090
  type: LoadBalancer

```

Step 8: Apply the Prometheus service
-   Run the following command to apply the Prometheus service
```bash
kubectl apply -f prometheus-service.yaml -n monitoring
```

Step 9: Access Prometheus
-   Run the following command to get the external IP address of the Prometheus service:
```bash
kubectl get service prometheus-service -n monitoring
```

Congratulations! You have successfully installed Prometheus on Kubernetes. You can access Prometheus by using the external IP address obtained in Open a web browser and navigate to `http://<EXTERNAL_IP_ADDRESS>:80` to access the Prometheus web interface.

### Install NodeExporter to promotheus

create `node-exporter.yaml` file and add this config:

```yaml
apiVersion: apps/v1
kind: DaemonSet
metadata:
  labels:
    app: node-exporter
  name: node-exporter
  namespace: monitoring
spec:
  selector:
    matchLabels:
      app: node-exporter
  template:
    metadata:
      annotations:
        cluster-autoscaler.kubernetes.io/safe-to-evict: "true"
      labels:
        app: node-exporter
    spec:
      containers:
      - name: node-exporter
        image: quay.io/prometheus/node-exporter:v1.6.0
        imagePullPolicy: IfNotPresent
        args:
        - --web.listen-address=0.0.0.0:9100
        - --path.procfs=/host/proc
        - --path.sysfs=/host/sys
        ports:
        - name: metrics
          containerPort: 9100
          protocol: TCP
        resources:
          limits:
            cpu: 200m
            memory: 50Mi
          requests:
            cpu: 100m
            memory: 30Mi
        volumeMounts:
        - name: proc
          mountPath: /host/proc
          readOnly: true
        - name: sys
          mountPath: /host/sys
          readOnly: true
      hostNetwork: true
      hostPID: true
      restartPolicy: Always
      tolerations:
      - effect: NoSchedule
        operator: Exists
      - effect: NoExecute
        operator: Exists
      volumes:
      - name: proc
        hostPath:
          path: /proc
      - name: sys
        hostPath:
          path: /sys
---
apiVersion: apps/v1
kind: DaemonSet
metadata:
  labels:
    app: node-exporter
  name: node-exporter
  namespace: monitoring
spec:
  selector:
    matchLabels:
      app: node-exporter
  template:
    metadata:
      annotations:
        cluster-autoscaler.kubernetes.io/safe-to-evict: "true"
      labels:
        app: node-exporter
    spec:
      containers:
      - name: node-exporter
        image: quay.io/prometheus/node-exporter:v1.6.0
        imagePullPolicy: IfNotPresent
        args:
        - --web.listen-address=0.0.0.0:9100
        - --path.procfs=/host/proc
        - --path.sysfs=/host/sys
        ports:
        - name: metrics
          containerPort: 9100
          protocol: TCP
        resources:
          limits:
            cpu: 200m
            memory: 50Mi
          requests:
            cpu: 100m
            memory: 30Mi
        volumeMounts:
        - name: proc
          mountPath: /host/proc
          readOnly: true
        - name: sys
          mountPath: /host/sys
          readOnly: true
      hostNetwork: true
      hostPID: true
      restartPolicy: Always
      tolerations:
      - effect: NoSchedule
        operator: Exists
      - effect: NoExecute
        operator: Exists
      volumes:
      - name: proc
        hostPath:
          path: /proc
      - name: sys
        hostPath:
          path: /sys
---
apiVersion: monitoring.coreos.com/v1
kind: ServiceMonitor
metadata:
  labels:
    app: node-exporter
  name: node-exporter
  namespace: monitoring
spec:
  endpoints:
  - interval: 30s
    path: /metrics
    port: metrics
  selector:
    matchLabels:
      app: node-exporter
  namespaceSelector:
    matchNames:
    - monitoring


```

then

```yaml
kubectl apply -f node-exporter.yaml
```

Add scrape configs to promoteus config

```yaml
yaml
scrape_configs:
  - job_name: 'kube-state-metrics'
    static_configs:
      - targets: ['kube-state-metrics.kube-system.svc.cluster.local:8080']

  - job_name: 'node-exporter'
    static_configs:
      - targets: ['node-exporter:9100']


```

then
```yaml
kubectl apply -f prometheus-config.yaml kubectl rollout restart deployment/prometheus-server -n monitoring
```