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

require 'secure_password'
class User < ApplicationRecord
  attr_reader :password
  attr_accessor :password_confirmation

  validates :email, :password, :password_confirmation, presence: true
  validates :email, uniqueness: true
  validates :password, confirmation: true

  def password=(value)
    @password = value
    self.password_seed = "#{Random.new.rand(1000)}#{Time.now.to_i}"
    self.hashed_password = SecurePassword.generate_password_hash(value, self.password_seed)
  end

end
