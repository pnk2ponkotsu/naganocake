class Item < ApplicationRecord



  has_many :cart_items
  has_many :order_details

  has_one_attached :image
  validates :name, {presence: true}
  validates :introduction, {presence: true}
  validates :price, {presence: true}

def get_image(width, height)
  unless image.attached?
    file_path =Rails.root.join('app/assets/images/no_image2.png')
    image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/png')
  end
  image.variant(resize_to_limit: [width, height]).processed
end

  def price_with_tax
    (price * 1.1).floor
  end

end
