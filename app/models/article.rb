class Article < ApplicationRecord
    belongs_to :user
    validates :title, presence: true, length: { minimum: 6, maximum: 100 }
    validates :description, presence: true, length: { minimum: 10, maximum: 7000 }
    def self.search_by(search_term)
        where("LOWER(title) LIKE :search_term OR LOWER(description) LIKE :search_term ",
         search_term: "%#{search_term.downcase}%")
    end
end