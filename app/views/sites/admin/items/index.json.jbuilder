json.array!(@sites_admin_items) do |sites_admin_item|
  json.extract! sites_admin_item, :id
  json.url sites_admin_item_url(sites_admin_item, format: :json)
end
