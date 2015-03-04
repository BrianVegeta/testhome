class Sites::Admin::OrgansubsController < Sites::Admin::ApplicationController
  before_action :set_sites_admin_organsub, only: [:show, :edit, :update, :destroy]

  # GET /sites/admin/organsubs
  # GET /sites/admin/organsubs.json
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
            canTransLevel = false if @parent.level == (@organization.level + 1)

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
            parents = []
            flag = false
            @parent.ancestors.each do |ancestor|
              if flag
                parents.push({id: ancestor.id, name: ancestor.name})
              end
              flag = true if @organization.id = ancestor.id
            end

            render json: {
              parent: parentJson,
              children: organizations,
              parents: parents
            }
          else
            render json: organizations
          end

        else
          # tree
          root_organ = @organization
          children_organs = @organization.children
          organizations = getOrgansJson(children_organs.reverse)

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
    subOrgans = @organization.descendants

    if /^ID:[0-9]+$/.match(query)
      id = query.gsub 'ID:', ''

      organs = subOrgans.where(id: id);

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

    @organs = subOrgans.where('name LIKE ? OR phone LIKE ?', "%#{query}%", "%#{query}%")

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

  # GET /sites/admin/organsubs/1
  # GET /sites/admin/organsubs/1.json
  def show
    @organ_admins = @sites_admin_organsub.organization_authorizations
  end

  # GET /sites/admin/organsubs/new
  def new
    @sites_admin_organsub = Organization.new
    @sites_admin_organsub.parent_id = @organization.id
    @sites_admin_organsub.level_count = @organization.level_count.to_i - 1

    if params[:parent]
      @parent = Organization.find(params[:parent])
      @sites_admin_organsub.parent_id = @parent.id
      @sites_admin_organsub.level_count = @parent.level_count.to_i - 1
    end
    redirect_to sites_admin_organsubs_path(@organization.id) if @sites_admin_organsub.level_count <= 0
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

        if @sites_admin_organsub.parent_id.present?
          @sites_admin_organsub.move_to_child_of(Organization.find(@sites_admin_organsub.parent_id))  
        end
        

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
        format.html { redirect_to sites_admin_organsub_path(@organization.id, @sites_admin_organsub.id), notice: 'Organsub was successfully updated.' }
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
      @sites_admin_organsub = @organization.descendants.where(id: params[:id]).first
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sites_admin_organsub_params
      params.require(:organization).permit(:name, :new_user_id, :level_count, :type, :address, :descript, :phone, :fax, :email)
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
        canTransLevel = false if organization.level == (@organization.level + 1)

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
