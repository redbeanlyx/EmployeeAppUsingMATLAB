classdef (Sealed) thiscount < handle 
   properties(Access = public)
        number = 0
   end
   methods
       function obj = thiscount(obj)
       end
       
       function obj = add(obj) 
           obj.number = obj.number +1;
       end
       
       function obj = clear(obj)
           obj.number = 0;
       end
   end
end
