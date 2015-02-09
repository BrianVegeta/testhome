class Sites::Admin::OrgansubsController < Sites::Admin::ApplicationController
  before_action :set_sites_admin_organsub, only: [:show, :edit, :update, :destroy]

  # GET /sites/admin/organsubs
  # GET /sites/admin/organsubs.json
  def index
    @sites_admin_organsubs = @organization.children
  end

  # GET /sites/admin/organsubs/1
  # GET /sites/admin/organsubs/1.json
  def show
  end

  # GET /sites/admin/organsubs/new
  def new
    @sites_admin_organsub = Organization.new
    @sites_admin_organsub.level_count = @organization.level_count - 1
  end

  # GET /sites/admin/organsubs/1/edit
  def edit
  end

  # POST /sites/admin/organsubs
  # POST /sites/admin/organsubs.json
  def create
    @sites_admin_organsub = Organization.new(sites_admin_organsub_params)

    @sites_admin_organsub.useNew_style

    respond_to do |format|
      if @sites_admin_organsub.save
        @sites_admin_organsub.move_to_child_of(@organization)

        @root_auth = @organization.organization_auths.first
        @organization_auth = @sites_admin_organsub.organization_auths.new({name: :admin, new_user_id: params[:new_user_id]})
        @organization_auth.save

        @organization_auth.move_to_child_of(@root_auth)

        format.html { redirect_to sites_admin_organsubs_path(@organization.id), notice: 'Organsub was successfully created.' }
        format.json { render :show, status: :created, location: @sites_admin_organsub }
      else
        format.html { render :new }
        format.json { render json: @sites_admin_organsub.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sites/admin/organsubs/1
  # PATCH/PUT /sites/admin/organsubs/1.json
  def update
    respond_to do |format|
      if @sites_admin_organsub.update(sites_admin_organsub_params)
        format.html { redirect_to @sites_admin_organsub, notice: 'Organsub was successfully updated.' }
        format.json { render :show, status: :ok, location: @sites_admin_organsub }
      else
        format.html { render :edit }
        format.json { render json: @sites_admin_organsub.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sites/admin/organsubs/1
  # DELETE /sites/admin/organsubs/1.json
  def destroy
    @sites_admin_organsub.destroy
    respond_to do |format|
      format.html { redirect_to sites_admin_organsubs_url, notice: 'Organsub was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sites_admin_organsub
      @sites_admin_organsub = Sites::Admin::Organsub.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sites_admin_organsub_params
      params.require(:organization).permit(:name, :new_user_id, :level_count, :type, :address, :descript, :phone, :fax, :email)
    end
end
