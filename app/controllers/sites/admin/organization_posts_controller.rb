class Sites::Admin::OrganizationPostsController < Sites::Admin::ApplicationController
  before_action :set_organization_post, only: [:show, :edit, :update, :destroy]
  before_action :set_post_list, only: [:index, :new, :create, :show, :edit, :update]

  # GET /sites/admin/organization_posts
  # GET /sites/admin/organization_posts.json
  def index
    @organization_posts = @postList.organization_posts
  end

  # GET /sites/admin/organization_posts/1
  # GET /sites/admin/organization_posts/1.json
  def show
  end

  # GET /sites/admin/organization_posts/new
  def new
    @organization_post = @postList.organization_posts.new
  end

  # GET /sites/admin/organization_posts/1/edit
  def edit
    # raise params.inspect
    # raise @organization.inspect
    # raise @postList.inspect
    # raise @organization_post.inspect
  end

  # POST /sites/admin/organization_posts
  # POST /sites/admin/organization_posts.json
  def create
    @organization_post = @postList.organization_posts.new(organization_post_params)

    respond_to do |format|
      if @organization_post.save
        format.html { 
          redirect_to sites_admin_organization_post_list_organization_post_path(@organization.id, @postList.id, @organization_post.id),
          notice: 'Organization post was successfully created.' 
        }
        format.json { render :show, status: :created, location: @organization_post }
      else
        format.html { render :new }
        format.json { render json: @organization_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sites/admin/organization_posts/1
  # PATCH/PUT /sites/admin/organization_posts/1.json
  def update
    respond_to do |format|
      if @organization_post.update(organization_post_params)
        format.html { 
          redirect_to sites_admin_organization_post_list_organization_post_path(@organization.id, @postList.id, @organization_post.id),
          notice: 'Organization post was successfully updated.' 
        }
        format.json { render :show, status: :ok, location: @organization_post }
      else
        format.html { render :edit }
        format.json { render json: @organization_post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sites/admin/organization_posts/1
  # DELETE /sites/admin/organization_posts/1.json
  def destroy
    @organization_post.destroy
    respond_to do |format|
      format.html { redirect_to organization_posts_url, notice: 'Organization post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_organization_post
      @organization_post = OrganizationPost.find(params[:id])
    end

    def set_post_list
      @postList = OrganizationPostList.find(params[:organization_post_list_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def organization_post_params
      params.require(:organization_post).permit(:cover_id, :title, :description, :content)
    end
end
