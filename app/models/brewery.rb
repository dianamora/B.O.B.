class Brewery < ApplicationRecord
validates :name, presence: true
validates :city, presence: true
validates :state, presence: true
end
