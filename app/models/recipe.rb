class Recipe < ActiveRecord::Base
  belongs_to :user
  validates :user_id, :name, :directions, presence: true

  mount_uploader :recipe_pic, RecipePicUploader

  def to_param
    [id, name.parameterize].join("-")
  end

end
