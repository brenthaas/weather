class String
	
	def convert_spaces
		self.gsub(/ /, '_')
	end

	def restore_spaces
		self.gsub(/_/, ' ')
	end
end