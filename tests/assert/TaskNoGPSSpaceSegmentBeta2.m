classdef TaskNoGPSSpaceSegmentBeta2<BaseTask
    % Task used to test assertions on DT
    %
    methods (Sealed,Access=public)
        
        function taskparams=init(obj)
            % loads and returns all the parameters for the various simulator objects
            
            % Simulator step time in second this should not be changed...
            taskparams.DT = 0.02;
            
            taskparams.seed = 0; %set to zero to have a seed that depends on the system time
            
            %%%%% visualization %%%%%
            % 3D display parameters
            taskparams.display3d.on = 0;
            taskparams.display3d.width = 1000;
            taskparams.display3d.height = 600;            
            
            %%%%% environment %%%%%
            % these need to follow the conventions of axis(), they are in m, Z down
            % note that the lowest Z limit is the refence for the computation of wind shear and turbulence effects
            taskparams.environment.area.limits = [-10 20 -7 7 -20 0];
            taskparams.environment.area.type = 'BoxArea';
            
            % originutmcoords is the location of the RVC (our usual flying site)
            % generally when this is changed gpsspacesegment.orbitfile and 
            % gpsspacesegment.svs need to be changed
            [E N zone h] = llaToUtm([51.71190;-0.21052;0]);
            taskparams.environment.area.originutmcoords.E = E;
            taskparams.environment.area.originutmcoords.N = N;
            taskparams.environment.area.originutmcoords.h = h;
            taskparams.environment.area.originutmcoords.zone = zone;

            taskparams.environment.area.graphics.type = 'AreaGraphics';
            
            % GPS
            % The space segment of the gps system
            taskparams.environment.gpsspacesegment.on = 1; % if off the gps returns the noiseless position
            taskparams.environment.gpsspacesegment.dt = 0.2;
            
            taskparams.environment.gpsspacesegment.type = 'GPSSpaceSegmentGM2';  
            % real satellite orbits from NASA JPL
            taskparams.environment.gpsspacesegment.orbitfile = 'ngs15992_16to17.sp3';
            % simulation start in GPS time, this needs to agree with the sp3 file above, 
            % alternatively it can be set to 0 to have a random initialization
            %taskparams.environment.gpsspacesegment.tStart = Orbits.parseTime(2010,8,31,16,0,0); 
            taskparams.environment.gpsspacesegment.tStart = 0;             
            % id number of visible satellites, the one below are from a typical flight day at RVC
            % these need to match the contents of gpsspacesegment.orbitfile
            taskparams.environment.gpsspacesegment.svs = [3,5,6,7,13,16,18,19,20,22,24,29,31];
            % the following model was instead designed to match measurements of real
            % data, it appears more relistic than the above
            taskparams.environment.gpsspacesegment.PR_BETA1 =  1.005;  % process time constant   
            taskparams.environment.gpsspacesegment.PR_SIGMA = 0.003;   % process standard deviation            
        end
        
        function r=reward(obj) 
            % nothing this is just a test task
        end
    end
    
end
