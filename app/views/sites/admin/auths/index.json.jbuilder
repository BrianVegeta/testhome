json.array!(@sites_admin_auths) do |sites_admin_auth|
  json.extract! sites_admin_auth, :id
  json.url sites_admin_auth_url(sites_admin_auth, format: :json)
end
