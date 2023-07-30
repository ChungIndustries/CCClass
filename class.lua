function Class(base)
	local cls = {}  -- Create class object

	-- Check if this is a subclass and if so, copy over all methods from base
	if base and type(base) == 'table' then
		for i, e in pairs(base) do
    		cls[i] = e
    	end

		cls._base = base  -- Set base of subclass
	end

	cls.__index = cls  -- Set indexing to class-object 

	local mt = {
		__call = function(self, ...)  -- Constructor for objects of this class
			local obj = {}  -- New object instance
			setmetatable(obj, cls)  -- Copy over class attributes and methods

			-- Init
			if self.__init then
				self.__init(obj, ...)
			elseif base and base.init then
				base.__init(obj, ...)
			end

			return obj
		end
	}

	setmetatable(cls, mt)  -- "Transfer" __call method to class object

	return cls
end
