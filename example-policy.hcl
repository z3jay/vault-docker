# Example policy for application access
# To create: vault policy write app-policy example-policy.hcl

# Allow reading secrets under "secret/data/my-app"
path "secret/data/my-app" {
  capabilities = ["read"]
}

# Allow listing secrets under "secret/metadata/my-app"
path "secret/metadata/my-app" {
  capabilities = ["list"]
}

# Deny access to all other paths
path "*" {
  capabilities = ["deny"]
} 