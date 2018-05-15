classdef (Sealed) thiscount < handle 
   properties(Access = public)
        number = 1
   end
   methods
       function obj = thiscount(obj)
       end
       
       function obj = add(obj) 
           obj.number = obj.number +1;
       end
   end
end
