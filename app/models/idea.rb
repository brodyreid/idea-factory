class Idea < ApplicationRecord
    has_many :reviews, dependent: :destroy
    belongs_to :user

    validates(:title, presence: true, uniqueness: true)
    validates(
        :description,
        presence: { message: "Must include an idea."},
        length: { minimum: 10 },
    )
end
