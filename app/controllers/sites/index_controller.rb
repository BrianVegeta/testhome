class Sites::IndexController < ApplicationController
	# def index
		
	# 	@organization_id = params[:id].to_i
	# 	@site = Organization.find(@organization_id)
	# 	@theme = Theme.find(@site.use_theme_id)
	# 	@module_sets = ModuleSet.where(organization_id: @organization_id).order(position: :desc ,id: :desc)
	# 	@module_sets_parents = @module_sets.select { |m| m.parent_id == nil }
	# 	@module_sets_children = {}
	# 	@module_sets.each do |m|
	# 		if m.parent_id != nil
	# 			@module_sets_children[m.parent_id] = [] if @module_sets_children[m.parent_id].nil?
	# 			@module_sets_children[m.parent_id].push(m)
	# 		end
	# 	end
	# end
	def index
		set_organization_auth
	end

	protected

	def set_organization_auth
    @organizationAuth =  OrganizationAuth.where(organization_id: params[:organization_id]).first
    return if @organizationAuth.nil?
    return if !new_user_signed_in?
    return if OrganizationAuth.where(organization_id: params[:organization_id], new_user_id: current_new_user.id).length != 0

    @childAuth = OrganizationAuth.new({name: :user, organization_id: params[:organization_id], new_user_id: current_new_user.id})
    @childAuth.save
    @childAuth.move_to_child_of(@organizationAuth)
    
  end
end
