class Sites::Admin::ItemsController < Sites::Admin::ApplicationController
  before_action :set_sites_admin_item, only: [:show, :edit, :update, :destroy]

  # GET /sites/admin/items
  # GET /sites/admin/items.json
  def index
    @sites_admin_items = @organization.items.order('id desc')
  end

  # GET /sites/admin/items/1
  # GET /sites/admin/items/1.json
  def show
  end

  # GET /sites/admin/items/new
  def new
    case params[:step]
    when 'confirm'
      render 'new_confirm'
    when 'fill_form'
      @sites_admin_item = @organization.items.new(post_type: params[:type])

      render 'new_fill_form'
    else
      
    end

  end

  # GET /sites/admin/items/1/edit
  def edit
  end

  # POST /sites/admin/items
  # POST /sites/admin/items.json
  def create
    @sites_admin_item = @organization.items.new(sites_admin_item_params)

    # raise @sites_admin_item.inspect
    @sites_admin_item.valid?
        
    render :new_fill_form
    return

    respond_to do |format|
      if @sites_admin_item.save
        format.html { redirect_to @sites_admin_item, notice: 'Item was successfully created.' }
        format.json { render :show, status: :created, location: @sites_admin_item }
      else
        format.html { render :new }
        format.json { render json: @sites_admin_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sites/admin/items/1
  # PATCH/PUT /sites/admin/items/1.json
  def update
    respond_to do |format|
      if @sites_admin_item.update(sites_admin_item_params)
        format.html { redirect_to @sites_admin_item, notice: 'Item was successfully updated.' }
        format.json { render :show, status: :ok, location: @sites_admin_item }
      else
        format.html { render :edit }
        format.json { render json: @sites_admin_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sites/admin/items/1
  # DELETE /sites/admin/items/1.json
  def destroy
    @sites_admin_item.destroy
    respond_to do |format|
      format.html { redirect_to sites_admin_items_url, notice: 'Item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # POST /sites/admin/:organization_id/items/photo_upload.json
  def photo_upload
    respond_to do |format|
      format.json { 

        @photo = UploadAndFolder.new(sites_admin_item_photo_params)
        if @photo.save
          render json: {
            status: true,
            id: @photo.id,
            thumb:  @photo.file.url(:thumb),
            cover:  @photo.file.url(:cover)
          }
        else
          render json: @photo.errors, status: false
        end  
      }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sites_admin_item
      @sites_admin_item = @organization.items.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sites_admin_item_params
      model_name = Item::TYPE_TO_MATCH[params.require(:item).permit(:post_type)[:post_type].to_sym][:model]
      Object::qualified_const_get(model_name).permit_params(params.require(:item))
    end

    def sites_admin_item_photo_params
      params.require(:photo).permit(:file)
    end
end
