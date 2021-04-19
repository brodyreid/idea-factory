class User < ApplicationRecord
    has_many :ideas, dependent: :nullify
    has_many :reviews, dependent: :nullify

    has_secure_password

    validates(
        :email,
        presence: true,
        uniqueness: true,
        format: URI::MailTo::EMAIL_REGEXP,
    )
end
