# raspi-k8s-rah
## Overview
Run Rosetta@home on Kubernetes with Raspberry Pi.  
This repository used the Docker image created by [raspi-rah](https://github.com/izewfktvy533zjmn/raspi-rah).  

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
 - v1.13.5

&nbsp;



## Usage
First of all, you need to edit _**"manifests/configmap.yaml"**_ .  
Please fill in your Rosetta@home account key instead of _**"\<your account key\>"**_ .  

### manifests/configmap.yaml
```
apiVersion: v1
kind: ConfigMap
metadata:
  namespace: raspi-k8s-rah
  name: raspi-k8s-rah
data:
  account_key: <your account key>
```

&nbsp;

You can run Rosetta@home on Kubernetes when you issue the following command.  
It runs as a **DeamonSet** (runs one replica per node) .

```
kubectl apply -f ./manifests/namespace.yaml
kubectl apply -f ./manifests/configmap.yaml
kubectl apply -f ./manifests/rah-ds.yaml
```

&nbsp;
  
You can confirm pod status issuing the following command.  

```
kubectl -n raspi-k8s-rah get pod
```

&nbsp;

The following command can monitor logs of the running pod in real-time.

```
kubectl -n raspi-k8s-rah logs -f <pod name>
```

&nbsp;

As usual, the client can also be controlled from the command line via the boinccmd command.  
From the Raspberry Pi, which can issue kubectl command, you can issue commands via,

```
kubectl -n raspi-k8s-rah exec <pod name> -- boinccmd <args>
```

&nbsp;

If you want to see tasks progress, you should issue a command via,

```
kubectl -n raspi-k8s-rah exec <pod name> -- boinccmd --get_tasks
```

&nbsp;



## Customizing
If you want to change the resource allocation, you should edit  _**"manifests/rosetta-ds.yaml"**_ .  

### rosetta-ds.yaml

```
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
      # # This toleration is to have the daemonset runnable on master nodes
      # # uncomment this section if your masters can run pods
      # tolerations:
        # - key: node-role.kubernetes.io/master
        #   effect: NoSchedule
      containers:
        - name: raspi-rah
          image: "izewfktvy533zjmn/raspi-rah:latest"
          env:
            - name: ROSETTA_AT_HOME_ACCOUNT_KEY
              valueFrom:
                configMapKeyRef:
                  name: raspi-k8s-rah
                  key: account_key
          resources:
            limits:
              cpu: 2 # How much CPU you wish to donate per node
              memory: 1Gi
            requests:
              cpu: 2
              memory: 1Gi
```
