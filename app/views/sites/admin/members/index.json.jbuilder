json.array!(@sites_admin_members) do |sites_admin_member|
  json.extract! sites_admin_member, :id
  json.url sites_admin_member_url(sites_admin_member, format: :json)
end
