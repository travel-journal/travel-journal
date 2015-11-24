class PostsController < ApplicationController
  # took out :show to allow day_posts (show all the posts in one day)
  # need to put back if we want to allow viewing just one post using show through /api/posts/:id
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
    @posts_of_day = Array.new
    if params[:location_filter].nil? 
      @posts_of_day = Post.where(:trip_id => params[:trip_id], :user_id => current_user.id, :date => params[:date]).order("time DESC")
    else 
      # get posts from that city
      @unique_locations = Hash.new
      for post in Post.where(:trip_id => params[:trip_id], :user_id => current_user.id).order("time DESC")
        result = Geocoder.search(post[:location]).first
        unless result.nil?
          location = result.city || result.neighborhood || result.province
          unless @unique_locations.key? location
            @unique_locations[location] = Array.new
          end
          @unique_locations[location].push(post)
        end
      end
      @posts_of_day = @unique_locations[params[:location_filter]]
    end

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
    unless post_params[:image].nil?
      if post_params[:image].content_type == 'image/jpeg'
        img = EXIFR::JPEG.new(post_params[:image].path)
        unless img.date_time.blank?
          @post.date ||= img.date_time
          @post.time ||= img.date_time
        end
        if post_params[:location].blank? && !img.gps.blank?
          lat = img.gps.latitude
          lon = img.gps.longitude

          geo = Geocoder.search("#{lat},#{lon}").first
          @post.location = geo.address
        end
      end
    end

    trip = Trip.find_by(id: @@trip_id)
    start_date = Trip.where(:id => @@trip_id).pluck(:start_date)
    end_date = Trip.where(:id => @@trip_id).pluck(:end_date)


    # If new post's date is earlier than trip's start date
    if Date.parse(@post.date.to_s) < Date.parse(start_date.to_s)
      trip.start_date = @post.date
      trip.save  

    # If new post's date is later than trip's end date
    elsif Date.parse(@post.date.to_s) > Date.parse(end_date.to_s)
      trip.end_date = @post.date
      trip.save
    end

    @trips = Trip.where(:user_id => current_user.id).order('start_date DESC')

    
    respond_to do |format|
      if @post.save
        format.html { redirect_to day_posts_path({:date => @post.date, :trip_id => @post.trip_id}), notice: 'Post was successfully created.' }
        # to display the new post after creating it
        #format.html { redirect_to @post, notice: 'Post was successfully created.' }
        #format.json { render :show, status: :created, location: @post }

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
        format.html { redirect_to day_posts_path({:date => @post.date, :trip_id => @post.trip_id}), notice: 'Post was successfully created.' }

        #format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        # to display the post after updating it
        #format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @t_post = @post
    @post.destroy
    respond_to do |format|
      format.html { redirect_to trip_path({:id => @t_post.trip_id}), notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
      
    end
  end

  def like_post
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
    end
  end


  def add_comment
    success = true
    begin
      @post = Post.find(params[:id])
    rescue ActiveRecord::RecordNotFound => e
      success = false
      redirect_to :back
    end
    if success
      #render params
      #puts params[:comment]
      @post.comments.push(params[:comment])
      @post.save
    end
    redirect_to :back
  end
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def post_params
    params.require(:post).permit(:title, :caption, :location, :date, :time, :like_count, :image, :image_cache, :location_filter)
    #params.require(:post).permit(:title, :trip, :caption, :location, :date, :time, :like_count, :image)
  end

  def trip_id
    @@trip_id
  end
  helper_method :trip_id
end
