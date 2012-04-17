require 'spec_helper'

describe PostsController do
  
  # the root of the site
  context 'GET /' do
    it "should redirect respond to #index" do
      {:get => '/'}.should route_to(
        :controller => 'posts',
        :action => 'index',
        :page => '1'
      )
    end
  end
  
  # listing posts by page
  context 'listing by page' do
    it 'GET /page/7 should route to #index?page=7' do
      {:get => '/page/7'}.should route_to(
        :controller => 'posts',
        :action => 'index',
        :page => '7'
      )
    end
    
    it 'GET /page should route to #index?page=1' do
      {:get => '/page'}.should route_to(
        :controller => 'posts',
        :action => 'index',
        :page => '1'
      )
    end
  end
  
  
  # listing posts by date
  context 'listing by date' do
    it 'GET /2012/11/06 should route to #index?year=2012&month=11&day=06' do
      {:get => '/2012/11/06'}.should route_to(
        :controller => 'posts',
        :action => 'index',
        :year => '2012',
        :month => '11',
        :day => '06',
        :page => '1'
      )        
    end
    
    it 'GET /2012/11/06/page/7 should route to #index?year=2012&month=11&day=06&page=7' do
      {:get => '/2012/11/06/page/7'}.should route_to(
        :controller => 'posts',
        :action => 'index',
        :year => '2012',
        :month => '11',
        :day => '06',
        :page => '7'
      )        
    end
    
    it 'GET /2012/11 should route to #index?year=2012&month=11' do
      {:get => '/2012/11'}.should route_to(
        :controller => 'posts',
        :action => 'index',
        :year => '2012',
        :month => '11',
        :page => '1'
      )        
    end
    
    it 'GET /2012/11/page/7 should route to #index?year=2012&month=11&page=7' do
      {:get => '/2012/11/page/7'}.should route_to(
        :controller => 'posts',
        :action => 'index',
        :year => '2012',
        :month => '11',
        :page => '7'
      )        
    end
    
    it 'GET /2012 should route to #index?year=2012&month=11&day=06' do
      {:get => '/2012'}.should route_to(
        :controller => 'posts',
        :action => 'index',
        :year => '2012',
        :page => '1'
      )        
    end
    
    it 'GET /2012/page/7 should route to #index?year=2012&month=11&day=06&page=7' do
      {:get => '/2012/page/7'}.should route_to(
        :controller => 'posts',
        :action => 'index',
        :year => '2012',
        :page => '7'
      )        
    end
  end
  
  context "listint by tag" do
    it "GET /tag/the-tag-name should route to #index?tag=the-tag-name&page=1" do
      {:get => '/tag/the-tag-name'}.should route_to(
        :controller => 'posts',
        :action => 'index',
        :tag => 'the-tag-name',
        :page => '1'
      )
    end
    
   it "GET /tag/the-tag-name should route to #index?tag=the-tag-name&page=7" do
      {:get => '/tag/the-tag-name/page/7'}.should route_to(
        :controller => 'posts',
        :action => 'index',
        :tag => 'the-tag-name',
        :page => '7'
      )
    end
  end
  
  context "GET /post-slug" do
    it "should redirect to show?slug=post-slug" do
      {:get => '/post-slug'}.should route_to(
        :controller => 'posts',
        :action => 'show',
        :slug => 'post-slug'
      )
    end 
  end
end
