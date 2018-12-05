%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TEAM SANDL | ASHRAE ENGINEERING CHALLENGE
% ESTIMATED POWER DEMANDS
% ESTIMATED ENERGY CONSUMPTION | HEATING & COOLING
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% THIS SCRIPT WILL GRAB DATA FROM THE EXCEL FILES DEFINED IN THE
% HEATINGLOADS.m NECESSARY FOR THE SCRIPT ENERGY_CALCULATIONS.m

% FILE_NAMES = ["ESTONIA.xlsx"; "GERMANY.xlsx"; "GREECE.xlsx"; ...
%     "POLAND.xlsx"; "SWEDEN.xlsx"; "SWITZERLAND.xlsx"; "UKRAINE.xlsx"; ...
%     "UNITED KINGDOM.xlsx"; "UNITED STATES.xlsx"; "UTAH.xlsx"];

% DISPLAYS THE RELATED PLOTS FROM RUNNING SCRIPT HEATINGLOADS.m

%% OBTAINING DATA FROM EXCEL FILES
warning off;        % GRABBING SOME DATA GIVES ASSIGNMENT WARNING FOR TABLE
% % GRABBING SOLAR DATA FROM FILE NAMES
while i <= length(FILE_NAMES);
    SOLAR_HOURS(4*(i-1)+1:i*4,:) = readtable( FILE_NAMES(i), 'Sheet', 'WEATHER', ...
    'Range', 'A2:M5', 'ReadVariableNames', false);        % NOMINAL TEMPERATURE [F]
    i = i + 1;                                              % COUNTING INTERATIONS
end
SOLAR_HOURS.Properties.VariableNames = {'CITY', 'JANUARY', ...
    'FEBRUARY' ,'MARCH', 'APRIL', 'MAY', 'JUNE', 'JULY', 'AUGUST', ...
    'SEPTEMBER', 'OCTOBER', 'NOVEMBER', 'DECEMBER'};        % COLUMN LABELS
i = 1; j = 1; 
% % GRABBING LATITUDE DATA FROM FILE NAMES
while i <= length(FILE_NAMES);
    LATITUDE(4*(i-1)+1:i*4,1) = readtable( FILE_NAMES(i), 'Sheet', 'WEATHER', ...
    'Range', 'A2:A5', 'ReadVariableNames', false);          % CITY
    LATITUDE(4*(i-1)+1:i*4,2) = readtable( FILE_NAMES(i), 'Sheet', 'WEATHER', ...
    'Range', 'N2:N5', 'ReadVariableNames', false);          % LATITUDE POSITION OF CITY
    i = i + 1;                                              % COUNTING INTERATIONS
end
LATITUDE.Properties.VariableNames = {'CITY', 'LATITUDE'};   % COLUMN LABELS
i = 1; j = 1; 
% % GRABBING TEMPERATURE HIGH DATA FROM FILE NAMES
while i <= length(FILE_NAMES);
    AMBIENT_TEMP_HIGH(8*(i-1)+1:i*8,:) = readtable( FILE_NAMES(i), 'Sheet', 'WEATHER', ...
    'Range', 'A10:M17', 'ReadVariableNames', false);        % NOMINAL TEMPERATURE [F]
    i = i + 1;                                              % COUNTING INTERATIONS
end
AMBIENT_TEMP_HIGH(2:2:size(AMBIENT_TEMP_HIGH, 1), :) = [];  % DELETE TEMPERATURE LOWS
AMBIENT_TEMP_HIGH.Properties.VariableNames = {'CITY', 'JANUARY', ...
    'FEBRUARY' ,'MARCH', 'APRIL', 'MAY', 'JUNE', 'JULY', 'AUGUST', ...
    'SEPTEMBER', 'OCTOBER', 'NOVEMBER', 'DECEMBER'};        % COLUMN LABELS
i = 1; j = 1;
while i <= size(AMBIENT_TEMP_HIGH, 1);
    j = 2;
    while j <= size(AMBIENT_TEMP_HIGH, 2)
        AMBIENT_TEMP_HIGH{i,j} = (AMBIENT_TEMP_HIGH{i,j} - 32)*5/9; % F to C
        j = j + 1;
    end
    i = i + 1;
end
i = 1; j = 1;
% % GRABBING TEMPERATURE LOW DATA FROM FILE NAMES
while i <= length(FILE_NAMES);
    AMBIENT_TEMP_LOW(8*(i-1)+1:i*8,:) = readtable( FILE_NAMES(i), 'Sheet', 'WEATHER', ...
    'Range', 'A10:M17', 'ReadVariableNames', false);        % NOMINAL TEMPERATURE [F]
    i = i + 1;                                              % COUNTING INTERATIONS
end
AMBIENT_TEMP_LOW(1:2:size(AMBIENT_TEMP_LOW, 1), :) = [];  % DELETE TEMPERATURE LOWS
AMBIENT_TEMP_LOW.Properties.VariableNames = {'CITY', 'JANUARY', ...
    'FEBRUARY' ,'MARCH', 'APRIL', 'MAY', 'JUNE', 'JULY', 'AUGUST', ...
    'SEPTEMBER', 'OCTOBER', 'NOVEMBER', 'DECEMBER'};        % COLUMN LABELS
i = 1; j = 1;
while i <= size(AMBIENT_TEMP_LOW, 1);
    j = 2;
    while j <= size(AMBIENT_TEMP_LOW, 2)
        AMBIENT_TEMP_LOW{i,j} = (AMBIENT_TEMP_LOW{i,j} - 32)*5/9; % F to C
        j = j + 1;
    end
    i = i + 1;
end
i = 1; j = 1;
warning on;             % TURN WARNINGS BACK ON
