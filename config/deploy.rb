# config valid for current version and patch releases of Capistrano
lock "~> 3.11.0"

set :application, "books_app"
set :repo_url, "git@github.com:UsaMomokawa/Rails_textbook.git"
set :deploy_to, "/var/www/books_app"

set :rbenv_ruby, "2.5.1"
set :rbenv_path, "/usr/local/rbenv"
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
append :rbenv_map_bins, "rake", "gem", "bundle", "ruby", "rails"
set :rbenv_roles, :all

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, false

# Default value for :linked_files is []
append :linked_files, "config/master.key", ".env"

# Default value for linked_dirs is []
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system", ".bundle"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# Uncomment the following to require manually verifying the host key before first deploy.
# set :ssh_options, verify_host_key: :secure

shared_path = "/var/www/books_app/shared"
set :puma_bind, "unix:///#{shared_path}/tmp/sockets/puma.sock"
set :puma_pid, "#{shared_path}/tmp/pids/puma.pid"
set :puma_state, "#{shared_path}/tmp/pids/puma.state"
set :puma_conf, "#{shared_path}/puma.rb"
