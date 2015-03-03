class Sites::Admin::MembersController < Sites::Admin::ApplicationController
  before_action :set_sites_admin_member, only: [:show, :edit, :update, :destroy]

  # GET /sites/admin/members
  # GET /sites/admin/members.json
  def index
    if params[:search]
      query = params[:search]
      if /^ID:[0-9]+$/.match(query)
        id = query.gsub 'ID:', ''
        @sites_admin_members = @organization.organization_members.where(user_id: id)

      elsif Devise.email_regexp.match query
        users = User.where('email LIKE ?', "%#{query}%")
        user_ids = users.map {|user| user.id}

        @sites_admin_members = @organization.organization_members.where(user_id: user_ids)

      else
        users = User.where(
            'name LIKE ? OR nick_name LIKE ? OR phone LIKE ?', 
            "%#{query}%", 
            "%#{query}%", 
            "%#{query}%"
          )
        user_ids = users.map {|user| user.id}
        @sites_admin_members = @organization.organization_members.where(user_id: user_ids)
      end

    elsif params[:filter] 
      case params[:filter]
        when 'nm'
          users = User.where(provider: nil)
        when 'fb'
          users = User.where(provider: :facebook)
        when 'gp'
          users = User.where(provider: :gplus)
      end

      user_ids = users.map {|user| user.id}
      @sites_admin_members = @organization.organization_members.where(user_id: user_ids)

    else
      @sites_admin_members = @organization.organization_members
    end
    @sites_admin_members = @sites_admin_members.paginate(:page => params[:page], :per_page => 30).order(id: :desc)
  end

  # GET /sites/admin/members/1
  # GET /sites/admin/members/1.json
  def show
  end

  # GET /sites/admin/members/new
  # def new
  #   @sites_admin_member = Sites::Admin::Member.new
  # end

  # GET /sites/admin/members/1/edit
  # def edit
  # end

  # POST /sites/admin/members
  # POST /sites/admin/members.json
  # def create
  #   @sites_admin_member = Sites::Admin::Member.new(sites_admin_member_params)

  #   respond_to do |format|
  #     if @sites_admin_member.save
  #       format.html { redirect_to @sites_admin_member, notice: 'Member was successfully created.' }
  #       format.json { render :show, status: :created, location: @sites_admin_member }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @sites_admin_member.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # PATCH/PUT /sites/admin/members/1
  # PATCH/PUT /sites/admin/members/1.json
  # def update
  #   respond_to do |format|
  #     if @sites_admin_member.update(sites_admin_member_params)
  #       format.html { redirect_to @sites_admin_member, notice: 'Member was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @sites_admin_member }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @sites_admin_member.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /sites/admin/members/1
  # DELETE /sites/admin/members/1.json
  # def destroy
  #   @sites_admin_member.destroy
  #   respond_to do |format|
  #     format.html { redirect_to sites_admin_members_url, notice: 'Member was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sites_admin_member
      @sites_admin_member = @organization.organization_members.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sites_admin_member_params
      params[:sites_admin_member]
    end
end
