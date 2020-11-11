class Category < ApplicationRecord
validates :name, presence: true, length: { minimum: 3, maximum: 25 }
validates :name, uniqueness: true
has_many :article_categories
has_many :articles, through: :article_categories

end
