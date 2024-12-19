# Prometheus and Alert Manager Setup

This document describes the setup and configuration of Prometheus monitoring system with Alert Manager for email notifications.
I configure with Helm.

## Setup Overview

The monitoring stack consists of:
- Prometheus Server for metrics collection and alerting
- Alert Manager for handling and routing alerts
- Node Exporter for collecting host metrics
- Kube State Metrics for Kubernetes cluster metrics

## Alert Configuration

### CPU Usage Alerts

Two main alerts are configured:

1. **High CPU Utilization**
   - Triggers when CPU usage is over 80% for 1 minute
   - Severity: Warning
   - Alert Rule:
     ```yaml
     - alert: HighCpuUtilization
       expr: sum(rate(node_cpu_seconds_total{mode!="idle"}[2m])) / sum(machine_cpu_cores) > 0.8
       for: 1m
       labels:
         severity: warning
       annotations:
         summary: "High CPU utilization detected on node {{ $labels.instance }}"
         description: "Node {{ $labels.instance }} is using over 80% CPU for the last 1 minute."
     ```

2. **CPU Cores Capacity Exhausted**
   - Triggers when available CPU cores are less than 1
   - Severity: Critical
   - Alert Rule:
     ```yaml
     - alert: CpuCoresCapacityExhausted
       expr: sum(machine_cpu_cores) - sum(rate(node_cpu_seconds_total{mode!="idle"}[2m])) < 1
       for: 1m
       labels:
         severity: critical
       annotations:
         summary: "CPU cores capacity almost exhausted on node {{ $labels.instance }}"
         description: "Node {{ $labels.instance }} has less than 1 cores available for allocation."
     ```

## Notification Configuration

### Email Notifications
- SMTP Configuration:
  - Server: your smtp server
  - From: your@mail.com
  - To: your@mail.com
  - TLS: Enabled
  - Authentication: Required



## Alert Routing

Alerts are routed based on severity:
- Critical alerts are sent to email
- Warning alerts follow the same routing

## Alert Manager Configuration

```yaml
global:
  resolve_timeout: 1m
  smtp_smarthost: smpt:587
  smtp_from: your@mail.com
  smtp_auth_username: username
  smtp_auth_identity: uauth
  smtp_require_tls: true

route:
  group_wait: 10s
  group_interval: 5m
  repeat_interval: 3h
  receiver: gmail-notifications
  routes:
    - match:
        severity: critical
      receiver: gmail-notifications
```

## Deployment

The setup is deployed using Helm:

```bash
helm install prometheus prometheus-community/prometheus -f values.yaml
```

## Accessing the Interfaces

- Prometheus UI: `kubectl port-forward prometheus-server-XXXXX 9090:9090`
- Alert Manager UI: `kubectl port-forward prometheus-alertmanager-0 9093:9093`

## Testing Alerts

To test the CPU alerts:
1. Deploy a CPU-intensive workload
2. Monitor Alert Manager UI for triggered alerts
3. Check configured email for notifications
