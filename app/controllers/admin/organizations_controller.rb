class Admin::OrganizationsController < Admin::BaseController
  before_action :set_admin_organization, only: [:show, :edit, :update, :destroy]

  # GET /admin/organizations
  # GET /admin/organizations.json
  def index
    @admin_organizations = Organization.paginate(:page => params[:page], :per_page => 30).order('id DESC')
  end

  # GET /admin/organizations/1
  # GET /admin/organizations/1.json
  def show
  end

  # GET /admin/organizations/new
  def new
    @admin_organization = Organization.new
  end

  # GET /admin/organizations/1/edit
  def edit
  end

  # POST /admin/organizations
  # POST /admin/organizations.json
  def create
    # raise admin_organization_params.inspect
    @admin_organization = Organization.new(admin_organization_params)
    
    @admin_organization.useNew_style
    @admin_organization.is_root = true

    respond_to do |format|
      if @admin_organization.save
        @organization_auth = @admin_organization.organization_auths.new({name: :admin})
        @organization_auth.save
        format.html { redirect_to admin_organization_path(@admin_organization.id), notice: 'Organization was successfully created.' }
        format.json { render :show, status: :created, location: @admin_organization }
      else
        format.html { render :new }
        format.json { render json: @admin_organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/organizations/1
  # PATCH/PUT /admin/organizations/1.json
  def update
    respond_to do |format|
      if @admin_organization.update(admin_organization_params)
        format.html { redirect_to @admin_organization, notice: 'Organization was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_organization }
      else
        format.html { render :edit }
        format.json { render json: @admin_organization.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/organizations/1
  # DELETE /admin/organizations/1.json
  def destroy
    @admin_organization.destroy
    respond_to do |format|
      format.html { redirect_to admin_organizations_url, notice: 'Organization was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_organization
      @admin_organization = Organization.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_organization_params
      areas = params[:organization][:area].split('-')

      params.require(:organization).permit(
        :name, :level_count, :type, :address, :descript, :phone, :fax, :email
        ).merge({main_area: areas.first, sub_area: areas.last})
    end
end
