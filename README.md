# Kubectl command-line tools

Container to execute kubectl commands.

## Links

- [Image tags](https://hub.docker.com/r/fabionaspolini/kubectl/tags)
- [GitHub](https://github.com/fabionaspolini/kubectl-container)
  - [Dockerfile reference](https://github.com/fabionaspolini/kubectl-container/blob/main/src/Dockerfile)

## Kubectl versions

- **Last version**: <https://dl.k8s.io/release/stable.txt>  
- **History**: https://kubernetes.io/releases/

## How to use this image

Send kubectl args after image name.

```bash
# With base64 kube config data
docker run --rm -it -e KUBECONFIG_BASE64=<BASE64-ENCODED-DATA> fabionaspolini/kubectl <KUBECTL ARGS>
docker run --rm -it -e KUBECONFIG_BASE64=<BASE64-ENCODED-DATA> fabionaspolini/kubectl config view
docker run --rm -it -e KUBECONFIG_BASE64=<BASE64-ENCODED-DATA> fabionaspolini/kubectl get all --all-namespaces

# With volume link
docker run --rm -it -v /<path>/<to>/<your>/<kube>/config:/root/.kube/config fabionaspolini/kubectl get all --all-namespaces
docker run --rm -it -v /<path>/<to>/<your>/<kube>/config:/root/.kube/config fabionaspolini/kubectl apply -f <file.yml>
```

## Environment Variables

- `KUBECONFIG_BASE64`: Kubectl config file encoded at base64
- `VERBOSE`: Show additional logs

**AWS EKS Support**

Kubectl config to AWS EKS need AWS cli configured with environments:

- `AWS_ACCESS_KEY_ID`
- `AWS_SECRET_ACCESS_KEY`
- `AWS_REGION`

## Volumes

- `/root/.kube/config`: Kubectl config file

## Examples

```bash
# Using volume
docker run --rm \
    -v /<path>/<to>/<your>/<kube>/config:/root/.kube/config \
    fabionaspolini/kubectl get all --all-namespaces

# Using kube config data file encoded as base64
docker run --rm \
    -e KUBECONFIG_BASE64=<BASE64-ENCODED-DATA> \
    fabionaspolini/kubectl get all --all-namespaces

# Executing in verbose additional logs
docker run --rm \
    -e VERBOSE=true \
    -e KUBECONFIG_BASE64=<BASE64-ENCODED-DATA> \
    fabionaspolini/kubectl get all --all-namespaces
```

## Using at .gitlab-ci.yml

Set explicitly environment variable "KUBECONFIG" with your preference path (default "/root/.kube/config"). This is necessary because Gitlab CI tools replace the value with a temporary and read-only kubeconfig path.  

Example:

```yml
# Deploy
...
deploy to production:
  stage: deploy
  image: fabionaspolini/kubectl:1.21
  only:
    - master
  variables:
    KUBECONFIG: "/root/.kube/config" # <-- This is necessary to work's!
  script:
    - kubectl config view
    - kubectl apply -n prod -f ci/deploy.yml
    - kubectl apply -n prod -f ci/ingress.yml
```

## How build this image

```bash
# Build
sudo docker build -f 1.21/Dockerfile -t kubectl:dev ./1.21

# Test
sudo docker run --rm \
    -e VERBOSE=true \
    -v ~/.kube/config:/root/.kube/config \
    kubectl:dev get all --all-namespaces

sudo docker run --rm -it \
    -e VERBOSE=true \
    -v ~/.kube/config:/root/.kube/config \
    kubectl:dev bash
```
