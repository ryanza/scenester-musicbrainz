threads 4,8
workers 2

preload_app!

bind  "unix:///var/www/search/shared/tmp/puma/streo-puma.sock"
pidfile "/var/www/search/current/tmp/puma/pid"
state_path "/var/www/search/current/tmp/puma/state"

activate_control_app

on_worker_boot do
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::Base.establish_connection
  end
end