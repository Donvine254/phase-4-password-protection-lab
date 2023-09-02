class User < ApplicationRecord
    has_secure_password
    validates :password, presence: true, confirmation: true
    validates :username, presence: true, uniqueness: true

end
