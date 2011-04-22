set :application, "Ractive"
set :repository,  "git@github.com:Trimeego/Ractive.git"

set :use_sudo, false 

set :scm, "git"
set :user, "deploy"

#set :rake, "/usr/local/rvm/gems/ruby-1.9.2-p180/bin/rake"
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

role :web, "50.56.74.8"                          # Your HTTP server, Apache/etc
role :app, "50.56.74.8"                          # This may be the same as your `Web` server
role :db,  "50.56.74.8", :primary => true # This is where Rails migrations will run
#role :db,  "your slave db-server here"


default_run_options[:pty] = true

# If you are using Passenger mod_rails uncomment this:
# if you're still using the script/reapear helper you will need
# these http://github.com/rails/irs_process_scripts

namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end
end