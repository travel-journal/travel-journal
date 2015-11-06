# spec/controllers/posts_controller_spec.rb
require 'rails_helper'
require 'spec_helper'
require 'rspec/mocks/standalone'
require 'faker'
include Devise::TestHelpers

def setup
  @request.env["devise.mapping"] = Devise.mappings[:user]
end

describe PostsController do
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
      get :show, id: FactoryGirl.create(:post)
      response.should render_template :show
    end
  end

  describe "POST create" do

    context "with valid attributes" do
      it "creates a new post" do
        trip = FactoryGirl.create(:trip)  
        PostsController.class_variable_set :@@trip_id, trip.id
        expect{
          post :create, post: FactoryGirl.attributes_for(:post)
        }.to change(Post,:count).by(1)
      end

      # it "renders to correct trip and post" do
      #   trip = FactoryGirl.create(:trip)  
      #   PostsController.class_variable_set :@@trip_id, trip.id
      #   post :create, post: FactoryGirl.attributes_for(:post)
      #   response.should render_template day_posts_path({:date => @post.date, :trip_id => @post.trip_id})
      # end
    end
    
    context "with invalid attributes" do
      it "does not save the new Post" do
        params = FactoryGirl.attributes_for(:invalid_post)
        expect{
          post :create, post: params
        }.to_not change(Post,:count)
      end
      
      it "re-renders the new Post" do
        post :create, post: FactoryGirl.attributes_for(:invalid_post)
        response.should render_template :new
      end
    end 
  end

  describe 'PUT update' do
    before :each do
      trip = FactoryGirl.create(:trip)  
      PostsController.class_variable_set :@@trip_id, trip.id
      @post = FactoryGirl.create(:post, title: "Hello Nishu!", date: Faker::Date.between(2.days.ago, 2.days.ago), trip_id:trip.id)
    end
    
    context "valid attributes" do
      it "located the requested @post" do
        put :update, id: @post, post: FactoryGirl.attributes_for(:post)
        assigns(:post).should eq(@post)      
      end
    
      it "changes @post's attributes" do
        put :update, id: @post, 
          post: FactoryGirl.attributes_for(:post, title: "Bye Nishu!", date: Date.today)
        @post.reload
        @post.title.should eq("Bye Nishu!")
        @post.date.should eq(Date.today)
      end
    
      # Need to figure out the right url to match
      # it "redirects to the updated post" do
      #   sign_in FactoryGirl.create(:user)
      #   #trip = FactoryGirl.create(:trip)  
      #   #PostsController.class_variable_set :@@trip_id, trip.id
      #   put :update, id: @post, post: FactoryGirl.attributes_for(:post)
      #   response.should redirect_to @post
      # end
    end
    
    context "invalid attributes" do
      it "locates the requested @post" do
        put :update, id: @post, post: FactoryGirl.attributes_for(:invalid_post)
        assigns(:post).should eq(@post)      
      end
      
      it "does not change @post's attributes" do
        put :update, id: @post, 
          post: FactoryGirl.attributes_for(:post, title: "Bye Nishu!", date: nil)
        @post.reload
        @post.title.should_not eq("Bye Nishu!")
        @post.date.should eq(Faker::Date.between(2.days.ago, 2.days.ago))
      end
      
      it "re-renders the edit method" do
        put :update, id: @post, post: FactoryGirl.attributes_for(:invalid_post)
        response.should render_template :edit
      end
    end
  end

  describe 'DELETE destroy' do
    before :each do
      trip = FactoryGirl.create(:trip)  
      PostsController.class_variable_set :@@trip_id, trip.id
      @post = FactoryGirl.create(:post)
    end
    
    it "deletes the post" do
      expect{
        delete :destroy, id: @post        
      }.to change(Post,:count).by(-1)
    end
      
    it "redirects to post#index" do
      delete :destroy, id: @post
      #response.should render_template :index
      response.should redirect_to posts_url
    end
  end
end