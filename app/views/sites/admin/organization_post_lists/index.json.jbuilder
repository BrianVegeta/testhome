json.array!(@sites_admin_organization_post_lists) do |sites_admin_organization_post_list|
  json.extract! sites_admin_organization_post_list, :id
  json.url sites_admin_organization_post_list_url(sites_admin_organization_post_list, format: :json)
end
