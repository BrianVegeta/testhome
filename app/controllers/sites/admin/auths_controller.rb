class Sites::Admin::AuthsController < Sites::Admin::ApplicationController
  before_action :set_sites_admin_auth, only: [:show, :edit, :update, :destroy]

  # GET /sites/admin/auths
  # GET /sites/admin/auths.json
  def index
    @root_auth = @organization.organization_auths.first
    @sites_admin_auths = @root_auth.descendants
  end

  # GET /sites/admin/auths/1
  # GET /sites/admin/auths/1.json
  def show
  end

  # GET /sites/admin/auths/new
  def new
    @sites_admin_auth = OrganizationAuth.new
  end

  # GET /sites/admin/auths/1/edit
  def edit
  end

  # POST /sites/admin/auths
  # POST /sites/admin/auths.json
  def create
    @sites_admin_auth = OrganizationAuth.new(sites_admin_auth_params)

    respond_to do |format|
      if @sites_admin_auth.save
        format.html { redirect_to @sites_admin_auth, notice: 'Auth was successfully created.' }
        format.json { render :show, status: :created, location: @sites_admin_auth }
      else
        format.html { render :new }
        format.json { render json: @sites_admin_auth.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sites/admin/auths/1
  # PATCH/PUT /sites/admin/auths/1.json
  def update
    respond_to do |format|
      if @sites_admin_auth.update(sites_admin_auth_params)
        format.html { redirect_to @sites_admin_auth, notice: 'Auth was successfully updated.' }
        format.json { render :show, status: :ok, location: @sites_admin_auth }
      else
        format.html { render :edit }
        format.json { render json: @sites_admin_auth.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sites/admin/auths/1
  # DELETE /sites/admin/auths/1.json
  def destroy
    @sites_admin_auth.destroy
    respond_to do |format|
      format.html { redirect_to sites_admin_auths_url, notice: 'Auth was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sites_admin_auth
      @sites_admin_auth = OrganizationAuth.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sites_admin_auth_params
      params[:sites_admin_auth]
    end
end
