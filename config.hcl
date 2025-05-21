# Turn on the built-in UI
ui = true

# If IPC_LOCK keeps failing, you can disable mlock
disable_mlock = true        # remove this if you want real mlock

# The address clients (and Traefik) should use
api_addr = "https://infisical.jcgglobal.de"

#-------------- storage --------------
storage "file" {
  path = "/vault/file"
}

#-------------- listener -------------
listener "tcp" {
  address     = "0.0.0.0:8200"
  tls_disable = true          # TLS is off here; let Traefik handle HTTPS
}

#----------- secret engine ----------
# KV V2 at path "secret/"
secrets "kv" {
  path    = "secret"
  version = 2
}

#------------- audit log -------------
# Make sure /vault/log is a real, writable directory
audit "file" {
  file_path = "/vault/log/vault_audit.log"
  format    = "json"
}
