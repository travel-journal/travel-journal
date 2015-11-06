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
      @posts = Hash.new
      @trips.each do |trip|
        @posts[trip.id] = Post.where(:trip_id => trip.id).limit(1).order("RANDOM()").first
      end
    end
  end

  # GET /trips/1
  # GET /trips/1.json
  def show
    @posts_of_trip = Post.where(:trip_id => params[:id], :user_id => current_user.id).order("created_at DESC")


    previous = nil
    @a_post_a_day = Array.new
    for post in @posts_of_trip
      if previous != post[:date]
        @a_post_a_day.push(post)
        previous = post[:date]
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
      params.require(:trip).permit(:title, :about, :start_date, :end_date)
    end
end
