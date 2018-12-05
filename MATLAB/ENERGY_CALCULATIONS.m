%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TEAM SANDL | ASHRAE ENGINEERING CHALLENGE
% ESTIMATED POWER DEMANDS
% ESTIMATED ENERGY CONSUMPTION | HEATING & COOLING
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% THIS SCRIPT WILL CALCULATE THE HEATING AND COOLING LOADS USING 
% AMBIENT TEMPERATURES NESSECARY TO MAINTAIN THE DEFINED COMFORTABLE_WARMTH

% DISPLAYS THE RELATED PLOTS FROM RUNNING SCRIPT HEATINGLOADS.m

%% CALCULATING SHELTER LOADS FROM AVERAGE AMBIENT TEMPERATURES
l = 1; k = 1;
while l <= size(SOLAR_HOURS, 1)
    k = 2;
    while k <= size(SOLAR_HOURS, 2)
        % TEMPERATURE INDEPENDENT HEATING LOADS
        Q_SOLAR = SHGC_WINDOW*cos((90-LATITUDE{l,2})*pi/180) ...
            *(EFFECTIVE_SOLAR_AREA); % HEAT GAIN FROM SOLAR ENERGY [kW]
        % AVERAGE HIGH TEMPERATURES
        LATENT_EVAPORIZATION_HIGH = (2454 - 2.2 * ...
            AMBIENT_TEMP_HIGH{l, k})/1000;  % h_fg OF WATER [kJ/kg]
        QH_LATENT = AIR_RHO*AIR_VOLUME_FLOW*LATENT_EVAPORIZATION_HIGH* ...
            COMFORTABLE_HUMIDITY;           % LATENT HEAT GAIN [kW]  
        QH_SENSIBLE = AIR_CP*AIR_RHO*AIR_VOLUME_FLOW*(COMFORTABLE_WARMTH ...
            - AMBIENT_TEMP_HIGH{l, k});     % SENSIBLE HEAT GAIN [kW]
        QH_INFILTRATION = (UVALUE_WINDOW * WINDOW_AREA + ...
            UVALUE_WALL * WALL_AREA)*(COMFORTABLE_WARMTH - ...
            AMBIENT_TEMP_HIGH{l, k})/1000;  % SUM OF WALL AND WINDOW GAINS [kW]
        QH_INPUT = QH_SENSIBLE + QH_LATENT + Q_OCCUPANTS + Q_SOLAR ...
            + QH_INFILTRATION;    % SUM OF HEATING INPUT [kW]
        % AVERAGE LOW TEMPERATURES
        LATENT_EVAPORIZATION_LOW = (2454 - 2.2 * ...
            AMBIENT_TEMP_LOW{l, k})/1000;   % h_fg OF WATER [kJ/kg]
        QL_LATENT = AIR_RHO*AIR_VOLUME_FLOW*LATENT_EVAPORIZATION_LOW* ...
            COMFORTABLE_HUMIDITY;           % LATENT HEAT GAIN [kW]  
        QL_SENSIBLE = AIR_CP*AIR_RHO*AIR_VOLUME_FLOW*(COMFORTABLE_WARMTH ...
            - AMBIENT_TEMP_LOW{l, k});     % SENSIBLE HEAT GAIN [kW]
        QL_INFILTRATION = (UVALUE_WINDOW * WINDOW_AREA + ...
            UVALUE_WALL * WALL_AREA)*(COMFORTABLE_WARMTH - ...
            AMBIENT_TEMP_LOW{l, k})/1000;  % SUM OF WALL AND WINDOW GAINS [kW]
        QL_INPUT = QL_SENSIBLE + QL_LATENT + Q_OCCUPANTS + Q_SOLAR ...
            + QL_INFILTRATION;
        % DEFINE SHELTER LOADS BY AVERAGE HIGH TEMPERATURES
        if QH_INPUT < 0          % Q_IN NEED FOR COOLING
            COOLING_LOADS_HIGH(l, k-1) = QH_INPUT/COP_HEATPUMP(2)*eomday(2018,k-1);
            HEATING_LOADS_HIGH(l, k-1) = 0;
        elseif QH_INPUT > 0      % Q_IN NEED FOR HEATING
            COOLING_LOADS_HIGH(l, k-1) = 0;
            HEATING_LOADS_HIGH(l, k-1) = QH_INPUT/COP_HEATPUMP(1)*eomday(2018,k-1); 
        else                    % NEITHER HEATING OR COOLING NEEDED
            COOLING_LOADS_HIGH(l, k-1) = 0;
            HEATING_LOADS_HIGH(l, k-1) = 0; 
        end
        % DEFINE SHELTER LOADS BY AVERAGE LOW TEMPERATURES
        if QL_INPUT < 0          % Q_IN NEED FOR COOLING []
            COOLING_LOADS_LOW(l, k-1) = QL_INPUT/COP_HEATPUMP(2)*eomday(2018,k-1);
            HEATING_LOADS_LOW(l, k-1) = 0;
        elseif QL_INPUT > 0      % Q_IN NEED FOR HEATING []
            COOLING_LOADS_LOW(l, k-1) = 0;
            HEATING_LOADS_LOW(l, k-1) = QL_INPUT/COP_HEATPUMP(1)*eomday(2018,k-1); 
        else                    % NEITHER HEATING OR COOLING NEEDED []
            COOLING_LOADS_LOW(l, k-1) = 0;
            HEATING_LOADS_LOW(l, k-1) = 0; 
        end
        k = k + 1;
    end
    l = l + 1;
