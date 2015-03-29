json.array!(@address_item_streets) do |address_item_street|
  json.extract! address_item_street, :id
  json.url address_item_street_url(address_item_street, format: :json)
end
