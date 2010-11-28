module ApplicationHelper
	def capabilities
	[
		{ :name => 'Start',    :command => :virtStart },
		{ :name => 'Destroy',  :command => :virtStop },
		{ :name => 'Suspend',  :command => :virtSuspend },
		{ :name => 'Resume',   :command => :virtResume },
		#{ :name => 'Shutdown', :command => :noop },
		#{ :name => 'Restart',  :command => :noop },

	]
	end	
	def state(state_id)
		case state_id
			when 0 : state = "0: No State"
			when 1 : state = "1: Running"
			when 2 : state = "2: Blocked"
			when 3 : state = "3: Suspended"
			when 4 : state = "4: Shut Down"
			when 5 : state = "5: Shut Off"
			when 6 : state = "6: Crashed"
		end	
		
		return state
	end
end
