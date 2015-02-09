json.array!(@sites_admin_organsubs) do |sites_admin_organsub|
  json.extract! sites_admin_organsub, :id
  json.url sites_admin_organsub_url(sites_admin_organsub, format: :json)
end
