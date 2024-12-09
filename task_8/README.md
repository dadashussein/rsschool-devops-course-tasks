Grafana Installation (30 Points)
Install Grafana with the Helm Chart by Bitnami
Add the Bitnami Helm Repository:

bash
Copy code
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
Install Grafana:

bash
Copy code
helm install grafana bitnami/grafana \
  --namespace monitoring \
  --create-namespace \
  --set admin.password=yourpassword \
  --set service.type=LoadBalancer
Verify Installation:

bash
Copy code
kubectl get pods -n monitoring
Access Grafana
Check the Grafana service for the external IP:
bash
Copy code
kubectl get svc -n monitoring
Access Grafana using the external IP and port (default: 3000).
2. Configure Grafana
Add a Data Source for Prometheus
Log in to Grafana using the admin user credentials (admin and the password set above).
Navigate to Configuration > Data Sources > Add Data Source.
Select Prometheus, and configure the URL to point to your Prometheus service:
bash
Copy code
http://<prometheus-service-name>:<port>
Click Save & Test to confirm the configuration.
3. Create a Dashboard (40 Points)
Dashboard Metrics
Create a new Dashboard:

Navigate to Create > Dashboard > Add a New Panel.
Add the following metrics:
CPU Utilization: node_cpu_seconds_total
Memory Usage: node_memory_MemAvailable_bytes and node_memory_MemTotal_bytes
Storage Usage: node_filesystem_avail_bytes and node_filesystem_size_bytes
Customize Panels:

Add titles and proper labels for each panel.
Use visualization options like graphs, singlestats, and gauges for better presentation.
Save the Dashboard and export its JSON layout:

Navigate to the dashboard settings, click Share > Export > Save to file.