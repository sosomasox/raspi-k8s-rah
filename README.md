# raspi-k8s-rah
## Overview
Run Rosetta@home on Kubernetes with Raspberry Pi.  

The Rosetta@home project recently added support for fighting COVID-19.  
https://boinc.bakerlab.org/rosetta/forum_thread.php?id=13702  

I created [Rosetta@home teams](https://boinc.bakerlab.org/rosetta/team.php), which was named [**raspi-k8s-rah**](https://boinc.bakerlab.org/rosetta/team_display.php?teamid=20154).  
If you like, please participate in this team.  

&nbsp;



## Prerequisites
Operation in the following production environment has been verified.  

### Raspberry Pi 4 Model B 2G/4G RAM
 - [ubuntu-18.04.4-preinstalled-server-arm64+raspi3.img](https://ubuntu.com/download/raspberry-pi)

### Docker
 - v19.03.8

### Kubernetes
 - v1.17.5

&nbsp;



## Usage
First of all, you need to edit configmap section on _**"manifests/raspi-k8s-rah.yaml"**_ .  
Please fill in your Rosetta@home account key instead of _**"\<your account key\>"**_ .  

### manifests/raspi-k8s-rah.yaml
```
---

apiVersion: v1
kind: ConfigMap
metadata:
  namespace: raspi-k8s-rah
  name: raspi-k8s-rah-cm
data:
  account_key: <your account key>
  cc_config.conf: |
    <cc_config>
      <log_flags>
        <task>1</task>
        <file_xfer>1</file_xfer>
        <sched_ops>1</sched_ops>
      </log_flags>
      <options>
        <alt_platform>aarch64-unknown-linux-gnu</alt_platform>
      </options>
    </cc_config>
    
---
```

&nbsp;

You can run Rosetta@home on Kubernetes when you issue the following command.  
It runs as a **DeamonSet** (runs one replica per node) .

```
kubectl apply -f ./manifests/
```

&nbsp;
  
You can confirm pod status issuing the following command.  

```
kubectl -n raspi-k8s-rah get pod
```

&nbsp;

The following command can monitor logs of the running pod in real-time.

```
kubectl -n raspi-k8s-rah logs -f -c boinc <pod name>
```

&nbsp;

As usual, the client can also be controlled from the command line via the boinccmd command.  
From the Raspberry Pi, which can issue kubectl command, you can issue commands via,

```
kubectl -n raspi-k8s-rah exec -it -c boinc-client <pod name> -- boinccmd <args>
```

&nbsp;

If you want to see tasks progress, you should issue a command via,

```
kubectl -n raspi-k8s-rah exec -c boinc <pod name> -- boinccmd --get_tasks
```

&nbsp;



## Customizing
If you want to change the resource allocation, you should edit daemonset section on  _**"manifests/raspi-k8s-rah.yaml"**_ . 

### manifests/raspi-k8s-rah.yaml

```
---

apiVersion: apps/v1
kind: DaemonSet
metadata:
  namespace: raspi-k8s-rah
  name: raspi-k8s-rah
  labels:
    app: raspi-k8s-rah
spec:
  selector:
      matchLabels:
        app: raspi-k8s-rah
  template:
    metadata:
      labels:
        app: raspi-k8s-rah
    spec:
      volumes:
        - name: raspi-k8s-rah-config
          configMap: 
            name: raspi-k8s-rah-cm
      # # This toleration is to have the daemonset runnable on master nodes
      # # uncomment this section if your masters can run pods
      # tolerations:
        # - key: node-role.kubernetes.io/master
        #   effect: NoSchedule
      containers:
        - name: boinc
          imagePullPolicy: Always
          image: "izewfktvy533zjmn/raspi-k8s-rah-boinc:latest"

        - name: boinc-client
          imagePullPolicy: Always
          image: "izewfktvy533zjmn/raspi-k8s-rah-boinc-client:latest"
          volumeMounts:
            - name: raspi-k8s-rah-config
              mountPath: /var/lib/boinc-client/
              readOnly: true
          env:
            - name: ROSETTA_AT_HOME_ACCOUNT_KEY
              valueFrom:
                configMapKeyRef:
                  name: raspi-k8s-rah-cm
                  key: account_key
          resources:
            limits:
              cpu: 2 # How much CPU you wish to donate per node
              memory: 1Gi
            requests:
              cpu: 2
              memory: 1Gi

---
```
