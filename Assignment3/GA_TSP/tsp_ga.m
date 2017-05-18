
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
    eliteSize = round(eliteFract*popSize);
    elitePop = zeros(eliteSize,n);
    fitness = 1./totalDist;
    eliteIndex = zeros(1,eliteSize);
    
    for b=1:popSize
        for c=1:eliteSize
            if fitness(b) < fitness(eliteIndex(c))
                eliteIndex(c) = b;
                break
            end
            
        end
    end
    
    for d=1:eliteSize
        elitePop(d) = pop(eliteIndex(d));
    end
    
    % ...
    % ...
    % ...
    %%%%%%% end of elite selection %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    
    % Selection of new population: use totalDist to clacluate the fitness
    % and the cummulative probability distribution of the current population
    % pop. Then apply a roulette wheel selection to create a new population.
    % Keep this new population in matrix newPop.
    % Your roulette wheel selection code goes here:
    fitvals = 1./totalDist;
    F = sum(fitvals);
    probabilities = fitvals./F;
    q = zeros(1,popSize);
    
    for i=1:popSize
        temp = 0;
        for j=1:i
            temp = temp + probabilities(j);
        end
        q(i) = temp;
    end
    
    %selection
    newPop = zeros(popSize,n);
    
    for a=1:popSize
        r = rand();
        if r < q(1)
            newPop(a) = pop(1);
        else
            for m=2:popSize
                if q(a-1) < r && q(a) >= r
                    newPop(a) = pop(m);
                end   
            end
        end 
    end
    % ...
    % ...
    % ...
    %%%%%%% end of roulette wheel selection %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    
    % Update distance vector totalDist according to the selected population
    % newPop. Your code for updating totalDist goes here:
    totalDist = calcToursDistances(newPop, popSize, dmat, n);
    % ...
    % ...
    % ...
    %%%%%% end of totalDist update %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    
    % Use the updated totalDist to calculate the new fitness values and 
    % cummulative probability distribution. Your code goes here:
    fitvals = 1./totalDist;
    F = sum(fitvals);
    probabilities = fitvals./F;
    q = zeros(1,popSize);
    
    for i=1:popSize
        temp = 0;
        for j=1:i
            temp = temp + probabilities(j);
        end
        q(i) = temp;
    end
    % ...
    % ...
    % ...
    %%%%%% end of fitness and probabilty distribution update %%%%%%%%%%%%%%
    
    
    
    
    % Cross-over operator: implement the cross-over procedure
    % described in the home assignment. Use the cross-over
    % probability crossProb to obtain the parents that should
    % be selected purely random from the population newPop.
    % Your code goes here:
    % your cross-over code
    chosen = [];
    for e=1:popSize
        random = rand();
        if r < crossProb
            chosen(i,:) = newPop(i,:);
        end
    end
    
    if mod(size(chosen,1),2) ~= 0
        r = randi(size(chosen,1));
        chosen(r,:) = [];
    end
    
    chosen_cpy = chosen;
    
    for f=1:(size(chosen,1)./2)
        K = floor(0.3.*size(chosen(f)));
        
        random = randi(size(chosen_cpy,1))
        T1 = chosen_cpy(random,1);
        P1 = T1;
        chosen_cpy(random,1) = [];
        random = randi(size(chosen_cpy,1))
        T2 = chosen_cpy(random,1);
        P2 = T2;
        chosen_cpy(random,1) = [];
        
        O = [];
        
        while size(T1) ~= 0
            min = min(size(T1,1),K);
            T_11 = T1(1:min);
            T_12 = T1(min+1:end);
            O = [O T_11];
            
            for g=1:size(T_11,1)
                
                for h=1:size(T1,1)
                    if T1(h) == T_11(g)
                        T1(h) = [];
                    end
                    
                end
                for i=1:size(T2,1)
                    if T2(h) == T_11(g)
                        T2(h) = [];
                    end
                    
                end
                
            end
            X = T1;
            T1 = T2;
            T2 = X;
            
        end
        
        
        
        
        
        % ...
        % ...
        % ...
        %%%%%%% End of cross-over operator %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        
        
        %%%%%%%%%%%%% Mutation Operator %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        r = rand();
        if r <= mutProb
            %off_indx = randi([1 popSize], 1, 1);
            offspring = O; %pop(off_indx, :); % replace this line of code so that the offspring
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
        
        %%%%%%%%%% End of mutation operator %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        
    end%End crossover
    
    
    
    % Now, it is time to replace the worst members of newPop with the elite 
    % members you stored in matrix elitePop (see Elite selection in the begining
    % of this iteration).
    % Your code goes here:
    % ...
    % ...
    % ...
    % ...
    %%%%%%% End of elite replacement %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    
    % Finally, the new population newPop should become the current population.
    % pop = newPop;    % Uncomment this line when you finished all previous
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

