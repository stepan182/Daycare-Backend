worker_processes 2
working_directory "/var/www/vhosts/default/htdocs/"

preload_app true

timeout 30

listen "/var/www/vhosts/default/htdocs/tmp/sockets/unicorn.sock", :backlog => 64

pid "/var/www/vhosts/default/htdocs/tmp/pids/unicorn.pid"

stderr_path "/var/www/vhosts/default/htdocs/log/unicorn.stderr.log"
stdout_path "/var/www/vhosts/default/htdocs/log/unicorn.stdout.log"

before_fork do |server, worker|
    defined?(ActiveRecord::Base) and
        ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
    defined?(ActiveRecord::Base) and
        ActiveRecord::Base.establish_connection
end