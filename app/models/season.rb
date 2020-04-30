class Season < ApplicationRecord
    belongs_to :serie
    has_many :episodes
end 