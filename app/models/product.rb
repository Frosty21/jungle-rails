class Product < ActiveRecord::Base

  monetize :price_cents, numericality: true
  mount_uploader :image, ProductImageUploader

  belongs_to :category
  has_many :reviews

  validates :name, presence: true
  validates :price, presence: true
  validates :quantity, presence: true
  validates :category, presence: true

  def average_rating
    if reviews.size.zero?
      "Not rated yet"
    else
      "Overall rating: #{(reviews.map { |review| review[:rating].to_f }.sum / reviews.size).round(1)}/5"
    end
  end
  
  def sold_out?
    self.quantity < 1
  end

end