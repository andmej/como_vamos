ActionController::Routing::Routes.draw do |map|
  map.resources :comments

  map.login "login", :controller => "user_sessions", :action => "new"
  map.logout "logout", :controller => "user_sessions", :action => "destroy"
  map.signup "signup", :controller => "users", :action => "new"

  map.resources :solutions, :except => [:show, :index, :new]
  map.resources :users, :member => [ :edit_password ]
  map.resources :user_sessions
  map.resources :judges do |judge|
    judge.resources :problems, :only => :new
  end
  map.resources :problems, :except => :new, :collection => {:recent => :get, :unsolved => :get} do |problem|
    problem.resources :solutions, :only => :new
  end
  map.resources :statistics, :controller => "stats", :only => "index"
  map.root :controller => "home", :action => "index"
  map.about "/about", :controller => "home", :action => "about"

  # Uncomment these route and go to /home/test_mail to test the SMTP server.
  # This sends a message to andmej@gmail.com (Change it in /controllers/home_controller.rb)
  # map.connect "/home/test_email", :controller => "home", :action => "test_email"

  # map.connect ':controller/:action/:id'
  # map.connect ':controller/:action/:id.:format'
end
