# Vault Docker Setup

This repository contains a basic Docker setup for HashiCorp Vault.

## Components

- HashiCorp Vault 1.15.0
- File storage backend
- KV secret engine (version 2)
- File audit device

## Getting Started

1. Start the Vault server:
   ```
   docker-compose up -d
   ```

2. Initialize Vault:
   ```
   docker exec -it vault-docker_vault_1 vault operator init
   ```
   Save the unseal keys and root token securely.

3. Unseal Vault (repeat 3 times with different keys):
   ```
   docker exec -it vault-docker_vault_1 vault operator unseal <unseal-key>
   ```

4. Authenticate with the root token:
   ```
   docker exec -it vault-docker_vault_1 vault login <root-token>
   ```

## API Examples

### Write a secret
```
curl -X POST -H "X-Vault-Token: <root-token>" \
    -d '{"data":{"password":"my-secret-password"}}' \
    http://localhost:8200/v1/secret/data/my-app
```

### Read a secret
```
curl -H "X-Vault-Token: <root-token>" \
    http://localhost:8200/v1/secret/data/my-app
```

### Create an app token
```
curl -X POST -H "X-Vault-Token: <root-token>" \
    -d '{"policies":["app-policy"]}' \
    http://localhost:8200/v1/auth/token/create
``` 