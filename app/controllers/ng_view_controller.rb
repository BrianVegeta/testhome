class NgViewController < ActionController::Base
	
	def get
		@templateName = params[:template]
	end
end