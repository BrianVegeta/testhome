class Admin::ImagesController < ApplicationController
  before_action :set_admin_image, only: [:show, :edit, :update, :destroy]
  skip_before_filter :verify_authenticity_token

  # GET /admin/images
  # GET /admin/images.json
  def index
    @admin_images = Admin::Image.all
  end

  # GET /admin/images/1
  # GET /admin/images/1.json
  def show
  end

  # GET /admin/images/new
  def new
    @admin_image = Admin::Image.new
  end

  # GET /admin/images/1/edit
  def edit
  end

  # POST /admin/images
  # POST /admin/images.json
  def create
    @admin_image = Image.new(admin_image_params)
    if @admin_image.save
      render json: {
        success: true, 
        imageUrl: {
          original: @admin_image.avatar.url,
          thumb: @admin_image.avatar.url(:thumb),
          small: @admin_image.avatar.url(:small),
          medium: @admin_image.avatar.url(:medium),
          large: @admin_image.avatar.url(:large)
        }
      }
    else
      render json: @admin_image.errors
    end
  end

  # PATCH/PUT /admin/images/1
  # PATCH/PUT /admin/images/1.json
  def update
    respond_to do |format|
      if @admin_image.update(admin_image_params)
        format.html { redirect_to @admin_image, notice: 'Image was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_image }
      else
        format.html { render :edit }
        format.json { render json: @admin_image.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/images/1
  # DELETE /admin/images/1.json
  def destroy
    @admin_image.destroy
    respond_to do |format|
      format.html { redirect_to admin_images_url, notice: 'Image was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_image
      @admin_image = Admin::Image.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_image_params
      params.require(:image).permit(:avatar)
    end
end
