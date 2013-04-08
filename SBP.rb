require "thor"

class SBP < Thor
	include Thor::Actions

	def self.source_root
		File.dirname(__FILE__)
	end

	desc "create PATH", "Create project at located PATH"
	option :environment
	option :logging, type: :boolean
	option :sessions, type: :boolean
	option :method_override, type: :boolean
	option :root
	option :static, type: :boolean
	option :public_folder
	option :views
	option :run, type: :boolean
	option :server, type: :array
	option :bind
	option :bind, type: :numeric
	option :app_file
	option :dump_errors, type: :boolean
	option :raise_errors, type: :boolean
	option :lock, type: :boolean
	option :show_exceptions, type: :boolean



	def create(path)
		last_path_segment = File.basename(path)
		empty_directory path

		full_created_app_path = "#{path}/#{last_path_segment}.rb"
		copy_file "template.rb", "#{full_created_app_path}"

		inject_into_file "#{path}/#{last_path_segment}.rb", "Class #{last_path_segment.capitalize} < Sinatra::Base\n\n end", after: "require \"sinatra/base\"\n"

		#if option[:environment]
			#inject_into_file "#{path}/#{last_path_segment}.rb", "#{option[:environment]}", after: "Class #{last_path_segment} < Sinatra::Base\n"
		#end
		
	end
	
end

SBP.start ARGV