# Vault Docker Setup

This repository contains a basic Docker setup for HashiCorp Vault.

## Components

- HashiCorp Vault 1.15.0
- File storage backend
- KV secret engine (version 2)
- File audit device

## Getting Started

1. Configure your environment:
   ```
   # The .env file contains environment variables for Vault
   # VAULT_ADDR is set to http://vault.local:8200 by default
   ```

2. Start the Vault server:
   ```
   docker-compose up -d
   ```

3. Initialize Vault:
   ```
   docker exec -it vault-docker_vault_1 vault operator init
   ```
   Save the unseal keys and root token securely.

4. Unseal Vault (repeat 3 times with different keys):
   ```
   docker exec -it vault-docker_vault_1 vault operator unseal <unseal-key>
   ```

5. Authenticate with the root token:
   ```
   docker exec -it vault-docker_vault_1 vault login <root-token>
   ```

6. Update your .env file with the root token:
   ```
   # Edit .env and set VAULT_TOKEN to your root token
   ```

## API Examples

### Write a secret
```
curl -X POST -H "X-Vault-Token: ${VAULT_TOKEN}" \
    -d '{"data":{"password":"my-secret-password"}}' \
    ${VAULT_ADDR}/v1/secret/data/my-app
```

### Read a secret
```
curl -H "X-Vault-Token: ${VAULT_TOKEN}" \
    ${VAULT_ADDR}/v1/secret/data/my-app
```

### Create an app token
```
curl -X POST -H "X-Vault-Token: ${VAULT_TOKEN}" \
    -d '{"policies":["app-policy"]}' \
    ${VAULT_ADDR}/v1/auth/token/create
```

## Apply the Example Policy

To create and apply the example policy:

```
# Create the policy
docker exec -it vault-docker_vault_1 vault policy write app-policy example-policy.hcl

# Create a token with this policy
docker exec -it vault-docker_vault_1 vault token create -policy=app-policy
``` 