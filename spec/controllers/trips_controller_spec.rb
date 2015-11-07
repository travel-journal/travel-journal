# spec/controllers/trips_controller_spec.rb
require 'rails_helper'
require 'spec_helper'
require 'rspec/mocks/standalone'
require 'faker'
include Devise::TestHelpers

def setup
  @request.env["devise.mapping"] = Devise.mappings[:user]
end

describe TripsController do
  before :each do
      sign_in FactoryGirl.create(:user)
  end

  describe "GET #index" do
    it "allows authenticated access to get index" do
      get :index
      expect(response).to be_success
    end

    it "renders the :index view" do
      get :index
      response.should render_template :index
    end
  end

  describe "GET #show" do
    it "renders the #show view" do
      get :show, id: FactoryGirl.create(:trip)
      response.should render_template :show
    end
  end

  describe "POST create" do
    context "with valid attributes" do
      it "creates a new trip" do
        expect{
          post :create, trip: FactoryGirl.attributes_for(:trip)
        }.to change(Trip,:count).by(1)
      end
    end
    
    context "with invalid attributes" do
      it "does not save the new Post" do
        params = FactoryGirl.attributes_for(:invalid_trip)
        expect{
          post :create, trip: params
        }.to_not change(Trip,:count)
      end
      
      it "re-renders the new Post" do
        post :create, trip: FactoryGirl.attributes_for(:invalid_trip)
        response.should render_template :new
      end
    end 
  end

  describe 'PUT update' do
    before :each do
      @trip = FactoryGirl.create(:trip, title:"My First Trip!")  
    end
    
    context "valid attributes" do
      it "located the requested @trip" do
        put :update, id: @trip, trip: FactoryGirl.attributes_for(:trip)
        assigns(:trip).should eq(@trip)      
      end
    
      it "changes @trip's attributes" do
        put :update, id: @trip, 
          trip: FactoryGirl.attributes_for(:trip, title: "My Second Trip!")
        @trip.reload
        @trip.title.should eq("My Second Trip!")
      end
    end
    
    context "invalid attributes" do
      it "locates the requested @trip" do
        put :update, id: @trip, trip: FactoryGirl.attributes_for(:invalid_trip)
        assigns(:trip).should eq(@trip)      
      end
      
      it "does not change @trip's attributes" do
        put :update, id: @trip, 
          trip: FactoryGirl.attributes_for(:trip, title: "My Second Trip!", start_date: nil)
        @trip.reload
        @trip.title.should_not eq("My Second Trip!")
        @trip.start_date.should eq(Date.today)
      end
      
      it "re-renders the edit method" do
        put :update, id: @trip, trip: FactoryGirl.attributes_for(:invalid_trip)
        response.should render_template :edit
      end
    end
  end

  describe 'DELETE destroy' do
    before :each do
      @trip = FactoryGirl.create(:trip)  
    end
    
    it "deletes the trip" do
      expect{
        delete :destroy, id: @trip        
      }.to change(Trip,:count).by(-1)
    end
      
    it "redirects to trip#index" do
      delete :destroy, id: @trip
      response.should redirect_to trips_url
    end
  end


end
