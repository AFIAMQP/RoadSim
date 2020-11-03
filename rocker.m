classdef rocker < matlab.System
    properties
        Height
        Angle
        PVC_ID
        PVC_OD
        
        length
        PVC_Area
        m_Rocker
        j_Rocker
        m_wheel
        k_wheel
        a
        b
        
        x_1
        x_2
        p
        h
        
        weight_PVC = 0.063;
    end
    
    methods
        function createRocker(obj,height, angle, PVC_ID, PVC_OD)
            obj.Height = height;
            obj.Angle = angle;
            obj.PVC_ID = PVC_ID;
            obj.PVC_OD = PVC_OD;
            obj.RockerMassCalc;
            obj.RockerJCalc;
        end
        
        function lengthCalc(obj)
            obj.length = obj.Height/cosd(obj.Angle);
        end
       
        function RockerMassCalc(obj)
            obj.PVC_Area = ((obj.PVC_OD^2)-(obj.PVC_ID^2))*pi;
            obj.m_Rocker = obj.weight_PVC * obj.length * obj.PVC_Area;
        end
        function RockerJCalc(obj)
            I_1 = (1/3)*obj.m_Rocker *(obj.length^2);
            obj.j_Rocker = I_1*2;
        end
    end
end

