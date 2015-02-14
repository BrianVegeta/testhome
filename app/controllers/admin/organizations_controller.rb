class Admin::OrganizationsController < Admin::BaseController
  before_action :set_admin_organization, only: [:show, :edit, :update, :destroy]

  # GET /admin/organizations
  # GET /admin/organizations.json
  def index

    respond_to do |format|
      format.html {
        @admin_organizations = Organization.paginate(:page => params[:page], :per_page => 30).order('id DESC')
      }
      format.json { 
        @trans = false
        if params[:trans]
          @trans = Organization.find(params[:trans]);
        end

        if params[:node]
          @parent = Organization.find(params[:node]);
          @admin_organizations = @parent.children

          organizations = getOrgansJson(@admin_organizations)
          if params[:panel]

            canTransLevel = true
            canTransLevel = false if @parent.root?

            parentJson = {
              id: @parent.id,
              label: @parent.name,
              level_count: @parent.level_count,
              canTransLevel: canTransLevel
            }

            if @trans
              #判斷可否轉移
              canTransIn = false
              canTransIn = true if @trans.is_descendant_of?(@parent.root)
              canTransIn = false if @trans.is_ancestor_of?(@parent)
              canTransIn = false if @trans.parent == @parent
              parentJson = parentJson.merge({canTransIn: canTransIn})
            end
            
            render json: {
              parent: parentJson,
              children: organizations,
              parents: @parent.ancestors.map do |ancestor|
                {
                  id: ancestor.id,
                  name: ancestor.name
                }
              end
            }
          else
            render json: organizations
          end

        else
          # @admin_organizations = Organization.where(is_root: true).order('id DESC')
          @admin_organizations = Organization.roots.reverse
          organizations = getOrgansJson(@admin_organizations)

          if params[:panel]

            render json: {
              parent: {
                id: '#',
                label: '#',
                level_count: '#',
                canTransLevel: '#'
              },
              children: organizations
            }

          else
            render json: [{
              label: '組織列表',
              children: organizations
            }]
          end
          
        end
      }
      
    end
  end

  def search
    query = params[:query]

    if /^ID:[0-9]+$/.match(query)
      id = query.gsub 'ID:', ''

      organs = Organization.where(id: id);

      respond_to do |format|
        format.json {
          if organs.length > 0
            organsJson = organs.map do |organ|
              {
                id: organ.id,
                name: organ.name,
                parents: organ.self_and_ancestors.map do |ancestor|
                  {
                    id: ancestor.id,
                    name: ancestor.name
                  }
                end
              }
            end
            render json: organsJson
          else
            render json: []
          end
        }
      end
      return false;
    end

    @organs = Organization.where('name LIKE ? OR phone LIKE ?', "%#{query}%", "%#{query}%")

    organsJson = @organs.map do |organ|
      {
        id: organ.id,
        name: organ.name,
        parents: organ.self_and_ancestors.map do |ancestor|
          {
            id: ancestor.id,
            name: ancestor.name
          }
        end
      }
    end

    respond_to do |format|
      format.json {
        render json: organsJson
      }
    end    
  end

  def trans_level
    parent = Organization.find(params[:organization_id])
    child = Organization.find(params[:trans_id])
    raise 'Can not trans root' if child.root?

    canTrans = false
    message = ''

    if child.root == parent.root
      canTrans = true
      child.move_to_child_of(parent)
    else
      message = 'not same root'
    end



    respond_to do |format|
      format.json {
        render json: {
          parent: params[:organization_id],
          child: params[:trans_id],
          canTrans: canTrans,
          message: message
        }
      }
    end
  end

  # GET /admin/organizations/1
  # GET /admin/organizations/1.json
  def show
  end

  # GET /admin/organizations/new
  def new
    @admin_organization = Organization.new
    if params[:parent]
      @parent = Organization.find(params[:parent])
      @admin_organization.level_count = @parent.level_count - 1
    end
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
    unless params[:parent_id]
      @admin_organization.is_root = true
    end

    respond_to do |format|
      if @admin_organization.save

        if params[:parent_id]
          @parent = Organization.find(params[:parent_id])
          @admin_organization.move_to_child_of(@parent)

          @root_auth = @parent.organization_auths.first
          @organization_auth = @admin_organization.organization_auths.new({name: :admin, new_user_id: params[:new_user_id]})
          @organization_auth.save

          @organization_auth.move_to_child_of(@root_auth)
        else
          @organization_auth = @admin_organization.organization_auths.new({name: :admin})
          @organization_auth.save          
        end

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
        format.html { redirect_to admin_organization_path(@admin_organization.id), notice: 'Organization was successfully updated.' }
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

    def getOrgansJson(organs)
      organizations = organs.map do |organization|
        map = {
          id: organization.id,
          label: organization.name,
          level_count: organization.level_count
        }

        canTransLevel = true
        canTransLevel = false if organization.root?
        if @trans
          #判斷可否轉移
          canTransIn = false
          canTransIn = true if @trans.is_descendant_of?(organization.root)
          canTransIn = false if @trans.is_ancestor_of?(organization)
          canTransIn = false if @trans.parent == organization
          map = map.merge({canTransIn: canTransIn})
        end

        map = map.merge({canTransLevel: canTransLevel})

        if organization.leaf?
          map
        else
          map.merge({load_on_demand: true})
        end

      end
      return organizations
    end
end
