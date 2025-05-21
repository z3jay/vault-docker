storage "file" {
  path = "/vault/file"
}

listener "tcp" {
  address     = "0.0.0.0:8200"
  tls_disable = 1
}

secrets "kv" {
  path    = "secret"
  version = 2
}

audit "file" {
  file_path = "/vault/log/vault_audit.log"
  format    = "json"
}
