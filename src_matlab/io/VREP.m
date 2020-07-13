classdef VREP
    %   VREP: is a V-REP simulator communications object
    %   This class handles the interface to the simulator and 
    %   low-level object handle operations
    %
    %   A VREP object holds all information related to 
    %   the state of a connection to an instance of the 
    %   V-REP simulator running on this or a networked computer. 
    %   It also allows the creation of references to other objects/models 
    %   in V-REP which can be manipulated in MATLAB
    
    properties
        address_ip
        port_number
        connect_wait
        reconnect
        time_out
        data_cycle
        client_ID
        
        
    end
    
    methods
        function obj = VREP(varargin)
            if nargin == 0 
            obj.Prop = varargin;
         end
      end
    end
    
end

