classdef idealCar < matlab.System
    properties(Constant)
       m_s = 3400;%kg
       k_s = 270000 %N/M
       c_s = 6000 %Ns/m
       m_t = 350 %N/M
       k_t = 950000 %N/m
    end
    methods
        function Xprime = StateEq(obj, Rin,X)
            A = [0 1/obj.m_t 0 0
                 obj.k_t 0 0 -1
                 0 0 0 1/obj.m_s
                 obj.k_t -1 0 0];
             B = [1;1;0;0];
             U = Rin;
             Xprime = A*X + B*U;
        end
        function Xprime = XprimeOverTime(obj,Rin)
            Xprime = zeros(10,4);
            for i= 1:10
                if (i == 1)
                    Xcurrent = [0;0;0;0];
                    deltaH = Rin;
                else
                    Xcurrent = Xprime(i-1,1:4)';
                    deltaH = 0;
                end
                Xprime(i,1:4) = obj.StateEq(deltaH,Xcurrent);
            end
        end
    end
end