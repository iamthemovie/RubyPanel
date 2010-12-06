module ApplicationHelper
	def state(state_id)
		case state_id
			when Virt::NO_STATE 		
				then return {:name => "No State", :class => 'NoState'}
			when Virt::RUNNING 			
				then return {:name => "Running", :class => 'Running'}
			when Virt::BLOCKED 			
				then return {:name => "Blocked", :class => 'Blocked'}
			when Virt::SUSPENDED 		
				then return {:name => "Suspended", :class => 'Suspended'}
			when Virt::SHUTTING_DOWN 	
				then return {:name => "Shut Down", :class => 'ShuttingDown'}
			when Virt::OFF 				
				then return {:name => "Shut Off", :class => 'Off'}
			when Virt::CRASHED 			
				then return {:name => "Crashed", :class => 'Crashed'}
		end
	end
	
	def capabilities(status)
		cap = Array.new
		# Display Start (Create) if the VM is Virt::OFF
		if status == Virt::RUNNING
			cap << { :name => 'Suspend',  :command => :virtSuspend }
			cap << { :name => 'Shutdown', :command => :noop }
			cap << { :name => 'Restart',  :command => :noop }
		end
		if status == Virt::SUSPENDED
			cap << { :name => 'Resume',   :command => :virtResume }
		end
		if status == Virt::OFF
			cap << { :name => 'Start',    :command => :virtStart }
		else # Display Destroy if domain is anything but Virt::OFF
			cap << { :name => 'Destroy',  :command => :virtStop }
		end
		return cap
	end
end	
