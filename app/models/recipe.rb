class Recipe < ActiveRecord::Base
  belongs_to :user
  has_many :ingredients
  accepts_nested_attributes_for :ingredients, allow_destroy: true, reject_if: :has_blank_attributes
  validates :user_id, :name, :directions, presence: true

  mount_uploader :recipe_pic, RecipePicUploader

  after_initialize do
    if ingredients.empty?
      ingredients.build
    end
  end

  def to_param
    [id, name.parameterize].join("-")
  end

  private

  def has_blank_attributes(ingredient_attrs)
    ingredient_attrs['quantity'].blank?
  end

end
