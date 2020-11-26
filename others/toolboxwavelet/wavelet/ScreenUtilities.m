%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A simple MCOS class with helper functions to go out to java and
% fetch screen information.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
classdef ScreenUtilities
    
    methods(Static, Access='private')
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Returns all available devices
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function devices = getAllDevices
           assert(ScreenUtilities.checkIfJavaIsAvailable);
           gphxEnviroment = java.awt.GraphicsEnvironment.getLocalGraphicsEnvironment();
           devices = gphxEnviroment.getScreenDevices();
        end
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Returns the number of devices
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function numScreens = getNumberOfScreenDevices
            assert(ScreenUtilities.checkIfJavaIsAvailable);
            devices = ScreenUtilities.getAllDevices;
            numScreens =  devices.length;
        end
  
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % 0 based indexing
        % Example:
        % getScreenAtIndex(0) - gives first monitor
        % getScreenAtIndex(1) - gives second monitor
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function screen = getScreenAtIndex(index)
            assert(ScreenUtilities.checkIfJavaIsAvailable);
            devices = ScreenUtilities.getAllDevices;
            screenRect = devices(index+1).getDefaultConfiguration.getBounds;
            screen = [screenRect.getX() screenRect.getY() screenRect.getWidth() screenRect.getHeight()];
            
        end
        
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %Return the primary rectangle
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function primaryScreen = getPrimaryScreenRectangle
            assert(ScreenUtilities.checkIfJavaIsAvailable);
            gphxEnvironment = java.awt.GraphicsEnvironment.getLocalGraphicsEnvironment();
            defaultDeviceConfigBounds = gphxEnvironment.getDefaultScreenDevice.getDefaultConfiguration.getBounds;           
            primaryScreen = [defaultDeviceConfigBounds.getX() defaultDeviceConfigBounds.getY() defaultDeviceConfigBounds.getWidth() defaultDeviceConfigBounds.getHeight()];
        end
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Assert if java is not available
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function available = checkIfJavaIsAvailable
            persistent gphxEnviroment;
            available = true;
            if (isempty(gphxEnviroment))
                try
                    gphxEnviroment = java.awt.GraphicsEnvironment.getLocalGraphicsEnvironment();
                catch ex
                    available = false;
                end
            end
        end
        
    end
    
    
    methods(Static)
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % The only public API in this class that attempts to do
        % what root monitorpositions does without ambiguity/vagueness
        % NOTE: This is always in pixels!!!! Use hgconvertunits to convert
        % from 1 units to another.
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        function monitorPositions = getMonitorPositions
            numScreens = ScreenUtilities.getNumberOfScreenDevices;
            primaryScreen = ScreenUtilities.getPrimaryScreenRectangle;
            primaryHeight = primaryScreen(4);
            pixOrigin = 1;
            monitorPositions = zeros(numScreens,4);
            for i=1:numScreens
                screenRectangle = ScreenUtilities.getScreenAtIndex(i-1);
                convertedX = screenRectangle(1) + pixOrigin;
                convertedY = primaryHeight - screenRectangle(4) + pixOrigin;
                monitorPositions(i,:) = [convertedX convertedY screenRectangle(3) screenRectangle(4)];
            end
        end
    end
    
end

