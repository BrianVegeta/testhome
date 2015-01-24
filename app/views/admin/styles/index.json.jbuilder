json.array!(@admin_styles) do |admin_style|
  json.extract! admin_style, :id
  json.url admin_style_url(admin_style, format: :json)
end
