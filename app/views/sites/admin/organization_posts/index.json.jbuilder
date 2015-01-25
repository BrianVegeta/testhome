json.array!(@sites_admin_organization_posts) do |sites_admin_organization_post|
  json.extract! sites_admin_organization_post, :id
  json.url sites_admin_organization_post_url(sites_admin_organization_post, format: :json)
end
