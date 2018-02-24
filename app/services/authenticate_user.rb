require 'digest/SHA2'
class AuthenticateUser
  def initialize(params)
    @email = params[:email]
    @password = params[:password]
  end

  def perform
    user = User.find_by! email: @email
    password_to_check = SecurePassword.generate_password_hash(
      @password, 
      user.password_seed
    )

    if password_to_check == user.hashed_password
      return user
    end

    raise ActiveRecord::RecordNotFound
  end
end
