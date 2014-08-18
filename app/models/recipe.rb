class Recipe < ActiveRecord::Base
  belongs_to :user
  validates :user_id, :name, :description, :directions, presence: true
end
