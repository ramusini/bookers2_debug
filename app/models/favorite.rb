class Favorite < ApplicationRecord
  belongs_to :book, :user
end
