class Sites::Admin::StylesController < Sites::Admin::ApplicationController
  before_action :set_style, only: [:show, :edit, :update, :destroy]
  layout 'admin/style_editor', only: :new
  layout 'sites/admin', only: :index
  skip_before_filter :verify_authenticity_token

  # GET /sites/admin/styles
  # GET /sites/admin/styles.json
  def index
    @sites_admin_styles = @organization.styles
  end

  # GET /sites/admin/styles/1
  # GET /sites/admin/styles/1.json
  def show
  end

  # GET /sites/admin/styles/new
  def new
    @sites_admin_style = @organization.styles.new
  end

  # GET /sites/admin/styles/1/edit
  def edit
  end

  # POST /sites/admin/styles
  # POST /sites/admin/styles.json
  def create
    @sites_admin_style = @organization.styles.new(sites_admin_style_params)

    respond_to do |format|
      if @sites_admin_style.save
        format.html { redirect_to sites_admin_styles_path(@organization), notice: 'Style was successfully created.' }
        format.json { render :show, status: :created, location: @sites_admin_style }
      else
        format.html { render :new }
        format.json { render json: @sites_admin_style.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sites/admin/styles/1
  # PATCH/PUT /sites/admin/styles/1.json
  def update
    respond_to do |format|
      if @sites_admin_style.update(sites_admin_style_params)
        format.html { redirect_to @sites_admin_style, notice: 'Style was successfully updated.' }
        format.json { render :show, status: :ok, location: @sites_admin_style }
      else
        format.html { render :edit }
        format.json { render json: @sites_admin_style.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sites/admin/styles/1
  # DELETE /sites/admin/styles/1.json
  def destroy
    @sites_admin_style.destroy
    respond_to do |format|
      format.html { redirect_to sites_admin_styles_url, notice: 'Style was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_style
      @sites_admin_style = Sites::Admin::Style.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sites_admin_style_params
      params.require(:style).permit(:name, :description, :html)
    end
end
