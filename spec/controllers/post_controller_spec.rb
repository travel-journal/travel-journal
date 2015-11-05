# spec/controllers/posts_controller_spec.rb
require 'rails_helper'
require 'spec_helper'
require 'rspec/mocks/standalone'
include Devise::TestHelpers

def setup
  @request.env["devise.mapping"] = Devise.mappings[:user]
end

describe PostsController do
  describe "GET #index" do
    it "allows authenticated access to get index" do
      sign_in FactoryGirl.create(:user)

      get :index
      expect(response).to be_success
    end

    it "renders the :index view" do
      sign_in FactoryGirl.create(:user)

      get :index
      response.should render_template :index
    end
  end

  describe "GET #show" do
    it "renders the #show view" do
      sign_in FactoryGirl.create(:user)

      get :show, id: FactoryGirl.create(:post)
      response.should render_template :show
    end
  end

  describe "POST create" do
    context "with valid attributes" do
      it "creates a new post" do
        sign_in FactoryGirl.create(:user)
        trip = FactoryGirl.create(:trip)  
        PostsController.class_variable_set :@@trip_id, trip.id
        expect{
          post :create, post: FactoryGirl.attributes_for(:post)
        }.to change(Post,:count).by(1)
      end
    end
    
    context "with invalid attributes" do
      it "does not save the new Post" do
        sign_in FactoryGirl.create(:user)
        params = FactoryGirl.attributes_for(:invalid_post)
        expect{
          post :create, post: params
        }.to_not change(Post,:count)
      end
      
      it "re-renders the new Post" do
        sign_in FactoryGirl.create(:user)
        post :create, post: FactoryGirl.attributes_for(:invalid_post)
        response.should render_template :new
      end
    end 
  end
end