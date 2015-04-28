require 'rubygems'
require 'sinatra'
require 'open3'
require 'version'

module RiemannClub
  class Application < Sinatra::Base

    configure :production do
      log = File.new("log/production.log", "a")
      STDOUT.reopen(log)
      STDERR.reopen(log)
    end

    set :public_folder, File.join(File.dirname(__FILE__), '../public')

    enable :logging, :dump_errors, :raise_errors, :show_exceptions

    enable :sessions

    not_found do
      "Page not found"
    end

    before do
      @app_name = "Riemann.Club Configuration Validator"
      @version = RiemannClub::VERSION
    end

    get '/' do
      erb :index
    end

    post '/' do
      @config = params[:config] || nil
      t = Tempfile.new("validate_temp")
      t << @config
      t.flush
      validate(t)
      erb :index
    end

    helpers do
      def validate(t)
        output = []
        cmd = "java -jar /tmp/riemann-syntax-check-0.2.0-standalone.jar #{t.path}"
        Open3.popen2e(cmd) do |stdin, stdout_stderr, wait_thread|
            stdout_stderr.each {|l| output << l }
        end
        if output == []
          @valid = "That's a valid configuration partner!"
        else
          @line = findline(output.first)
          @results = output.first
        end
      end

      def findline(output)
        if output =~ /.*validate_temp\S+\:(\d+)/
          $1
        end
      end
    end
  end
end
