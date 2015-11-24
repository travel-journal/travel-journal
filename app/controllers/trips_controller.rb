class TripsController < ApplicationController
  before_action :set_trip, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate_user!

  # GET /trips
  # GET /trips.json
  def index
    if params[:search]
      @trips = Trip.where(:user_id => current_user.id).search(params[:search]).order("start_date DESC")
    else
      @trips = Trip.where(:user_id => current_user.id).order('start_date DESC')
    end
    @posts = Hash.new
    @trips.each do |trip|
      @posts[trip.id] = Post.where(:trip_id => trip.id).limit(1).order("RANDOM()").first
    end
  end

  # GET /trips/1
  # GET /trips/1.json
  def show
    @partial = params[:view] || "list"
    
    @posts_of_trip = Post.where(:trip_id => params[:id], :user_id => current_user.id).order("created_at DESC")

    if @partial == "list"
      previous = nil
      @a_post_a_day = Array.new
      for post in @posts_of_trip
        if previous != post[:date]
          @a_post_a_day.push(post)
          previous = post[:date]
        end
      end
    else
      @unique_locations = Array.new
      for post in @posts_of_trip
        result = Geocoder.search(post[:location]).first
        unless result.nil?
          location = result.city || result.neighborhood || result.province
          unless @unique_locations.include? location
            @unique_locations.push(location)
          end
        end
      end

      
      @pins = Gmaps4rails.build_markers(@unique_locations) do |loc, marker|
        result = Geocoder.search(loc).first
        marker.lat result.latitude
        marker.lng result.longitude
        marker.title loc
        loc_link = view_context.link_to "See Posts from #{loc}", day_posts_path({trip_id: @trip.id, location_filter: loc})
        
        marker.infowindow "<h4><u>#{loc_link}</u></h4>"
      end
    end
  end

  # GET /trips/new
  def new
    @trip = Trip.new
  end

  # GET /trips/1/edit
  def edit
  end

  # POST /trips
  # POST /trips.json
  def create
    @trip = Trip.new(trip_params)
    @trip.user_id = current_user.id

    respond_to do |format|
      if @trip.save
        format.html { redirect_to trips_path, notice: 'Trip was successfully created.' }
        format.json { render :show, status: :created, location: @trip }
      else
        format.html { render :new }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /trips/1
  # PATCH/PUT /trips/1.json
  def update

    respond_to do |format|

    post_start_date = Post.where(:trip_id => params[:id]).order('date ASC').limit(1).pluck(:date)
    post_end_date = Post.where(:trip_id => params[:id]).order('date DESC').limit(1).pluck(:date)

    s_year = trip_params['''start_date(1i)'''].to_s
    s_month = trip_params['''start_date(2i)'''].to_s 
    s_day = trip_params['''start_date(3i)'''].to_s 
    s_date = s_year + '-' + s_month + '-' + s_day

    e_year = trip_params['''end_date(1i)'''].to_s
    e_month = trip_params['''end_date(2i)'''].to_s 
    e_day = trip_params['''end_date(3i)'''].to_s 
    e_date = e_year + '-' + e_month + '-' + e_day
 

      if Date.parse(s_date) > Date.parse(post_start_date.to_s)
        format.html { render :edit }
        @trip.errors.add(:end_date, 'not a valid start date')
        format.json { render json: @trip.errors, status: :unprocessable_entity }

      end

      if Date.parse(e_date) < Date.parse(post_end_date.to_s) 
          format.html { render :edit }
          @trip.errors.add(:end_date, 'not a valid end date')
          format.json { render json: @trip.errors, status: :unprocessable_entity }

      end

      # @trips.errors.messages.delete(:end_date, :start_date)

      if @trip.update(trip_params)
        format.html { redirect_to trips_path, notice: 'Trip was successfully updated.' }
        format.json { render :show, status: :ok, location: @trip }
      else
        format.html { render :edit }
        format.json { render json: @trip.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /trips/1
  # DELETE /trips/1.json
  def destroy
    @trip.destroy
    respond_to do |format|
      format.html { redirect_to trips_url, notice: 'Trip was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_trip
      @trip = Trip.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def trip_params
      params.require(:trip).permit(:title, :about, :start_date, :end_date, :view)
    end
end
