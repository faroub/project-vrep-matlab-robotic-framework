classdef VREPSimScene  < handle
    %   VREPSim: is a communications object with the V-REP simulator 
    %   This class handles the interface to the simulator and 
    %   low-level object handle operations
    %
    %   A VREP object holds all information related to 
    %   the state of a connection to an instance of the 
    %   V-REP simulator running on this or a networked computer. 
    %   It also allows the creation of references to other objects/models 
    %   in V-REP which can be manipulated in MATLAB
    
    properties (Access = public)


        
    end
    
    properties (Access = protected)
  
        
        
    end
    
    properties (Access = private)
        
        stepTime
        syncMode
        addressIP
        portNumber
        connectWait
        reconnect
        timeOut
        dataCycle 
        clientID
        vrepObj
        error_code

        
        
    end

    
    methods  (Access = public)
        
        function obj = VREPSimScene(varargin)
            
            switch nargin
                case 0                 
                    error ('VREPSimScene: argument <1:simParams={addressIP,portNumber,connectWait,reconnect,timeOut,dataCycle}> must be provided')
                case 1

                    if isa(varargin{1}, 'VREPSimScene')

                        % check and clone the passed VREPSimScene object
                        obj = varargin{1};

                    else

                        arg = {{'127.0.0.1', 19997,true,true,5000,5},0.02,1}; 
                        arg{1}(1:length(varargin{1})) = varargin{1};
                        obj.addressIP =  checkParameterData(obj, 'addressIP', arg{1}{1});
                        obj.portNumber = checkParameterData(obj, 'portNumber', arg{1}{2});
                        obj.connectWait = checkParameterData(obj, 'connectWait', arg{1}{3});
                        obj.reconnect = checkParameterData(obj, 'reconnect', arg{1}{4});
                        obj.timeOut = checkParameterData(obj, 'timeOut', arg{1}{5});
                        obj.dataCycle = checkParameterData(obj, 'dataCycle', arg{1}{6});
                        obj.stepTime = checkParameterData(obj, 'stepTime', arg{2});
                        obj.syncMode = checkParameterData(obj, 'syncMode', arg{3});

                        % using the prototype file (remoteApiProto.m)
                        obj.vrepObj = remApi('remoteApi');

                        % open connection 
                        if (openConnection(obj)==-1)

                            error ('VREPSimScene: connection to remote API server [IP: %s, Port: %d] was not possible', obj.addressIP,obj.portNumber)              

                        else

                            msg = ['VREPSimScene: connection to remote API server [IP: ',obj.addressIP,', Port: ',num2str( obj.portNumber),'] established'];
                            disp(msg)   

                        end
                        % set simulation parameters : step time and synchronous mode
                        setSimulationParameters(obj, obj.stepTime, obj.syncMode);

                    end
                    
                case 2
                    
                        arg = {{'127.0.0.1', 19997,true,true,5000,5},0.02,1}; 
                        arg{1}(1:length(varargin{1})) = varargin{1};
                        arg{2} = varargin{2};                       
                        obj.addressIP =  checkParameterData(obj, 'addressIP', arg{1}{1});
                        obj.portNumber = checkParameterData(obj, 'portNumber', arg{1}{2});
                        obj.connectWait = checkParameterData(obj, 'connectWait', arg{1}{3});
                        obj.reconnect = checkParameterData(obj, 'reconnect', arg{1}{4});
                        obj.timeOut = checkParameterData(obj, 'timeOut', arg{1}{5});
                        obj.dataCycle = checkParameterData(obj, 'dataCycle', arg{1}{6});
                        obj.stepTime = checkParameterData(obj, 'stepTime', arg{2});
                        obj.syncMode = checkParameterData(obj, 'syncMode', arg{3});
                        
                        % using the prototype file (remoteApiProto.m)
                        obj.vrepObj = remApi('remoteApi');

                        % open connection 
                        if (openConnection(obj)==-1)

                            error ('VREPSimScene: connection to remote API server [IP: %s, Port: %d] was not possible', obj.addressIP,obj.portNumber)              

                        else

                            msg = ['VREPSimScene: connection to remote API server [IP: ',obj.addressIP,', Port: ',num2str( obj.portNumber),'] established'];
                            disp(msg)   

                        end
                        % set simulation parameters : step time and synchronous mode
                        setSimulationParameters(obj, obj.stepTime, obj.syncMode);

                     
                    
                   
                case 3
                    
                        arg = {{'127.0.0.1', 19997,true,true,5000,5},0.02,1}; 
                        arg{1}(1:length(varargin{1})) = varargin{1};
                        arg{2} = varargin{2}; 
                        arg{3} = varargin{3};  
                        obj.addressIP =  checkParameterData(obj, 'addressIP', arg{1}{1});
                        obj.portNumber = checkParameterData(obj, 'portNumber', arg{1}{2});
                        obj.connectWait = checkParameterData(obj, 'connectWait', arg{1}{3});
                        obj.reconnect = checkParameterData(obj, 'reconnect', arg{1}{4});
                        obj.timeOut = checkParameterData(obj, 'timeOut', arg{1}{5});
                        obj.dataCycle = checkParameterData(obj, 'dataCycle', arg{1}{6});
                        obj.stepTime = checkParameterData(obj, 'stepTime', arg{2});
                        obj.syncMode = checkParameterData(obj, 'syncMode', arg{3});
                        
                        % using the prototype file (remoteApiProto.m)
                        obj.vrepObj = remApi('remoteApi');

                        % open connection 
                        if (openConnection(obj)==-1)

                            error ('VREPSimScene: connection to remote API server [IP: %s, Port: %d] was not possible', obj.addressIP,obj.portNumber)              

                        else

                            msg = ['VREPSimScene: connection to remote API server [IP: ',obj.addressIP,', Port: ',num2str( obj.portNumber),'] established'];
                            disp(msg)   

                        end
                        % set simulation parameters : step time and synchronous mode
                        setSimulationParameters(obj, obj.stepTime, obj.syncMode);
                        
                            
                otherwise
                        
                    error ('VREPSimRobot: usage error, please check documentation')

                    
            end
        end
        
        function out = openConnection(obj)
            
            obj.clientID = obj.vrepObj.simxStart(obj.addressIP,obj.portNumber,obj.connectWait,obj.reconnect,obj.timeOut,obj.dataCycle);           
            out = obj.clientID;
            
        end
        function closeAllConnections(obj)
            
            obj.vrepObj.simxFinish(-1);    
        
        end
        
        function closeConnection(obj)
        
            if (getConnectionID(obj)~=-1)
                
                obj.vrepObj.simxFinish(obj.clientID); 
                    
            end
            
        end
        
        
        function pauseCommunication(obj,enable)
            
            if (enable)                
                
                obj.error_code{1,1} = obj.vrepObj.simxPauseCommunication(obj.clientID,1);
                obj.error_code{1,2}='pauseCommunication';
              
                
            else
                
                obj.error_code{1,1} = obj.vrepObj.simxPauseCommunication(obj.clientID,0);
                obj.error_code{1,2}='pauseCommunication';
              
                
            end
            
        end
        
        function enableSynchronousMode(obj,enable)

            if nargin == 1
                
                 enable = 1;
                 
            end
            
            if (enable)
                obj.error_code{2,1} = obj.vrepObj.simxSynchronous(obj.clientID,true);
                obj.error_code{2,2} = 'enableSynchronousMode'; 
              
            else
                
                obj.error_code{2,1} = obj.vrepObj.simxSynchronous(obj.clientID,false);
                obj.error_code{2,2} = 'enableSynchronousMode'; 
              
            end
            
        end
        
        function execSimStep(obj)
        
            sendSynchronousTrigger(obj);
            getPingTime(obj);   
        
        end
        
        function setSimulationParameters(obj, stepTime, syncMode)
            
            if (syncMode == 1) 
                enableSynchronousMode(obj,1);
                disp('SynchronousMode enabled: execSimStep() should be added at the end of simulation loop')
            else
                enableSynchronousMode(obj,0);
            end

                setSimulationTimeStep(obj,stepTime);
       
        end
        
        function startSimulation(obj, operationMode)
             
            
            if nargin == 1
                    operationMode = 'oneshot';
            end
                                
            % start simulation
            obj.error_code{3,1} = obj.vrepObj.simxStartSimulation(obj.clientID,validateOperationMode(obj,operationMode));
            obj.error_code{3,2} = 'startSimulation';
            disp('Start V-REP simulation');

            
        end
        
        function stopSimulation(obj,operationMode)
             
            if nargin == 1
                 operationMode = 'oneshot';
             end
             
             
            obj.error_code{4,1} = obj.vrepObj.simxStopSimulation(obj.clientID,validateOperationMode(obj,operationMode));
            obj.error_code{4,2} = 'stopSimulation';             
            disp('Stop V-REP simulation');

            
        end
        
        function pauseSimulation(obj,operationMode)
             
            if nargin == 1
                 operationMode = 'oneshot';
            end
             
            obj.error_code{5,1} = obj.vrepObj.simxPauseSimulation(obj.clientID,validateOperationMode(obj,operationMode));
            obj.error_code{5,2} = 'pauseSimulation';
            disp('Pause V-REP simulation');
            
        end
        
        function out = getConnectionID(obj)
           
            out = obj.vrepObj.simxGetConnectionId(obj.clientID);
            
        end
      
        function out = getPingTime(obj)
           
             [obj.error_code{6,1},out] = obj.vrepObj.simxGetPingTime(obj.clientID);
              obj.error_code{6,2} = 'getPingTime';
        end
        
        function sendSynchronousTrigger(obj)
           
            obj.error_code{7,1} = obj.vrepObj.simxSynchronousTrigger(obj.clientID);
            obj.error_code{7,2} = 'sendSynchronousTrigger';
            
        end
       
        function out = validateOperationMode(obj,operationMode)
           
           if (ismember(operationMode,{'oneshot', 'blocking', 'streaming', 'oneshot_split', 'streaming_split', 'discontinue', 'buffer', 'remove'})) 
               
                switch operationMode
                    case 'oneshot'
                        out =  obj.vrepObj.simx_opmode_oneshot;
                    case 'blocking'
                        out =  obj.vrepObj.simx_opmode_blocking;
                    case 'streaming'
                        out =  obj.vrepObj.simx_opmode_streaming;
                    case 'oneshot_split'
                        out =  obj.vrepObj.simx_opmode_oneshot_split;       
                    case 'streaming_split'
                        out =  obj.vrepObj.simx_opmode_streaming_split;        
                    case 'discontinue'
                        out =  obj.vrepObj.simx_opmode_discontinue;  
                    case 'buffer'
                        out =  obj.vrepObj.simx_opmode_buffer;  
                    case 'remove'
                        out =  obj.vrepObj.simx_opmode_remove;                                   
                end
           else
               error ('argument <1:operationMode> must be a member of this set : { oneshot, blocking, streaming, oneshot_split, streaming_split, discontinue, buffer, remove }')
           end
        end
                                   
        function out = getObjectHandle(obj,objectName,operationMode)
            
            switch nargin
                case 1
                    error ('argument <1:objectName> is required ') 
                case 2
                    operationMode = 'blocking';
            end
            
            [obj.error_code{12,1} ,out]= obj.vrepObj.simxGetObjectHandle(obj.clientID,objectName,validateOperationMode(obj,operationMode));
            obj.error_code{12,2} = 'getObjectHandle';
            
        end
        
        function setSimulationTimeStep(obj,stepTime,operationMode)
            
            switch nargin
                case 1
                    error ('argument <1:stepTime> is required ') 
                case 2
                    operationMode = 'oneshot';
            end
            
            
            [obj.error_code{13,1}]= obj.vrepObj.simxSetFloatingParameter(obj.clientID,obj.vrepObj.sim_floatparam_simulation_time_step,stepTime,validateOperationMode(obj,operationMode));
            obj.error_code{13,2} = 'setSimulationTimeStep';


        end
        
        function out = getObjectPosition(obj,objectHandle,parentHandle,operationMode)
            
            switch nargin
                case 1
                    error ('argument <1:objectHandle> and <2:parentHandle> is required ') 
                case 2
                     error ('argument <2:parentHandle> is required ') 
                 case 3
                    operationMode = 'buffer';
            end
            
            switch operationMode                
                case 'buffer'
                     [obj.error_code{14,1},data] = obj.vrepObj.simxGetObjectPosition(obj.clientID,objectHandle, parentHandle, validateOperationMode(obj,operationMode));
                     out = double(data);
                     while (obj.error_code{14,1}~=obj.vrepObj.simx_return_ok)                     
                        [obj.error_code{14,1},data] = obj.vrepObj.simxGetObjectPosition(obj.clientID,objectHandle, parentHandle, validateOperationMode(obj,operationMode));
                        out = double(data);
                     end                    
                case 'streaming'                    
                     [obj.error_code{14,1},data] = obj.vrepObj.simxGetObjectPosition(obj.clientID,objectHandle, parentHandle, validateOperationMode(obj,operationMode));                    
                     out = double(data);
                     while (obj.error_code{14,1}~=obj.vrepObj.simx_return_ok)                     
                        [obj.error_code{14,1},data] =obj.vrepObj.simxGetObjectPosition(obj.clientID,objectHandle, parentHandle, validateOperationMode(obj,operationMode));
                        out = double(data);
                     end    
            
            end                         
            obj.error_code{14,2} = 'getObjectPosition';            
            
        end
        
        function setObjectPosition(obj,objectHandle,parentHandle,position,operationMode)
            
            switch nargin
                case 1
                    error ('argument <1:objectHandle> and <2:parentHandle> is required ') 
                case 2
                    error ('argument <2:parentHandle> is required ') 
                case 3
                    position = [0 0 0];
                    operationMode = 'oneshot';
            end
            
            
            [obj.error_code{15,1}]= obj.vrepObj.simxSetObjectPosition(obj.clientID,objectHandle,parentHandle,position,validateOperationMode(obj,operationMode));
            obj.error_code{15,2} = 'setObjectPosition';


        end
        
        function setObjectOrientation(obj,objectHandle,parentHandle,eulerAngles,operationMode)
            switch nargin
                case 1
                    error ('argument <1:objectHandle> and <2:parentHandle> is required ') 
                case 2
                    error ('argument <2:parentHandle> is required ') 
                case 3
                    eulerAngles = [0 0 0];
                    operationMode = 'oneshot';
            end
            
            
            [obj.error_code{16,1}]= obj.vrepObj.simxSetObjectPosition(obj.clientID,objectHandle,parentHandle,eulerAngles,validateOperationMode(obj,operationMode));
            obj.error_code{16,2} = 'setObjectOrientation';
        
        end

        function out = getObjectOrientation(obj,objectHandle,parentHandle,operationMode)
            
            switch nargin
                case 1
                    error ('argument <1:objectHandle> and <2:parentHandle> is required ') 
                case 2
                     error ('argument <2:parentHandle> is required ') 
                 case 3
                    operationMode = 'buffer';
            end
            
            switch operationMode                
                case 'buffer'
                     [obj.error_code{17,1},data] = obj.vrepObj.simxGetObjectOrientation(obj.clientID,objectHandle, parentHandle, validateOperationMode(obj,operationMode));
                     out = double(data);
                     while (obj.error_code{17,1}~=obj.vrepObj.simx_return_ok)                     
                        [obj.error_code{17,1},data] = obj.vrepObj.simxGetObjectOrientation(obj.clientID,objectHandle, parentHandle, validateOperationMode(obj,operationMode));
                        out = double(data);
                     end                    
                case 'streaming'                    
                     [obj.error_code{17,1},data] = obj.vrepObj.simxGetObjectOrientation(obj.clientID,objectHandle, parentHandle, validateOperationMode(obj,operationMode));                    
                     out = double(data);
                     while (obj.error_code{17,1}~=obj.vrepObj.simx_return_ok)                     
                        [obj.error_code{17,1},data] = obj.vrepObj.simxGetObjectOrientation(obj.clientID,objectHandle, parentHandle, validateOperationMode(obj,operationMode));
                        out = double(data);
                     end    
            
            end                         
            obj.error_code{17,2} = 'getObjectOrientation';            
            
        end
        
        function out=getSimulationTimeStep(obj,operationMode)
            
            if nargin == 1
                operationMode = 'blocking';
            end
            
            
            [obj.error_code{18,1},data]= obj.vrepObj.simxGetFloatingParameter(obj.clientID,obj.vrepObj.sim_floatparam_simulation_time_step,validateOperationMode(obj,operationMode));
            out = double(data);
            obj.error_code{18,2} = 'getSimulationTimeStep';


        end
        
        function loadScene(obj,scenePathAndName,location, operationMode)
            
            switch nargin
                case 1
                    error ('argument <1:scenePathAndName> is required ') 
                case 2
                    location = 0;
                case 3
                    operationMode = 'blocking';
            end
            
            [obj.error_code{19,1}]= obj.vrepObj.simxLoadScene(obj.clientID,scenePathAndName,location,validateOperationMode(obj,operationMode));
            obj.error_code{19,2} = 'loadScene';
        
        
        end
        
        function delete(obj)
            % make sure that the last command sent out had time to arrive
            getPingTime(obj);    
            % stop vrep simulation
            stopSimulation(obj,'blocking');   
            % close opened connections
            closeConnection(obj);
            % explicitely call the destructor!
            obj.vrepObj.delete();
            disp('VREPSimScene object deleted');

        end
            
    end
    
    
     
    methods (Access = protected)
        
    end
    
    methods (Access = private)
        
        function out = checkParameterData(~, type, arg) 

            X = [type,' set to ',num2str(arg)];
            disp(X)   
            out=arg;

        end

    end
end

