module SiteHelper
	def module_link(item)
    temp_array = ModuleSet::LINK_LIST.flatten
    unless item.kind == 0 || item.is_a?(Portlet)
      return "/administrator/" + temp_array[temp_array.index(item.kind) - 1] + "/" + item.id.to_s
    else
      return "#"
    end
  end
  def home_url(subpath = "" , org = nil)
    return (@home_url ||= (@domain_check ||= !params[:domain].nil?) ? "/#{org ? org.id : (u params[:domain] || @organization.id)}" : "").to_s  + "/#{subpath}"
  end
  def domain_url(module_set , sitebar = false)
    if module_set
      if sitebar
        if module_set.kind == 11
          temp = module_set.public_path
          return "<a href='#{org_url if temp[0]}#{temp[2]}' target='#{temp[1] ? "_blank" : "_self"}'>#{module_set.name}</a>"
        else
          return "<a href='#{org_url}#{module_set.public_path}'>#{module_set.name}</a>"
        end
      else
        return "#{org_url}#{module_set.public_path}"
      end
    else
      return org_url
    end
  end
  def org_url(subpath = "" , org = nil)
    return home_url("a/#{subpath}" , org)
  end
end