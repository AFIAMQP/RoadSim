classdef road < matlab.System
    properties 
       IRI 
       numSteps
       IRIArray
       FlowInput
    end
    methods 
        function newRoad(obj,IRI, numSteps)
            obj.IRI = IRI;
            obj.numSteps = numSteps;
             IRIArray(obj);
        end
    
        function IRIArray(obj)
            obj.IRIArray = normrnd(obj.IRI, (obj.IRI/10), [1,obj.numSteps]);
           end
    end
end
   

