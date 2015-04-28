# set path to app that will be used to configure unicorn, 
# note the trailing slash in this example
@dir = "/var/www/html/riemannclub/"

worker_processes 2
working_directory @dir

timeout 30

preload_app true

# Specify path to socket unicorn listens to, 
# we will use this in our nginx.conf later
listen "#{@dir}tmp/sockets/unicorn.sock", :backlog => 64
#listen "127.0.0.1:5000", :tcp_nopush => true

# Set process id path
pid "#{@dir}tmp/pids/unicorn.pid"

# Set log file paths
stderr_path "#{@dir}log/unicorn.stderr.log"
stdout_path "#{@dir}log/unicorn.stdout.log"
