# Este archivo configura directamente el secret_key_base sin necesidad de credenciales encriptadas

if Rails.env.production?
  # En producción, usa la variable de entorno SECRET_KEY_BASE o genera una clave aleatoria
  Rails.application.config.secret_key_base = ENV['SECRET_KEY_BASE'] || SecureRandom.hex(64)
end