end
% LABELLING TABLE VARIABLES APPROPRIATELY
COOLING_LOADS_HIGH = [cell2table(LATITUDE{:,1}), array2table(COOLING_LOADS_HIGH)];
COOLING_LOADS_HIGH.Properties.VariableNames = {'CITY', 'JANUARY', ...
    'FEBRUARY' ,'MARCH', 'APRIL', 'MAY', 'JUNE', 'JULY', 'AUGUST', ...
    'SEPTEMBER', 'OCTOBER', 'NOVEMBER', 'DECEMBER'};        % COLUMN LABELS
HEATING_LOADS_HIGH = [cell2table(LATITUDE{:,1}), array2table(HEATING_LOADS_HIGH)];
HEATING_LOADS_HIGH.Properties.VariableNames = {'CITY', 'JANUARY', ...
    'FEBRUARY' ,'MARCH', 'APRIL', 'MAY', 'JUNE', 'JULY', 'AUGUST', ...
    'SEPTEMBER', 'OCTOBER', 'NOVEMBER', 'DECEMBER'};        % COLUMN LABELS
COOLING_LOADS_LOW = [cell2table(LATITUDE{:,1}), array2table(COOLING_LOADS_LOW)];
COOLING_LOADS_LOW.Properties.VariableNames = {'CITY', 'JANUARY', ...
    'FEBRUARY' ,'MARCH', 'APRIL', 'MAY', 'JUNE', 'JULY', 'AUGUST', ...
    'SEPTEMBER', 'OCTOBER', 'NOVEMBER', 'DECEMBER'};        % COLUMN LABELS
HEATING_LOADS_LOW = [cell2table(LATITUDE{:,1}), array2table(HEATING_LOADS_LOW)];
HEATING_LOADS_LOW.Properties.VariableNames = {'CITY', 'JANUARY', ...
    'FEBRUARY' ,'MARCH', 'APRIL', 'MAY', 'JUNE', 'JULY', 'AUGUST', ...
    'SEPTEMBER', 'OCTOBER', 'NOVEMBER', 'DECEMBER'};        % COLUMN LABELS

