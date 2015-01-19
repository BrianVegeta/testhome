class Sites::IndexController < ApplicationController
	def index
		
		@organization_id = params[:id].to_i
		@site = Organization.find(@organization_id)
		@theme = Theme.find(@site.use_theme_id)
		@module_sets = ModuleSet.where(organization_id: @organization_id).order(position: :desc ,id: :desc)
		@module_sets_parents = @module_sets.select { |m| m.parent_id == nil }
		@module_sets_children = {}
		@module_sets.each do |m|
			if m.parent_id != nil
				@module_sets_children[m.parent_id] = [] if @module_sets_children[m.parent_id].nil?
				@module_sets_children[m.parent_id].push(m)
			end
		end
	end
end
