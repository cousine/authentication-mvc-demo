# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string           not null
#  hashed_password :string           not null
#  password_seed   :string           not null
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

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

  def self.authenticate(user_params)
    email = user_params[:email]
    password = user_params[:password]

    user = User.find_by! email: email
    password_to_check = User.generate_password_hash(password, user.password_seed)
    if password_to_check == user.hashed_password
      return user
    end

    raise ActiveRecord::RecordNotFound
    
  end

  def self.generate_password_hash(password, password_seed)
    secret = 'AlmakinahSecretPhrase'
    password_to_hash = "#{password}#{secret}#{password_seed}"

    Digest::SHA2.hexdigest(password_to_hash)
  end
end
