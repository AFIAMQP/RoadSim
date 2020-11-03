classdef road2 < matlab.System
    properties 
       height
       variance
        numSteps
        path
        pathInches
       step
       
    end
    methods 
        function newRoad(obj,height, numSteps)
            obj.height = height;
            obj.numSteps = numSteps;
            obj.varianceCalc;
           obj.PathCreator;
            obj.Roadplot
      end
        function varianceCalc(obj)
            obj.variance = obj.height/3.1;
        end
        function PathCreator(obj)
            obj.path = normrnd(0, obj.variance, [1,obj.numSteps]);
            for i = 1:obj.numSteps
                if obj.path(i)> obj.height
                    obj.path(i) = obj.height;
                elseif obj.path(i)< -obj.height
                    obj.path(i) = -obj.height;
                end
            end
            for l = 1:obj.numSteps
                tens = l *10;
                for k = 1:9
                    ones = k;
                    stepInches = tens + ones;
                    obj.pathInches(1,stepInches) = obj.path(l);
                end
            end
        end
    function plot_road = Roadplot(obj)
        obj.step = zeros(1,obj.numSteps);
        for m = 1: obj.numSteps
            obj.step(1,m*10) = obj.path(m);
            tens_m = (m-1);
            for n = 1:10
                ones_m = (n-1)*.1;
                step_m = tens_m + ones_m;
                count = int16((step_m *10)+1);
                obj.step(1,count) = step_m;
            end
        end
        plot_road = plot(obj.step,obj.pathInches(1,1:length(obj.pathInches)-9));
    end
    end
end