function varargout = wtcmngr(option,varargin)
%WTCMNGR Wavelet toolbox compression manager.
%
%  VARARGOUT = WTCMNGR(OPTION,VARARGIN)

%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 01-Aug-2001.
%   Last Revision: 09-Jun-2009.
%   Copyright 1995-2009 The MathWorks, Inc.
%   $Revision: 1.1.6.5 $  $Date: 2009/10/16 06:51:07 $ 

if isequal(option,'decode') || isequal(option,'encode')
    option = option(1:3);
end
switch option
    case 'meth_fam'
        switch varargin{1}
            case {'gbl_mmc_h','gbl_mmc_f','lvl_mmc'}
                varargout{1} = 'ctm';
            case {'ezw','spiht','spiht_3d','wdr','aswdr','stw'}
                varargout{1} = 'pscm';
            otherwise
                varargout{1} = '';
        end
  
    case 'meth_ident'
        switch varargin{1}
            case {'gbl_mmc_h','h'} ,  varargout{1} = 'h';
            case {'gbl_mmc_f','f'} ,  varargout{1} = 'f';
            case {'lvl_mmc','b'} ,    varargout{1} = 'b';
            case {'ezw','e'} ,        varargout{1} = 'e';
            case {'spiht','s'} ,      varargout{1} = 's';
            case {'spiht_3d','t'} ,   varargout{1} = 't';
            case {'wdr'} ,            varargout{1} = 'a';
            case {'aswdr'} ,          varargout{1} = 'c';
            case {'stw'} ,            varargout{1} = 'd';
        end
        
    case 'meth_name'
        switch varargin{1}
            case 'h' ,   varargout{1} = 'gbl_mmc_h';
            case 'f' ,   varargout{1} = 'gbl_mmc_f';
            case 'b' ,   varargout{1} = 'lvl_mmc';                
            case 'e' ,   varargout{1} = 'ezw';
            case 's' ,   varargout{1} = 'spiht';
            case 't' ,   varargout{1} = 'spiht_3d'; 
            case 'a' ,   varargout{1} = 'wdr'; 
            case 'c' ,   varargout{1} = 'aswdr';
            case 'd' ,   varargout{1} = 'stw';                 
        end

    case 'enc'
        methodCOMP = varargin{1};
        [funNAME,funHDL,codeID] = getFunNAME(methodCOMP);
        switch codeID
            case {'f','h'} , 
                varargout{1} = funHDL('enc',methodCOMP,varargin{2:end});
            otherwise
                varargout{1} = funHDL('enc',varargin{2:end});
        end
        
    case 'write'
        filename = varargin{1};
        methodCOMP = varargin{2};
        nbout = nargout;
        [funNAME,funHDL,codeID] = getFunNAME(methodCOMP);
        switch codeID
            case {'f','h'} , 
                varargout{1} = funHDL('enc',methodCOMP,varargin{3:end});
            otherwise
                varargout{1} = funHDL('enc',varargin{3:end});
        end
        [varargout{2:nbout}] = wtcmngr('save',filename,methodCOMP,varargout{1});
 
    case 'dec'
        methodCOMP = varargin{1};
        WTC_Struct = varargin{2};
        if nargin<4 , stepFLAG = 0; else stepFLAG = varargin{3}; end
        [funNAME,funHDL] = getFunNAME(methodCOMP);
        nbout = nargout;
        [varargout{1:nbout}] = funHDL('dec',WTC_Struct,stepFLAG);
        
    case 'read'
        filename = varargin{1};
        if nargin<3 , stepFLAG = NaN; else stepFLAG = varargin{2}; end
        nbout = nargout;
        try
            [WTC_Struct,methodCOMP] = wtcmngr('load',filename);
        catch ME %#ok<NASGU>
            old_DIR = cd;
            tmp = tempdir;
            cd(tmp)
            [P,fname,ext] = fileparts(filename);
            New_filename = [tmp , fname ,ext];
            [WTC_Struct,methodCOMP] = wtcmngr('load',New_filename);
            cd(old_DIR)
        end
        [funNAME,funHDL] = getFunNAME(methodCOMP);
        [varargout{1:nbout}] = funHDL('dec',WTC_Struct,stepFLAG);
        
    case 'save'
        filename = varargin{1};
        methodCOMP = lower(varargin{2});
        nbout = nargout;
        [funNAME,funHDL] = getFunNAME(methodCOMP);
        try
            [varargout{1:nbout}] = ...
                funHDL('save',filename,varargin{3:end});
        catch ME %#ok<NASGU>
            old_DIR = cd;
            tmp = tempdir;
            cd(tmp)
            [P,fname,ext] = fileparts(filename);
            New_filename = [tmp , fname ,ext];
            [varargout{1:nbout}] = ...
                funHDL('save',New_filename,varargin{3:end});
            cd(old_DIR)            
        end
 
    case 'load'
        filename = varargin{1};
        methodCOMP = modify_wtcfile('load',filename);
        varargout{2} = methodCOMP;
        [funNAME,funHDL] = getFunNAME(methodCOMP);
        varargout{1} =  funHDL('load',filename);
end

function [funNAME,fhandle,codeID] = getFunNAME(methodCOMP)

codeID = wtcmngr('meth_ident',methodCOMP);
switch codeID
    case {'f','h'} ,funNAME = 'wtc_gbl_mmc';  fhandle = @wtc_gbl_mmc;
    case 'b' ,      funNAME = 'wtc_lvl_mmc';  fhandle = @wtc_lvl_mmc;
    case 'e' ,      funNAME = 'wtc_ezw';      fhandle = @wtc_ezw;
    case 's' ,      funNAME = 'wtc_spiht';    fhandle = @wtc_spiht;
    case 't' ,      funNAME = 'wtc_spiht_3d'; fhandle = @wtc_spiht_3d;
    case 'a' ,      funNAME = 'wtc_wdr';      fhandle = @wtc_wdr;
    case 'c' ,      funNAME = 'wtc_aswdr';    fhandle = @wtc_aswdr;
    case 'd' ,      funNAME = 'wtc_stw';      fhandle = @wtc_stw;       
end

