# syslog-ng

## Example

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: syslog-ng-forwarder
  namespace: prometheus
  labels:
    app: syslog-ng-forwarder
spec:
  replicas: 1
  selector:
    matchLabels:
      app: syslog-ng-forwarder
  template:
    metadata:
      labels:
        app: syslog-ng-forwarder
    spec:
      containers:
        - name: syslog-ng
          image: ghcr.io/mathiasringhof/syslog-ng:main
          ports:
            - name: sophos-udp
              containerPort: 1514
              protocol: UDP
            - name: unifi-udp
              containerPort: 1515
              protocol: UDP
            - name: cameras-udp
              containerPort: 1516
              protocol: UDP
          volumeMounts:
            - name: config-volume
              mountPath: /etc/syslog-ng/syslog-ng.conf
              subPath: syslog-ng.conf
          resources:
            limits:
              memory: 512Mi
              cpu: 500m
            requests:
              memory: 128Mi
              cpu: 100`
      volumes:
        - name: config-volume
          configMap:
            name: syslog-ng-config
```