class Post < ApplicationRecord
  belongs_to :user

  validates :spot, presence: true
  validates :caption, presence: true
  validates :address, presence: true
  validates :image, presence: true
  # 経度、緯度取得のため記述
  geocoded_by :address
  after_validation :geocode

  has_one_attached :image

  def get_image(width, height)
    image.variant(resize_to_fill: [width, height]).processed
  end
end
