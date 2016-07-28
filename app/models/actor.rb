class Actor < ActiveRecord::Base
  has_many :casts
  has_many :movies, through: :casts, dependent: :destroy

  validates :name, presence: true, length: { maximum: 50 }
  validates :gender, presence: true, length: { maximum: 10 }
end
