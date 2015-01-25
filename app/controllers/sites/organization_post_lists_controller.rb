class Sites::OrganizationPostListsController < ApplicationController
  before_action :set_sites_organization_post_list, only: [:show, :edit, :update, :destroy]

  # GET /sites/organization_post_lists
  # GET /sites/organization_post_lists.json
  def index
    organization_id = params[:id]
    @organization = Organization.find(organization_id)
    @sites_organization_post_lists = @organization.organization_post_lists
  end

  # GET /sites/organization_post_lists/1
  # GET /sites/organization_post_lists/1.json
  def show
  end

  # GET /sites/organization_post_lists/new
  def new
    @sites_organization_post_list = Sites::OrganizationPostList.new
  end

  # GET /sites/organization_post_lists/1/edit
  def edit
  end

  # POST /sites/organization_post_lists
  # POST /sites/organization_post_lists.json
  def create
    @sites_organization_post_list = Sites::OrganizationPostList.new(sites_organization_post_list_params)

    respond_to do |format|
      if @sites_organization_post_list.save
        format.html { redirect_to @sites_organization_post_list, notice: 'Organization post list was successfully created.' }
        format.json { render :show, status: :created, location: @sites_organization_post_list }
      else
        format.html { render :new }
        format.json { render json: @sites_organization_post_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sites/organization_post_lists/1
  # PATCH/PUT /sites/organization_post_lists/1.json
  def update
    respond_to do |format|
      if @sites_organization_post_list.update(sites_organization_post_list_params)
        format.html { redirect_to @sites_organization_post_list, notice: 'Organization post list was successfully updated.' }
        format.json { render :show, status: :ok, location: @sites_organization_post_list }
      else
        format.html { render :edit }
        format.json { render json: @sites_organization_post_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sites/organization_post_lists/1
  # DELETE /sites/organization_post_lists/1.json
  def destroy
    @sites_organization_post_list.destroy
    respond_to do |format|
      format.html { redirect_to sites_organization_post_lists_url, notice: 'Organization post list was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_sites_organization_post_list
      @sites_organization_post_list = Sites::OrganizationPostList.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def sites_organization_post_list_params
      params[:sites_organization_post_list]
    end
end
