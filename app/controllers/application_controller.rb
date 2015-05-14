class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

	before_action :method_start_log_message
  
  private

		def marshal_copy obj
			begin
				dumper = Marshal.dump(obj)
				Marshal.load(dumper)
			rescue
				puts "Marshal copy FAIL common utils"
				{'controller' => obj["controller"] ,'action' => obj["action"],'format' => obj["format"] }
			end
		end

		def method_start_log_message
			x = marshal_copy(params)
			x.delete('controller')
			x.delete('action')
			x.delete('format')
			@start_time_logger = Time.now
			puts
			puts "#{params["controller"].upcase} -#{params["action"].upcase} - request: #{(x)}"
		end

end
