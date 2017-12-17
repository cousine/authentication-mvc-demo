require 'digest/SHA2'
class User < ApplicationRecord
  attr_reader :password
  attr_accessor :password_confirmation

  validates :email, :password, :password_confirmation, presence: true
  validates :email, uniqueness: true
  validates :password, confirmation: true

  def password=(value)
    @password = value
    self.password_seed = "#{Random.new.rand(1000)}#{Time.now.to_i}"
    self.hashed_password = User.generate_password_hash(value, self.password_seed)
  end

  def self.authenticate(email, password)
    user = User.find_by email: email
    if user.present?
      password_to_check = User.generate_password_hash(password, user.password_seed)
      if password_to_check == user.hashed_password
        return user
      end
    end
    
    return false
  end

  def self.generate_password_hash(password, password_seed)
    secret = 'AlmakinahSecretPhrase'
    password_to_hash = "#{password}#{secret}#{password_seed}"

    Digest::SHA2.hexdigest(password_to_hash)
  end
end
