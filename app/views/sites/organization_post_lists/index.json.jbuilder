json.array!(@sites_organization_post_lists) do |sites_organization_post_list|
  json.extract! sites_organization_post_list, :id
  json.url sites_organization_post_list_url(sites_organization_post_list, format: :json)
end
