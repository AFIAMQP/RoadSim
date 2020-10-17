classdef road < matlab.System
    properties 
       IRI 
       numSteps
       IRIArray
       step
       Input
    end
    methods 
        function newRoad(obj,IRI, numSteps)
            obj.IRI = IRI;
            obj.numSteps = numSteps;
             IRIArrayCreator(obj);
             Road(obj);
        end
    
        function IRIArrayCreator(obj)
            obj.IRIArray = normrnd(obj.IRI, (obj.IRI/10), [1,obj.numSteps]);
        end
        function Road(obj)
            IRI_0 = obj.IRI;
            x_last = zeros(obj.numSteps,4);
            IRI_last = zeros(obj.numSteps,1);
            obj.step = zeros(obj.numSteps,4)
            obj.Input = zeros(obj.numSteps,1);
            for i = 1:obj.numSteps
              if i == 1
                  IRI_last(i) = IRI_0;
                  x_last(1,1:4) = [0;0;0;0];
              else
                  IRI_last(i,1) = obj.IRIArray(i-1);
                  x_last(i,1:4) = [obj.step(i-1,2)
                               obj.step(i-1,3)
                               (obj.IRIArray(i-1)- x_last(i-1))
                               obj.step(i-1,4)];
              end 
              obj.step(i,1:4) = RoadSolver(obj.IRIArray(i), IRI_last(i), x_last(i,1:4)');
             obj.Input(i) =obj.step(i,1);
            end
        end
    end
end