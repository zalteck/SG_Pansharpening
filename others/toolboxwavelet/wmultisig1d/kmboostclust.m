function [S,iterMAX,Centers,SUMD,D] = kmboostclust(method,varargin)
%KMBOOSTCLUST - Boost clustering using kmeans method.

%   M. Misiti, Y. Misiti, G. Oppenheim, J.M. Poggi 26-Jun-2006.
%   Last Revision: 26-Sep-2006.
%   Copyright 1995-2006 The MathWorks, Inc.
%   $Revision: 1.1.6.1 $ $Date: 2006/11/19 22:14:36 $ 

switch method
    case {'kmeans','kmeans_MM','kmeans_ENT'}
        % Inputs.
        %--------
        switch method
            case {'kmeans','kmeans_MM'} , CQ_PAR = 'minmax';
            case 'kmeans_ENT' ,           CQ_PAR = 'entropy';
        end
        iterMAX = 3;
        X     = varargin{1};
        nbCLU = varargin{2};
        varargin(end+1:end+2) = {'maxclust',nbCLU};
        
        % Step 1: Initialization
        %------------------------
        loss = zeros(1,10);
        beta = zeros(1,10);
        nbSIG = size(X,1);
        weights = ones(1,nbSIG)/nbSIG;
        epsMAX = 0;
        idxLoop = 0;
        iter = 1;
        
        % Step 2:  Loop
        %------------------------        
        while iter<=iterMAX
            % 2.1 - Boostrap replicate.
            %--------------------------
            boostInt = cumsum(weights);
            boostVal = rand(1,nbSIG);
            boostIdx = zeros(1,nbSIG);
            for k = 1:nbSIG
                test = boostVal(k)-boostInt;
                boostIdx(k) = find(test<=0,1,'first');
            end
            %%%%%%%%%%%%%%%%%%%%%
            % boostIdx = 1:nbSIG;
            %%%%%%%%%%%%%%%%%%%%%
            Y = X(boostIdx,:);
            notINboost = setdiff(1:nbSIG,boostIdx);
            
            % 2.2 - Basic clustering algorithm.
            %----------------------------------            
            % S = mdwtkmeans(Y,varargin{3:end});
            % IdxCLU = S.IdxCLU;
            warning('off','stats:kmeans:EmptyCluster')
            try
                [IdxCLU,Centers,SUMD,D] = kmeans(Y,nbCLU,varargin{3:end-2});
                
%                 S = mdwtcluster(Y,'maxclust',nbCLU,'lst2clu',{'s'});
%                 IdxCLU_SAV = IdxCLU;
%                 IdxCLU = S.IdxCLU;
%                 [Part,IdxCLU] = renumpart('col',[IdxCLU_SAV,IdxCLU]);
%                 IdxCLU = IdxCLU(:,2);

                
            catch
                stop = 666;
            end
            warning('on','stats:kmeans:EmptyCluster')
            
            % 2.3 - Get the cluster hypothesis.
            %----------------------------------
            DD = D;
            posIDX = D>0;
            DD(posIDX)  = 1./D(posIDX);
            DD(~posIDX) = 1E8;
            sD = sum(DD,2);
            DD = DD./sD(:,ones(1,nbCLU));
            % BOOST = [DD , IdxCLU]
 
            % 2.3-Plus - Set notINboost clusters.
            %------------------------------------
            nbNOT = length(notINboost);
            Z = [X(notINboost,:) ; Centers];
            dZ = squareform(pdist(Z));
            dZ = dZ(1:nbNOT,nbNOT+1:end);
            posIDX = dZ>0;
            dZ(posIDX)  = 1./dZ(posIDX);
            dZ(~posIDX) = 1E8;
            [maxi,cluNOT] = max(dZ,[],2);
            %% notBOOST = [dZ , cluNOT]
                        
            % 2.4 - Renumber the cluster indexes.
            %------------------------------------
            if iter>1
                [Part,IdxCLU_IN,effectif] = ...
                    renumpart('col',[Hag(:,iter-1),IdxCLU]);
                [I_OLD,idx] = unique(IdxCLU);
                I_NEW  = IdxCLU_IN(idx,2);
                IdxCLU = IdxCLU_IN(:,2);
                Hag(:,iter-1) = IdxCLU_IN(:,1);
                Centers = Centers(I_NEW,:);
                SUMD = SUMD(I_NEW);
                D  = D(:,I_NEW);
                DD = DD(:,I_NEW);
                dZ = dZ(:,I_NEW);
            end            
            
            % 2.3 - Get the cluster hypothesis.
            %----------------------------------
            H{iter} = zeros(nbSIG,nbCLU);
            for k=1:nbSIG
                idx = boostIdx(k);
                H{iter}(idx,:) = H{iter}(idx,:) + DD(k,:);
            end
            for k=1:length(notINboost)
                idx = notINboost(k);
                H{iter}(idx,:) = H{iter}(idx,:) + dZ(k,:);
            end
            somme  = sum(H{iter},2);
            idxPOS = (somme>0);            
            for k = 1:nbCLU
                H{iter}(idxPOS,k) = H{iter}(idxPOS,k)./somme(idxPOS);
            end
            
            % 2.5 - Calculate the pseudoloss.
            %-------------------------------
            CQ   = CQ_Index(CQ_PAR,weights,H{iter});
            loss(iter) = 0.5*sum(weights.*CQ);
            beta(iter) = (1-loss(iter))/loss(iter);
            
            % 2.6 - Stopping criteria.
            %--------------------------
            if loss>0.5 , iterMAX = iter; break; end
            if loss<epsMAX
                idxLoop = idxLoop + 1;
                if idxLoop==3 , iterMAX = iter; break; end
                epsMAX  = loss;
                idxLoop = 0;
            end
            
            % 2.7 - Update distribution weights.
            %-----------------------------------
            weights = weights.*(beta(iter).^CQ);
            weights = weights/sum(weights);
            
            % 2.8 - Compute the aggregate cluster hypothesis.
            %------------------------------------------------
            somme = 0;
            for tau =1:iter
                somme = somme + log(beta(tau))*H{tau};
            end
            somme = somme/sum(log(beta(1:iter)));
            [maxi,index] = max(somme,[],2);
            Hag(:,iter) = index;
            
            % Next loop.
            %-----------
            iter = iter + 1;
        end
        S = Hag(:,iterMAX);
end

%--------------------------------------------------------------------------
function CQ = CQ_Index(type,weights,H)
% Cluster quality index

N  = length(weights);
CQ = zeros(1,N);
switch type
    case 'minmax'
        for i=1:N
            CQ(i) = 1-max(H(i,:))+min(H(i,:));
        end
    case 'entropy'
        for i = 1:N
            CQ(i) = -sum(xlogx(H(i,:)));
        end
end
%-------------------------------------------
function x = xlogx(x)

pos = x>0;
x(pos) = x(pos).*log(x(pos));
%--------------------------------------------------------------------------


