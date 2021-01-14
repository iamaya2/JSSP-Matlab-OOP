%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % This function evaluates the instances created and determine whether % %
% % they are correct or not. For doing so, the function creates a copy  % %
% % of the instance and solves it with each heuristic from the          % %       
% % HEURIDrepository then it follows the fitness function described in  % %
% % EvaluateUPSOtoJSSP_Advanced according to the objective given while  % %
% % calling the function.                                               % %
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% % The parameters of the function are described as follows:            % %
% %                                                                     % %
% % folder:     It is the name in quotes of the folder where the        % %
% %             instances are located.                                  % %
% % heurID:     It is the ID of the heuristic used to improve or        % %
% %             diminish  1.- LPT  2.- SPT  3.- MPA  4.- LPA            % %
% % objective : 1. XvsAll  2. AllvsX                                    % %
% % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% % %                                                                    % %
% % nbJobs    : Number of Jobs of the instance to be checked;           % %
% %             Set to 3                                                % %
% % nbMachines: Number of Machines of the instance to be checked        % %  
% %             Set to 4                                                % %
% % nbRep     : Number of instances created for the parcticular         % %
% %             configuration;  set to 30                               % %
% % timeRanges: Range in which the operation times are set.             % %
% %             Set to [0 10]                                           % %
% %                                                                     % %
% % to change this use varargin(1), varargin(2), varargin(3) and        % %
% % varargin(4) respectively.                                           % %                                                % %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


function [performanceMatrix] = GeneralCheck_Advanced(folder,heurID, objective, delta, varargin)

folder2 = pwd;

nbJobs = 3;
nbMachines = 4;
nbRep = 30;
timeRanges = [0 10];

if nargin == 5, nbJobs = varargin{1}; end
if nargin == 6, nbMachines = varargin{2}; end
if nargin == 7, nbRep = varargin{3}; end
if nargin == 8, timeRanges = varargin{4}; end


%Convert numeric heurID to a three letter heurID
    if heurID == 1 
        heuristicID = "LPT"; 
    elseif heurID == 2 
        heuristicID = "SPT";
    elseif heurID == 3
        heuristicID = "MPA"; 
    elseif heurID == 4
        heuristicID = "LPA";
    end
    
    if objective == 1 
        addressID = heuristicID + "vsAll_J" + num2str(nbJobs) + "xM" + num2str(nbMachines);
    elseif objective == 2 
        addressID =  "Allvs" + heuristicID + "_J" + num2str(nbJobs) + "xM" + num2str(nbMachines);
    end
      
        
            for NB=1:nbRep;
%                 oldfolder= cd(folder2);
%                 oldfolder=cd(folder);
                PathAddress = char(folder2+"\"+folder+"\"+addressID+"\Delta_"+num2str(delta)+"\");
               
                if objective == 1
                    address= char("JSSPInstanceJ"+num2str(nbJobs)+"M"+num2str(nbMachines)+"T1"+num2str(timeRanges(1)) ...
                    +"T2"+num2str(timeRanges(2))+"Rep"+num2str(NB)+heuristicID+"vsAll.mat");
                elseif objective == 2
                    address= char("JSSPInstanceJ"+num2str(nbJobs)+"M"+num2str(nbMachines)+"T1"+num2str(timeRanges(1)) ...
                    +"T2"+num2str(timeRanges(2))+"Rep"+num2str(NB)+"Allvs"+heuristicID +".mat");
                end
%            
                JSSPInstance = {};
                addpath(genpath(PathAddress))
%                 oldfolder=cd(PathAddress);
                load(address)
%                 oldfolder= cd(folder2);
           
                
                perfDataMatrix(NB,1) = JSSPInstance{2};
                perfDataMatrix(NB,2) = delta;
                perfDataMatrix(NB,3) = makespan(JSSPInstance{1}, 1);
                perfDataMatrix(NB,4) = makespan(JSSPInstance{1}, 2);
                perfDataMatrix(NB,5) = makespan(JSSPInstance{1}, 3);
                perfDataMatrix(NB,6) = makespan(JSSPInstance{1}, 4);
            
            end
     filename=[addressID+"_Delta_"+num2str(delta)]
   
     %oldfolder= cd(folder2);
         save(filename, 'perfDataMatrix');
     performanceMatrix = perfDataMatrix;
     rmpath(genpath(PathAddress))
     nan=0;
end
    
        

