json.array!(@sites_admin_styles) do |sites_admin_style|
  json.extract! sites_admin_style, :id
  json.url sites_admin_style_url(sites_admin_style, format: :json)
end
