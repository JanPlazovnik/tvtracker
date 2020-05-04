class Episode < ApplicationRecord
    belongs_to :season
    has_and_belongs_to_many :users
    has_many :comments, dependent: :destroy
end