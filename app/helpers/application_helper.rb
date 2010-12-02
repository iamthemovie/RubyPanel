module ApplicationHelper
	def state(state_id)
		case state_id
			when Virt::NO_STATE 		        then state = "No State"
			when Virt::RUNNING 			then state = "Running"
			when Virt::BLOCKED 			then state = "Blocked"
			when Virt::SUSPENDED 		        then state = "Suspended"
			when Virt::SHUTTING_DOWN 	        then state = "Shut Down"
			when Virt::OFF 				then state = "Shut Off"
			when Virt::CRASHED 			then state = "Crashed"
		end
		
		return state
	end
	
	def capabilities(status)
		cap = Array.new
		# Display Start (Create) if the VM is Virt::OFF
		if status == Virt::OFF
			cap << { :name => 'Start',    :command => :virtStart }
		else # Display Destroy if domain is anything but Virt::OFF
			cap << { :name => 'Destroy',  :command => :virtStop }
		end
		if status == Virt::RUNNING
			cap << { :name => 'Suspend',  :command => :virtSuspend }
			cap << { :name => 'Shutdown', :command => :noop }
			cap << { :name => 'Restart',  :command => :noop }
		end
		if status == Virt::SUSPENDED
			cap << { :name => 'Resume',   :command => :virtResume }
		end
		return cap
	end
end	
