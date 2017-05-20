
function varargout = tsp_ga(varargin)

% Initialize default configuration (do not change this part)
defaultConfig.xy          = 10*rand(50,2); % xy is the coordinate matrix
defaultConfig.dmat        = [];            % dmat is the distance matrix
defaultConfig.popSize     = 200;
defaultConfig.numGen      = 2000;
defaultConfig.crossProb   = 0.25;
defaultConfig.mutProb     = 0.5;
defaultConfig.eliteFract  = 0.02;

% Interpret user configuration inputs (do not change this part)
if ~nargin
    userConfig = struct();
elseif isstruct(varargin{1})
    userConfig = varargin{1};
else
    try
        userConfig = struct(varargin{:});
    catch
        error('Expected inputs are either a structure or parameter/value pairs');
    end
end

% Override default configuration with user inputs (do not change this part)
configStruct = get_config(defaultConfig,userConfig);

% Extract configuration
xy          = configStruct.xy;   % xy is the coordinate matrix
dmat        = configStruct.dmat; % dmat is the distance matrix
popSize     = configStruct.popSize;
numGen      = configStruct.numGen;
crossProb   = defaultConfig.crossProb;
mutProb     = defaultConfig.mutProb;
eliteFract  = defaultConfig.eliteFract;

if isempty(dmat)
    nPoints = size(xy,1);
    a = meshgrid(1:nPoints);
    dmat = reshape(sqrt(sum((xy(a,:)-xy(a',:)).^2,2)),nPoints,nPoints);
end

% Verify Inputs (do not change this part)
[N,dims] = size(xy);
[nr,nc] = size(dmat);
if N ~= nr || N ~= nc
    error('Invalid XY or DMAT inputs!')
end
n = N; % make sure you do not use this varaible n for other puposes (e.g. for loop iteration)




%%%%%%%%%%%%%%%%% Initialize the Population %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%% You don't need to change this part%%%%%%%%%%%%%%%%%%%%%%%
pop = zeros(popSize,n); % Matrix pop maintains the current population
pop(1,:) = (1:n);
for k = 2:popSize
    pop(k,:) = randperm(n);
end
%%%%%%%%%%%%%%%%% End of Population Initialization %%%%%%%%%%%%%%%%%%%%%%%%



totalDist = zeros(1,popSize); 
% totalDist is the vector of distances.Each element of this vector corresponds
% to the total distance (i.e. length) of a member of the population.



%% Starting GA iterations. In each iteration, a new generation is created %%%%%%
for iter = 1:numGen
    
    % Function calcToursDistances evaluates Each population member and 
    % calculates the total distance of each member
    totalDist = calcToursDistances(pop, popSize, dmat, n);
    
    
    
    % Elite selection: you should use the information in matrix totalDist 
    % to select a fraction eliteFract of the best members of the current
    % population pop. Keep these elite members in matrix elitePop.
    % Your elite selection code goes here:
    eval=1./totalDist;
    eliteSize=(round(eliteFract*popSize));
    indexPop=ones(eliteSize,1);
    for i=1:popSize
        for j=1:eliteSize
           % fprintf('hhjjo');
           if eval(indexPop(j,1))>=eval(i) 
               indexPop(j)=i;
               break;
           end
            
        end
    end
    elitePop=zeros(eliteSize,n);
    %size(elitePop(1,1:end))
    %size(pop(1,1:end))
    %indexPop
    for i=1:eliteSize
       elitePop(i,1:end)=pop(indexPop(i),1:end); 
    end
    %%%%%%% end of elite selection %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    
    % Selection of new population: use totalDist to clacluate the fitness
    % and the cummulative probability distribution of the current population
    % pop. Then apply a roulette wheel selection to create a new population.
    % Keep this new population in matrix newPop.
    % Your roulette wheel selection code goes here:
    eval=1./totalDist;
    F=sum(eval);
    prob=eval./F;   
    %cumultative propability
    q=zeros(1,popSize);
    for i=1:popSize
        temp=0;
       for j=1:i
           temp=temp+prob(j);
       end
        q(1,i)=temp;     
       
    end
    
    %selection process
    newPop=zeros(popSize,n);
    m=0;
    count=1;
    while m~=popSize
        r=rand;
        if r<q(1,1)
            newPop(count,:)=pop(1,:);
            count=count+1;
            m=m+1;
        else
            for i=2:popSize
                
                if r>=q(i-1)&& r<q(i)
                    newPop(count,:)=pop(i,:);
                    count=count+1;
                    m=m+1;
                    
                end
            end
        end
    end
    
    %%%%%%% end of roulette wheel selection %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    
    % Update distance vector totalDist according to the selected population
    % newPop. Your code for updating totalDist goes here:
    totalDist = calcToursDistances(newPop, popSize, dmat, n);
    %%%%%% end of totalDist update %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    
    % Use the updated totalDist to calculate the new fitness values and 
    % cummulative probability distribution. Your code goes here:
    eval=1./totalDist;
    F=sum(eval);
    prob=eval./F;   
    %cumultative propability
    q=zeros(1,popSize);
    for i=1:popSize
        temp=0;
       for j=1:i
           temp=temp+prob(j);
       end
        q(1,i)=temp;     
       
    end
    %%%%%% end of fitness and probabilty distribution update %%%%%%%%%%%%%%
    
    
    
    
    % Cross-over operator: implement the cross-over procedure
    % described in the home assignment. Use the cross-over
    % probability crossProb to obtain the parents that should
    % be selected purely random from the population newPop.
    % Your code goes here:
    % your cross-over code
    T1=[];
    T2=[];
    T11=[];
    for i=1:popSize
       r=rand;
       if r<crossProb
          P1=newPop(i,:);
          indexP1=i;
          for e=i:popSize
              r1=rand;
              if r1<crossProb
                  P2=newPop(e,:);
                  indexP2=e;
                  break;
              end
          end
          if ~isequal(P2,[])
              %Do crossover
              K=floor(0.3*size(P1,2));
              O=[];
              T1=P1;
              T2=P2;
              %size(T1)
              while size(T1,2)~=0
                  minimum=min(size(T1,2),K);
                  T11=T1(1,1:minimum);
                  T12=T1(1,minimum+1:end);
                  O=[O T11];
                 % T1
                  %T2
                  %T11
                  %O
                  %size(O)
                  for i=1:size(T11,2)
                      m=1;
                      while 1
                          if T1(1,m)==T11(1,i)
                              T1(m)=[];                              
                          end
                          m=m+1;
                          if m>size(T1,2)
                              break;
                          end
                      end
                      if size(T2,2)~=0
                        k=1;
                          while 1
                              
                              if T2(1,k)==T11(1,i)
                                  T2(k)=[];
                              end
                              k=k+1;
                              if k>size(T2,2)
                                  break;
                              end
                          end
                      end
                      
                  end
                  X=T1;
                  T1=T2;
                  T2=X;
                  
              end
              
              r = rand();
              offspring = O;
              if r <= mutProb
                  off_indx = randi([1 popSize], 1, 1);
                   % replace this line of code so that the offspring
                  % will be the one created by the
                  % cross-over operation.
                  
                  routeInsertionPoints = sort(ceil(n*rand(1,2)));
                  I = routeInsertionPoints(1);
                  J = routeInsertionPoints(2);
                  
                  % 2-opt mutation (simply swaps two cities)
                  offspring([I J]) = offspring([J I]);
                  
                  % now, you should replace one of the parents invloved in
                  % cross-over with this mutated offspring, then update the
                  % population newPop.
              end
              %%%%%%%%%%%%% End of Mutation Operator %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
              
              random=randi(2);
             
              if random == 1
                  newPop(indexP1,:)=offspring(1,:);
              else
                  newPop(indexP2,:)=offspring(1,:);
              end
              
          end
          
       end
       P1=[];
       P2=[];
       
    end% after crossover and mutation
    
    
    
    
    
%     nbrOfCross=crossProb.*popSize;
%     chosen=[];
%    
%     for i=1:popSize
%         r=rand;
%         if r<crossProb
%             chosen(i,:)=newPop(i,:);
%           
%         end
%         
%     end
%     
%     if mod(size(chosen,1),2)~=0
%         r=randi(size(chosen,1));
%         chosen(r,:)=[];
%     end
%     
%     copy=chosen;
%     usedVector=zeros(size(newPop,1),1);
%     for f=1:(size(chosen,1)./2)
%         K=floor(0.3.*size(f,1));
%         r=randi(size(copy,1));
%         T1=copy(r,:);
%         P1=T1;
%         copy(r,:)=[];
%         r1=randi(size(copy,1));
%         T2=copy(r1,:);
%         P2=T2;
%         copy(r1,:)=[];
%         O=[];
%         
%         while size(T1,1)~=0
%             minimum=min(size(T1,1),K);
%             T11=T1(1:minimum);
%             T12=T1(minimum+1:end);
%             O=[O T11];
%             
%             for i=1:size(T11,1)
%                 
%                 for j=1:size(T1,1)
%                     if T1(j)==T11(i)
%                         T1(j)=[];
%                     end
%                 end
%                 
%                 for k=1:size(T2,1)
%                     if T2(k)==T11(i)
%                         T2(k)=[];
%                     end
%                 end
%                 
%             end
%             X=T1;
%             T1=T2;
%             T2=X;
%             
%         end
        
        
        %%%%%%% End of cross-over operator %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        
        
        
   
        
        
    %end  %end cross-over
    %%%%%%%%%% End of mutation operator %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    
    % Now, it is time to replace the worst members of newPop with the elite 
    % members you stored in matrix elitePop (see Elite selection in the begining
    % of this iteration).
    % Your code goes here:
   
     totalDist = calcToursDistances(newPop, popSize, dmat, n);
     eval=1./totalDist;
     indexWorst=ones(eliteSize,1);
     for i=1:size(eval,2)
        for j=1:eliteSize
           if eval(i)<eval(indexWorst(j))
               indexWorst(j)=i;
               break;
               
           end
            
        end
         
         
     end
    
    for i=1:eliteSize
       newPop(indexWorst(i),:)=elitePop(i,:);        
        
    end
    %%%%%%% End of elite replacement %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    % Finally, the new population newPop should become the current population.
     pop = newPop;    % Uncomment this line when you finished all previous
                       % steps.

end
%%%%%% End of GA ietartions %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% Now, we find the best route in the last generation (you don't need to
% change this part). The best route is returned in optRoute, and its 
% distance in minDist.
totalDist = calcToursDistances(pop, popSize, dmat, n);
[minDist,index] = min(totalDist);
optRoute = pop(index,:);

% Return Output (you don't need to change this part)
if nargout
    resultStruct = struct( ...
        'optRoute',    optRoute, ...
        'minDist',     minDist);
    
    varargout = {resultStruct};
end

end


% The following code is for configuation of user input (do not change
% this). Subfunction to override the default configuration with user inputs
function config = get_config(defaultConfig,userConfig)

% Initialize the configuration structure as the default
config = defaultConfig;

% Extract the field names of the default configuration structure
defaultFields = fieldnames(defaultConfig);

% Extract the field names of the user configuration structure
userFields = fieldnames(userConfig);
nUserFields = length(userFields);

% Override any default configuration fields with user values
for i = 1:nUserFields
    userField = userFields{i};
    isField = strcmpi(defaultFields,userField);
    if nnz(isField) == 1
        thisField = defaultFields{isField};
        config.(thisField) = userConfig.(userField);
    end
end

end

