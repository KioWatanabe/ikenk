class PhotosController < ApplicationController
  before_action :login_check, only: [:new, :edit, :update, :destroy]
  before_action :set_current_user_photo, only: [:edit, :update, :destroy]


  # GET /photos
  # GET /photos.json
  def index
    @photos = Photo.all
    @photos = Photo.order("Created_at DESC")

  end

  # GET /photos/1
  # GET /photos/1.json
  def show
    @photo = Photo.includes(:user).find(params[:id])
    @comments = @photo.comments.includes(:user).all
    @comment  = @photo.comments.build(user_id: current_user.id) if current_user

    impressionist(@photo, nil, :unique => [:session_hash])
    @page_views = @photo.impressionist_count

  end

  # GET /photos/new
  def new
     @photo = current_user.photos.build
  end

  # GET /photos/1/edit
  def edit
  end

  # POST /photos
  # POST /photos.json
  def create
    @photo = Photo.new(photo_params)

    respond_to do |format|
      if @photo.save
        format.html { redirect_to @photo, notice: '画像の投稿が完了しました。' }
        format.json { render :show, status: :created, location: @photo }
      else
        format.html { render :new }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /photos/1
  # PATCH/PUT /photos/1.json
  def update
    respond_to do |format|
      if @photo.update(photo_params)
        format.html { redirect_to @photo, notice: '画像の編集が完了しました。' }
        format.json { render :show, status: :ok, location: @photo }
      else
        format.html { render :edit }
        format.json { render json: @photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /photos/1
  # DELETE /photos/1.json
  def destroy
    @photo.destroy
    respond_to do |format|
      format.html { redirect_to photos_url, notice: '画像の消去が完了しました。' }
      format.json { head :no_content }
    end
  end

  private
    def login_check
      unless user_signed_in?
        flash[:alert] = "ログインしてください"
        redirect_to root_path
      end
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_current_user_photo
      @photo = current_user.photos.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def photo_params
       params.require(:photo).permit(:image, :caption, :description, :user_id)
    end
end
