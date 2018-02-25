require 'digest/SHA2'
module SecurePassword
  def self.generate_password_hash(password, password_seed)
    secret = Rails.application.secrets.secret_key_base
    password_to_hash = "#{password}#{secret}#{password_seed}"

    Digest::SHA2.hexdigest(password_to_hash)
  end
end
