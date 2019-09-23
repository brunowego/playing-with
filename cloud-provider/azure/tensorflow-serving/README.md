# Tensorflow Serving at Microsoft Azure

## Login

```sh
az login
```

## Container Registry

```sh
az group create \
  -l 'eastus' \
  -n 'TF-Serving-CR'
```

```sh
az acr create \
  -n 'tfregistry' \
  -g 'TF-Serving-CR' \
  --sku 'Basic'
```

```sh
az acr update \
  -n 'tfregistry' \
  --admin-enabled true
```

```sh
az acr credential show \
  -n 'tfregistry' \
  --query 'passwords[0].value'
```

```sh
az acr login -n 'tfregistry'
```

```sh
docker pull 'brunowego/tensorflow-mnist:0.1'
docker tag 'brunowego/tensorflow-mnist:0.1' 'tfregistry.azurecr.io/brunowego-tensorflow-mnist:0.1'
docker push 'tfregistry.azurecr.io/brunowego-tensorflow-mnist:0.1'
```

## Container Instance

```sh
az group create \
  -n 'TF-Serving-ACI' \
  -l 'eastus'
```

```sh
az container create \
  -g 'TF-Serving-ACI' \
  -n 'mnist' \
  -l 'eastus' \
  --image 'tfregistry.azurecr.io/brunowego-tensorflow-mnist:0.1' \
  --registry-username 'tfregistry' \
  --registry-password "$(az acr credential show -n tfregistry --query 'passwords[0].value' | sed 's/"//g')" \
  --cpu 2 \
  --memory 2 \
  --ip-address 'public' \
  --ports 80
```

```sh
az container list -o table
```

## Delete

```sh
az container delete -y \
  -g 'TF-Serving-ACI' \
  -n 'mnist'
```

```sh
az group delete -y \
  -n 'TF-Serving-ACI'
```

```sh
az acr delete \
  -g 'TF-Serving-CR' \
  -n 'tfregistry'
```

```sh
az group delete -y \
  -n 'TF-Serving-CR'
```

```sh
az logout
```
