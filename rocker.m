classdef rocker < matlab.System
    properties
        Height
        Angle
        PVC_ID
        PVC_OD
        
        Length
        PVC_Area
        m_Rocker
        j_Rocker
        m_wheel
        k_wheel
        a
        b
        
        A
        B
        
        omega
        theta
        
        weight_PVC = 0.063;
    end
    
    methods
        function createRocker(obj,height, angle, PVC_ID, PVC_OD)
            obj.Height = height;
            obj.Angle = angle;
            obj.PVC_ID = PVC_ID;
            obj.PVC_OD = PVC_OD;
            obj.LengthCalc
            obj.RockerMassCalc;
            obj.RockerJCalc;
        end
        function addWheels(obj,Mass_Wheel, K_Wheel)
            obj.m_wheel = Mass_Wheel;
            obj.k_wheel = K_Wheel;
        end
        function LengthCalc(obj)
            obj.Length = obj.Height/cosd(obj.Angle/2);
        end
       
        function RockerMassCalc(obj)
            obj.PVC_Area = ((obj.PVC_OD^2)-(obj.PVC_ID^2))*pi;
            obj.m_Rocker = 2*obj.weight_PVC * obj.Length * obj.PVC_Area;
        end
        function RockerJCalc(obj)
            I_1 = (1/3)*obj.m_Rocker *(obj.Length^2);
            obj.j_Rocker = I_1*2;
        end
        function simplified(obj)
            obj.a = 1 + ((1+obj.m_wheel)/obj.m_Rocker) - ((1+obj.m_wheel)/(obj.j_Rocker*obj.m_Rocker));
            obj.b = (1+obj.m_wheel)*(1-(1/obj.j_Rocker))/(obj.m_Rocker*obj.a);
        end
        function linerazation(obj)
            obj.A = [0 0 (-1/obj.m_Rocker) 1/(obj.Length*obj.j_Rocker);
                     0 0 (-1/(obj.Length*obj.j_Rocker)) (-1/obj.m_Rocker);
                     ((1-(1/obj.j_Rocker))/obj.a)*obj.k_wheel ((1-(1/obj.j_Rocker))/obj.a)*obj.k_wheel 0 0;
                     ((1-obj.b)*obj.k_wheel)/obj.Length ((1-obj.b)*obj.k_wheel)/obj.Length 0 0];
             obj.B = [1, 0, 0,0;0,1,0,0]';
        end
        function stateDervative = StateEq(obj,t, state,road)
            x_1 = state(1);
            x_2 = state(2);
            p = state(3);
            h = state(4);
            timeStep = mod(int16(mod(t,road.numSteps))+1,road.numSteps)+1;
            stateDervative = [road.path(1,timeStep) - ((1/obj.Length)*(h/obj.j_Rocker)-p/obj.m_Rocker);
                       road.path(1,(mod(timeStep+1, road.numSteps)+1)) - (1/obj.Length)*(h/obj.j_Rocker) - p/obj.m_Rocker;
                       ((1-(1/obj.j_Rocker))/obj.a)*obj.k_wheel*x_1 + ((1-(1/obj.j_Rocker))/obj.a)*obj.k_wheel*x_2;
                        (((1-obj.b)*obj.k_wheel)/obj.Length)*x_1 + (((1-obj.b)*obj.k_wheel)/obj.Length)*x_2];
        end
        function drive(obj,Road)
            [t ,state] = ode45(@(t,state)obj.StateEq(t,state,Road),[0 Road.numSteps],[0;0;0;0]);
            plot(t,state(:,4));
            h = state(:,4);
            obj.omega = h/obj.m_Rocker;
            obj.theta = diff(obj.omega);
            plot(t(1:(length(t)-1)),rad2deg(obj.theta))
        end
    end
end

