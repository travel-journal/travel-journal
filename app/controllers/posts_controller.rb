class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :update, :destroy]
  before_filter :authenticate_user!
  @@trip_id = nil
  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.where(:user_id => current_user.id) #and :trip_id => current_trip.id and day?)
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @posts_of_day = Post.where(:trip_id => params[:trip_id], :user_id => current_user.id, :date => params[:date]).order("time DESC")
  end

  # GET /posts/new
  def new
    @post = Post.new
    @@trip_id = params[:trip_id]
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    @post.like_count = 0
    @post.trip_id = @@trip_id

    respond_to do |format|
      if @post.save
        format.html { redirect_to day_posts_path({:date => @post.date, :trip_id => @post.trip_id}), notice: 'Post was successfully created.' }
        #format.json { render :show, status: :created, location: @post }
        #format.json {render day_posts_path({:date => p.date, :trip_id => p.trip_id}), status: :ok, location: @post}

      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json {render day_posts_path({:date => p.date, :trip_id => p.trip_id}), status: :ok, location: @post}
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

   def like_post
        #if params[:id].blank? or params[:id].to_f % 1 != 0
         #   render json:{"status":-1, "errors":["Invalid smile id"]}
         #   return
        #end
        
        success = true
        begin
            @post = Post.find(params[:id])
        rescue ActiveRecord::RecordNotFound => e
            success = false
            #render json:{"status":-1, "errors":["Invalid smile id"]}
        end
        if success
            @post.like_count += 1
            if @post.save
                redirect_to :back
                #render json:{"status":1}
            end
            #else 
                #errors = []
                #for i in @smile.errors
                #    for error in @smile.errors[i]
                #        errors.append("#{i} " + error)
                #    end
                #end
            #    render json:{"status":-1}
            #end
        end
    end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :caption, :location, :date, :time, :like_count, :image)
      #params.require(:post).permit(:title, :trip, :caption, :location, :date, :time, :like_count, :image)
    end
end
