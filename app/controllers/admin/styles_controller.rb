class Admin::StylesController < Admin::BaseController
  before_action :set_admin_style, only: [:show, :edit, :update, :destroy]
  layout 'admin/style_editor', only: :new
  layout 'admin/application', only: :index
  # GET /admin/styles
  # GET /admin/styles.json
  def index
    @image = Image.new
    @organization = Organization.find(params[:organization_id])
    @admin_styles = @organization.styles
  end

  # GET /admin/styles/1
  # GET /admin/styles/1.json
  def show
  end

  # GET /admin/styles/new
  def new
    # render layout: 'admin/style_editor'
    @admin_image = Image.new
    # raise @admin_image.inspect
    @organization = Organization.find(params[:organization_id])
    @admin_style = @organization.styles.new
  end

  # GET /admin/styles/1/edit
  def edit
  end

  # POST /admin/styles
  # POST /admin/styles.json
  def create
    raise params.inspect
    @admin_style = Style.new(admin_style_params)

    respond_to do |format|
      if @admin_style.save
        format.html { redirect_to @admin_style, notice: 'Style was successfully created.' }
        format.json { render :show, status: :created, location: @admin_style }
      else
        format.html { render :new }
        format.json { render json: @admin_style.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/styles/1
  # PATCH/PUT /admin/styles/1.json
  def update
    respond_to do |format|
      if @admin_style.update(admin_style_params)
        format.html { redirect_to @admin_style, notice: 'Style was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_style }
      else
        format.html { render :edit }
        format.json { render json: @admin_style.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/styles/1
  # DELETE /admin/styles/1.json
  def destroy
    @admin_style.destroy
    respond_to do |format|
      format.html { redirect_to admin_styles_url, notice: 'Style was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_style
      @admin_style = Style.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_style_params
      params[:admin_style]
    end
end
