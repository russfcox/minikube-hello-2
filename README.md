# Minikube Hello World

Run a basic 'Hello World' Python app on Minikube

## Pre-requisites

This readme makes the following assumptions:

* You have a suitable command-line terminal available

* Docker is installed and running on your system. 
  If that's not the case, download and install Docker [here](https://www.docker.com)

* Minikube is installed and running on your system.
  If that's not the case, follow the Minikube setup documentation relevant to your operating system [here](https://minikube.sigs.k8s.io/docs/start/)

To check Minikube is running and available:

```
➜ minikube status
minikube
type: Control Plane
host: Running
kubelet: Running
apiserver: Running
kubeconfig: Configured
```

* `kubectl` should be able to reach the kubernetes environment:

```
➜ kubectl get svc
NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)   AGE
kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP   85m
```

## Usage

Start by ensuring your current terminal working directory is the same as this readme.

1. Build the image directly in minikube to save having to upload to a registry / dockerhub.
```
minikube image build -t python_hello .
``` 

2. Create the app deployment in kubernetes
```
kubectl apply -f deployment.yaml
``` 

3. Create a service to load balance the application
``` 
kubectl expose deployment app --type=LoadBalancer --port 5000
``` 

4. Services of type LoadBalancer can be exposed via the minikube tunnel command. It must be run in a separate terminal window to keep the LoadBalancer running. Ctrl-C in the terminal can be used to terminate the process at which time the network routes will be cleaned up.
   
``` 
minikube tunnel
``` 

5. You can now reach the application by navigating to http://localhost:5000 in a browser, or by running `curl localhost:5000`

## Teardown

`kubectl delete deployment app`

`kubectl delete svc app`


## Troubleshooting

### Port conflicts

Ensure port 5000 is unused on your machine. Either stop any existing process using this port, or reconfigure the set port values in the following files to an unused value.
- hello.py
- deployment.yaml 

Now run through steps 1-5 above, ensuring to use the new port number in steps 3 and 5.

### Log files

Should you have issues. Check the deployment log files for error messages.

`kubectl logs deployment.apps/app`

```
Found 2 pods, using pod/app-5c6d5d777c-58tzp
 * Serving Flask app 'hello'
 * Debug mode: off
WARNING: This is a development server. Do not use it in a production deployment. Use a production WSGI server instead.
 * Running on all addresses (0.0.0.0)
 * Running on http://127.0.0.1:5000
 * Running on http://10.244.0.10:5000
Press CTRL+C to quit
```