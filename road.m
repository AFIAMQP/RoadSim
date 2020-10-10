classdef road(IRI = IRI numSteps= numSteps) < matlab.System
    properties 
       IRI 
       numSteps
       IRIArray
       Input
    end
    methods 
        function newRoad(obj,IRI, numSteps)
            obj.IRI = IRI;
            obj.numSteps = numSteps;
             IRIArrayCreator(obj);
        end
    
        function obj.IRIArray = IRIArrayCreator(obj.IRI,obj.numSteps)
            obj.IRIArray = normrnd(obj.IRI, (obj.IRI/10), [1,obj.numSteps]);
        end
        function Road(obj)
            i = 1;
            IRI_0 = obj.IRI;
            for numSteps
              if i == 1
                  IRI_last = IRI_0;
                  x_last[1] = [0;0;0;0];
              else
                  IRI_last = IRIArray[i-1];
                  x_last[i] = [z.z_s_prime
                               z.z_s_dot_prime
                               obj.IRI(i-1)- x_last(i-1)
                               z.z_u_dot_prime];
              end
             Road_step[i] = RoadSolver(IRIArray[i], IRI_last, x_last);
             obj.input[i] = Road_step[i].R
            end
        end
    end
