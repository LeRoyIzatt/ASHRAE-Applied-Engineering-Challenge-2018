%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TEAM SANDL | ASHRAE ENGINEERING CHALLENGE
% ESTIMATED POWER DEMANDS
% ESTIMATED ENERGY CONSUMPTION | HEATING & COOLING
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% {SHORT NOTES ON WHAT THIS SRIPT PREFORMS ... }

%% INITIAL SCRIPTING PARAMETER CONDITIONS
% % LIST OF REFERENCE PROPERTIES AND CHARATERISTICS
AIR_CP = 1.006;                     % SPECIFIC HEAT OF AIR [kJ/kg-C]
AIR_RHO = 1.202;                    % DENSITY OF AIR [kg/m^3]
AIR_VOLUME_FLOW = 1;                % AIR VOLUME FLOW [m^3/s]
COMFORTABLE_WARMTH = 21.1;          % THE WORLD HEALTH ORGANISATION STANDARD [C]
COMFORTABLE_HUMIDITY = 0.4;         % RELATIVE HUMITIY FOR HEALTH AND COMFORT
OCCUPANTS = 6;                      % NUMBER OF OCCUPANTS PER SHELTER
RVALUE_WALL = 10;                   % EFFECTIVE R-VALUE OF SHELTER [m^2K/W]
UVALUE_WINDOW = 0.300;              % WINDOW U-VALUES [W/m^2-K]
SHGC_WINDOW = 0.300;                % SOLAR HEAT GAIN COEFFICIENT OF WINDOWS
WALL_AREA = 67.68;                  % EFFECTIVE SURFACE AREA [m^2] 74
WINDOW_AREA = 6.32;                 % EFFECTIVE WINDOW AREA [m^2]
COP_HEATPUMP = [3.46 4.68];         % COEFFICIENT OF PERFORMANCE [HEATING COOLING]
E_MISCELLANEOUS = 3.0;              % ENERGY LOADS NOT RELATED TO HVAC (LIGHTS, COOKING, ETC) [KWH] 
SOLAR_COLLECTION_EFF = 0.80;        % RELATIVE SOLAR COLECTION [%]
% % PRELIMINARY UNIT CONVERSION CALCULATIONS
Q_OCCUPANTS = OCCUPANTS*175/1000;   % HEAT LOAD DUE TO OCCUPANTS [kW]
UVALUE_WALL = 1/RVALUE_WALL;        % HEAT TRANSFER COEFFICIENT [W/m^2-K]
WALL_RATIO = WINDOW_AREA/WALL_AREA; % WINDOW AREA TO SURFACE AREA 
EFFECTIVE_SOLAR_AREA = 3.56;        % EFFECTIVE SOLAR AREA [m^2] - WINDOW AREA FACING SUN
OCCUPANCY_HOURS = 14;               % ESTIMATED HOURS OF OCCUPANCY
% % SOLAR EQUIPMENT PARAMETERS
PRESCRIBED_PANELS = 9;              % NUMBER OF PANELS FOR COMPARISON ANALYSIS
PANEL_WATTS = 325;                  % WATTS PER INSTALLED PANEL [W]
PANEL_VOLTAGE = 37.0;               % OPERATING VOLTAGE [V]
PANEL_CURRENT = 8.78;               % OPERATING AMPS [A]
BATTERY_VOLTAGE = 12.8;             % BATTERY VOLATAGE [V]
BATTERY_AMP = 105;                  % BATTERY AMP HOURS [Ah]
BATTERY_EF = 0.80;                  % BATTERY DISCHARGE EFFICIENCY AT FREEZIING
CHARGE_DEPTH = 0.93;                % BATTERY CHARGE DEPTH DISCHARGE
STORAGE_DAYS = 5;                   % WANTING TO STORE ENERGY FOR 5 DAYS
% % % STORAGE_DAYS = 2;                   % WANTING TO STORE ENERGY FOR 5 DAYS
SYSTEM_VOLTAGE = 24;                % SYSTEM OPERATION VOLTAGE [V]
OPPERATION_EF = 0.97;               % TOTAL OPPERATION EFFICIENCY 
% % COUNTRY NUMBER ALLOCATION
ESTONIA = 1; GERMANY = 2; GREECE = 3; POLAND = 4; SWEDEN = 5;
SWITZERLAND = 6; UKRAINE = 7; UNITED_KINGDOM = 8; UNITED_STATES = 9; UTAH =10;
% % INTERATION COUNTERS
i = 1; j = 1; k = 1; l = 1;
% % REFERENCE FILE NAMES & LOCATION DEFINITIONS
FILE_NAMES = ["ESTONIA.xlsx"; "GERMANY.xlsx"; "GREECE.xlsx"; ...
    "POLAND.xlsx"; "SWEDEN.xlsx"; "SWITZERLAND.xlsx"; "UKRAINE.xlsx"; ...
    "UNITED KINGDOM.xlsx"; "UNITED STATES.xlsx"; "UTAH.xlsx"];
LOCATION = categorical({'ESTONIA', 'GERMANY', 'GREECE', 'POLAND', ...
    'SWEDEN', 'SWITZERLAND', 'UKRAINE', 'UNITED KINGDOM', ...
    'UNITED STATES', 'UTAH'});

%% WHERE THE REAL MAGIC HAPPENS
% % RUNS SCRIPT TO GRAB EXCEL DATA
GRAB_DATA;                 
% % RUN SCRIPT WITH ENERGY CALCULATIONS HEATING AND COOLING LOADS
ENERGY_CALCULATIONS;     
% RUN SCRIPT TO DISPLAY APPROPRIATE PLOTS
DISPLAY_PLOTS;      
