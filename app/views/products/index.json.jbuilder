json.array!(@products) do |product|
  json.extract! product, :id, :user, :type, :description, :commentaire, :note, :prix
  json.url product_url(product, format: :json)
end
