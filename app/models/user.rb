class User < ActiveRecord::Base
  has_many :tweets
  has_secure_password

  def slug
    self.username.split(" ").join("-").downcase
  end

  def self.find_by_slug(string)
      self.find_by(username: string.split("-").join(" "))
  end


  def self.current_user(session)
      User.find(session[:user_id])
    end

  def self.is_logged_in?(session)
      session.has_key?(:user_id)
    end

end
