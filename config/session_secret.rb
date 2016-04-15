# Specifies the secret key that protects data in the session cookie. If it is
# missing, the secret will be randomly generated during boot and existing
# browser sessions become invalid. Should be at least 32 bytes in hex notation.
Padrino.configure_apps do
  if (secret = ENV['SESSION_SECRET']).present?
    set :session_secret, secret
  else
    set :session_secret, SecureRandom.hex(32)
    logger.warn 'No session_secret specified. See config/session_secret.rb'
  end
end
