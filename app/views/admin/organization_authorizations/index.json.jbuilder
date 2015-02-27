json.array!(@admin_organization_authorizations) do |admin_organization_authorization|
  json.extract! admin_organization_authorization, :id
  json.url admin_organization_authorization_url(admin_organization_authorization, format: :json)
end
