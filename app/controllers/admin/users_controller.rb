class Admin::UsersController < Admin::BaseController
  before_action :set_admin_user, only: [:show, :edit, :update, :destroy]

  # GET /admin/users
  # GET /admin/users.json
  def index
    if params[:search]
      query = params[:search]
      if /^ID:[0-9]+$/.match(query)
        id = query.gsub 'ID:', ''
        @admin_users = User.where(id: id)
          .paginate(:page => params[:page], :per_page => 30)
          .order(id: :desc)
      elsif Devise.email_regexp.match query
        @admin_users = User.where('email LIKE ?', "%#{query}%")
          .paginate(:page => params[:page], :per_page => 30)
          .order(id: :desc)
      else
        @admin_users = User.where(
            'name LIKE ? OR nick_name LIKE ? OR phone LIKE ?', 
            "%#{query}%", 
            "%#{query}%", 
            "%#{query}%"
          ).paginate(:page => params[:page], :per_page => 30).order(id: :desc)
      end
    else
      if params[:filter]
        case params[:filter]
          when 'nm'
            @admin_users = User.where(provider: nil)
          when 'fb'
            @admin_users = User.where(provider: :facebook)
          when 'gp'
            @admin_users = User.where(provider: :gplus)
        end
        @admin_users = @admin_users.paginate(:page => params[:page], :per_page => 30).order(id: :desc)
      else
        @admin_users = User.paginate(:page => params[:page], :per_page => 30).order(id: :desc)
      end

    end

  end

  # GET /admin/users/1
  # GET /admin/users/1.json
  def show
  end

  # GET /admin/users/new
  # def new
  #   @admin_user = Admin::User.new
  # end

  # GET /admin/users/1/edit
  # def edit
  # end

  # POST /admin/users
  # POST /admin/users.json
  # def create
  #   @admin_user = Admin::User.new(admin_user_params)

  #   respond_to do |format|
  #     if @admin_user.save
  #       format.html { redirect_to @admin_user, notice: 'User was successfully created.' }
  #       format.json { render :show, status: :created, location: @admin_user }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @admin_user.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # PATCH/PUT /admin/users/1
  # PATCH/PUT /admin/users/1.json
  def update
    respond_to do |format|
      if @admin_user.update(password_params)
        format.html { 
          flash[:admin_notice] = '會員密碼變更成功！'
          redirect_to admin_user_path(@admin_user)
        }
        format.json { render :show, status: :ok, location: @admin_user }
      else
        format.html { render :show }
        format.json { render json: @admin_user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/users/1
  # DELETE /admin/users/1.json
  def destroy
    @admin_user.destroy
    respond_to do |format|
      format.html { redirect_to admin_users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_user
      @admin_user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_user_params
      params[:admin_user]
    end

    def password_params
      params.require(:user).permit(:password, :password_confirmation)
    end
end
