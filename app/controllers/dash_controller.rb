class DashController < ApplicationController
	def command
		session[:command] = params[:command]
		session[:name] = params[:name]
		redirect_to '/dash/index'
	end
	def index
		# This variable should be put into config
		Virt.openConnection('qemu://deneb/system')
		# Decide what to do
		command = session[:command]
		session[:command] = nil
		case command
			when 'virtStart'
			Virt.start(session[:name])
			when 'virtStop'
			Virt.stop(session[:name])
			when 'virtSuspend'
			Virt.suspend(session[:name])
			when 'virtResume'
			Virt.resume(session[:name])
		end
		session[:name] = nil
		# Display normal index data
		Virt.loadList()
		@list = Virt.list()
		Virt.close()
	end
end
