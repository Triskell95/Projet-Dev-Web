class Product < ActiveRecord::Base
	belongs_to :users
	
	validates :categorie, presence: true, length: {maximum: 50}
								 
	validates :description, presence: true, length: {minimum: 1, maximum: 20, tokenizer: lambda { |str| str.split(/\s+/) },
    too_short: "must have at least %{count} words",
    too_long: "must have at most %{count} words"
  }
								 
	validates :commentaire, presence: true, length: {minimum: 1, maximum: 50, tokenizer: lambda { |str| str.split(/\s+/) },
    too_short: "must have at least %{count} words",
    too_long: "must have at most %{count} words"
  }
	
	validates :note, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
	
	validates :prix, presence: true, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5000 }
	
end
