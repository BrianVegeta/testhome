class Admin::OrganizationAuthorizationsController < Admin::BaseController
  before_action :set_admin_organization_authorization, only: [:show, :edit, :update, :destroy]

  # GET /admin/organization_authorizations
  # GET /admin/organization_authorizations.json
  # def index
  #   @organ_admins = Admin::OrganizationAuthorization.all
  # end

  # GET /admin/organization_authorizations/1
  # GET /admin/organization_authorizations/1.json
  # def show
  # end

  def search_users
    query = params[:q]
    if /^ID:[0-9]+$/.match(query)
      id = query.gsub 'ID:', ''
      users = User.where(id: id).limit(20).order(id: :desc)
        
    elsif Devise.email_regexp.match query
      users = User.where('email LIKE ?', "%#{query}%").limit(20).order(id: :desc)
    else
      users = User.where(
          'name LIKE ? OR nick_name LIKE ? OR phone LIKE ?', 
          "%#{query}%", 
          "%#{query}%", 
          "%#{query}%"
        ).limit(20).order(id: :desc)
    end
    respond_to do |format|
      format.json {
        render json: {
          q: params[:q],
          items: users.map do |user|
            if user.name.present? && user.nick_name.present?
              name_string = "#{user.name} (#{user.nick_name})"
            elsif user.name.present?
              name_string = "#{user.name}"
            elsif user.nick_name.present?
              name_string = "#{user.nick_name}"
            else
              name_string = ''
            end
              
            {
              id: user.id,
              text: "ID:#{user.id} #{user.email} #{name_string}"
            }
          end
        }
      }
    end
  end

  def search_user_init
    user = User.find(params[:id])
    if user.name.present? && user.nick_name.present?
      name_string = "#{user.name} (#{user.nick_name})"
    elsif user.name.present?
      name_string = "#{user.name}"
    elsif user.nick_name.present?
      name_string = "#{user.nick_name}"
    else
      name_string = ''
    end

    respond_to do |format|
      format.json {
        render json: {
          id: params[:id],
          text: "ID:#{user.id} #{user.email} #{name_string}"
        }
      }
    end
  end

  # GET /admin/organization_authorizations/new
  def new
    @organ = Organization.find(params[:organ])
    @organ_admin = OrganizationAuthorization.new
    @organ_admin.organization_id = @organ.id
  end

  # GET /admin/organization_authorizations/1/edit
  def edit
    @organ = @organ_admin.organization
  end

  # POST /admin/organization_authorizations
  # POST /admin/organization_authorizations.json
  def create
    @organ_admin = OrganizationAuthorization.new(admin_organization_authorization_params)

    respond_to do |format|
      if @organ_admin.save
        OrganizationMember.where(user_id: @organ_admin.user.id, organization_id: @organization.id).first_or_create
        format.html { redirect_to admin_organization_path(@organ_admin.organization_id), notice: 'Organization authorization was successfully created.' }
        format.json { render :show, status: :created, location: @organ_admin }
      else
        format.html { render :new }
        format.json { render json: @organ_admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/organization_authorizations/1
  # PATCH/PUT /admin/organization_authorizations/1.json
  def update
    respond_to do |format|
      if @organ_admin.update(admin_organization_authorization_params)
        format.html { redirect_to admin_organization_path(@organ_admin.organization_id), notice: 'Organization authorization was successfully updated.' }
        format.json { render :show, status: :ok, location: @organ_admin }
      else
        format.html { render :edit }
        format.json { render json: @organ_admin.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/organization_authorizations/1
  # DELETE /admin/organization_authorizations/1.json
  def destroy
    @organ_admin.destroy
    respond_to do |format|
      format.html { redirect_to admin_organization_authorizations_url, notice: 'Organization authorization was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_organization_authorization
      @organ_admin = OrganizationAuthorization.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_organization_authorization_params
      params.require(:organization_authorization).permit(:name, :organization_id, :user_id)
    end
end