%% DEFINING THE ENERGY REQUIREMENTS AND POWER GENERATION
i = 1; j = 1;
while i <= size(SOLAR_HOURS, 1)
    j = 2;
    while j <= size(SOLAR_HOURS, 2)
        if abs(COOLING_LOADS_HIGH{i,j}) > abs(COOLING_LOADS_LOW{i,j})
            COOLING_KWH = abs(COOLING_LOADS_HIGH{i,j});
        else
            COOLING_KWH = abs(COOLING_LOADS_LOW{i,j});
        end
        if abs(HEATING_LOADS_HIGH{i,j}) > abs(HEATING_LOADS_LOW{i,j})
            HEATING_KWH = HEATING_LOADS_HIGH{i,j};
        else
            HEATING_KWH = HEATING_LOADS_LOW{i,j};
        end
        ENERGY_LOAD(i, j-1) = (COOLING_KWH + HEATING_KWH + E_MISCELLANEOUS) ...
            /eomday(2018,j-1);    % DAILY KWH [KWH]
        STORAGE(i, j-1) = ENERGY_LOAD(i, j-1)*STORAGE_DAYS ...
            /(BATTERY_EF * CHARGE_DEPTH * OPPERATION_EF);  % [KWH]
        NUMBER_BATTERIES(i, j-1) = STORAGE(i, j-1)/(BATTERY_AMP * BATTERY_VOLTAGE/1000);   % [#]
        NUMBER_PANELS(i, j-1) = ENERGY_LOAD(i, j-1) / ...
            (SOLAR_HOURS{i, j}*PANEL_WATTS/1000);         % [#]
        SOLAR_GENERATION(i, j-1) = (PANEL_VOLTAGE * PANEL_CURRENT * ...
            SOLAR_HOURS{i,j}*eomday(2018,j-1))/1000 ...
            *sin((90-LATITUDE{i,2})*pi/180)*SOLAR_COLLECTION_EFF;            % SOLAR GENERATION BASED ON LATITUDE
        j = j + 1;
    end
    i = i + 1;
end

STORAGE = [cell2table(LATITUDE{:,1}), array2table(STORAGE)];
STORAGE.Properties.VariableNames = {'CITY', 'JANUARY', ...
    'FEBRUARY' ,'MARCH', 'APRIL', 'MAY', 'JUNE', 'JULY', 'AUGUST', ...
    'SEPTEMBER', 'OCTOBER', 'NOVEMBER', 'DECEMBER'};        % COLUMN LABELS
NUMBER_BATTERIES = [cell2table(LATITUDE{:,1}), array2table(NUMBER_BATTERIES)];
NUMBER_BATTERIES.Properties.VariableNames = {'CITY', 'JANUARY', ...
    'FEBRUARY' ,'MARCH', 'APRIL', 'MAY', 'JUNE', 'JULY', 'AUGUST', ...
    'SEPTEMBER', 'OCTOBER', 'NOVEMBER', 'DECEMBER'};        % COLUMN LABELS
NUMBER_PANELS = [cell2table(LATITUDE{:,1}), array2table(NUMBER_PANELS)];
NUMBER_PANELS.Properties.VariableNames = {'CITY', 'JANUARY', ...
    'FEBRUARY' ,'MARCH', 'APRIL', 'MAY', 'JUNE', 'JULY', 'AUGUST', ...
    'SEPTEMBER', 'OCTOBER', 'NOVEMBER', 'DECEMBER'};        % COLUMN LABELS

MAX_STORAGE = max(max(STORAGE{:,2:13}));
MAX_PANELS = max(max(ENERGY_LOAD))/(min(min(SOLAR_HOURS{:,2:13})) ...
    *PANEL_WATTS/1000*0.9);
MAX_BATTERIES = max(max(NUMBER_BATTERIES{:,2:13}));
BATTERY_SERIES = SYSTEM_VOLTAGE/BATTERY_VOLTAGE;
PANEL_SERIES = SYSTEM_VOLTAGE/PANEL_VOLTAGE;

SOLAR_GENERATION = SOLAR_GENERATION*round(MAX_PANELS);
SOLAR_GENERATION = [cell2table(LATITUDE{:,1}), array2table(SOLAR_GENERATION)];
SOLAR_GENERATION.Properties.VariableNames = {'CITY', 'JANUARY', ...
    'FEBRUARY' ,'MARCH', 'APRIL', 'MAY', 'JUNE', 'JULY', 'AUGUST', ...
    'SEPTEMBER', 'OCTOBER', 'NOVEMBER', 'DECEMBER'};        % COLUMN LABELS
% % SUMMARIZING EQUIPMENT CALCULATIONS
EQUIPMENT_SUMMARY = table(round(MAX_STORAGE, 2), ceil(MAX_BATTERIES), ...
    ceil(MAX_PANELS), ceil(BATTERY_SERIES), ceil(PANEL_SERIES), ...
    max(max(SOLAR_GENERATION{:,2:13})), min(min(SOLAR_GENERATION{:,2:13})));
EQUIPMENT_SUMMARY.Properties.VariableNames = {'DESIRED_STORAGE_KWH', ...
    'TOTAL_BATTERIES', 'TOTAL_PANELS' ,'BATTERIES_IN_SERIES', ...
    'PANELS_IN_SERIES', 'MAX_MONTH_SOLAR', 'MIN_MONTH_SOLAR'};  
EQUIPMENT_SUMMARY
