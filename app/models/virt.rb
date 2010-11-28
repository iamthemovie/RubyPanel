class Virt
	require 'libvirt'	
	attr_accessor :connection, :list
	
	def self.openConnection(uri)
		@connection = Libvirt::open(uri)
	end
	def self.loadList
		@list = Array.new
		# Get list of IDs of running machines
		@connection.list_domains.each do | id |
			node = @connection.lookup_domain_by_id(id)
			@list <<  node.name
			node.free
		end
		# Get list of Names of stopped VMs
		@connection.list_defined_domains.each do | name |
			@list << name
		end
		@list.sort!
	end
	def self.list
		output = Array.new
		# Populate list with useful data
		@list.each do | name |
			node = @connection.lookup_domain_by_name(name)
			output << {
				:uuid => node.uuid,
				:name => node.name,
				:state => node.info.state,
				:memory => node.info.memory,
				:max_mem => node.info.max_mem,
				:cpu_time => node.info.cpu_time
				}
			node.free
		end
		return output
	end
	def self.info(name)
		node = @connection.lookup_domain_by_name(name)
		info = node.info
		node.free
		return info
	end
	def self.start(name)
		node = @connection.lookup_domain_by_name(name)
		if node.info.state == 5
			node.create()
		end
		node.free
	end
	def self.stop(name)
		node = @connection.lookup_domain_by_name(name)
		if node.info.state != 5
			node.destroy()
		end
		node.free
	end
	def self.suspend(name)
		node = @connection.lookup_domain_by_name(name)
		if node.info.state == 1
			node.suspend()
		end
		node.free
	end
	def self.resume(name)
		node = @connection.lookup_domain_by_name(name)
		if node.info.state == 3
			node.resume()
		end
		node.free
	end
	def self.close
		@connection.close
	end
end
