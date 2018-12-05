%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TEAM SANDL | ASHRAE ENGINEERING CHALLENGE
% ESTIMATED POWER DEMANDS
% ESTIMATED ENERGY CONSUMPTION | HEATING & COOLING
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% THIS SCRIPT WILL DISPLAY THE DATA CALCULATED FROM THE 
% ENERGY_CALCUALTIONS.m SCRIPT

% DISPLAYS THE RELATED PLOTS FROM RUNNING SCRIPT HEATINGLOADS.m

%% INITIAL SCRIPTING PARAMETER CONDITIONS
FONT_SIZE_AXIS = 14; FONT_SIZE_TITLE = 20;      % DEFINE LABEL FONT SIZE
ERROR_BAR_SIZE = 1;                             % DEFINE WIDTH OF ERROR BARS
% % CITIES TO PLOT [TALLINN, ATHENS, MALMO, ZURICH, MINNEAPOLIS, SALT LAKE CITY]
CITIES = [1, 11, 19, 21, 34, 37];
CITY_NAMES = {'TALLINN | ESTONIA', 'ATHENS | GREECE', 'MALMO | SWEDEN', ...
    'ZURICH | SWITZERLAND', 'MINNEAPOLIS | MINNESOTA', 'SALT LAKE CITY | UTAH'};

%% PLOTS FROM ANALYSIS
% % SUBPLOTS SHOW ENERGY LOADS SPLIT INTO HEATING COOLING HIGH & LOW
% % SUBPLOT PLOTING HEATING LOADS USING AVERAGE LOW TEMPERATURES
figure;         % START NEW FIGURE
subplot(2,2,1), plot([1:12],abs(HEATING_LOADS_LOW{CITIES,2:13}), ...
    'LineWidth', 4, 'LineStyle', '-.');
legend(CITY_NAMES, 'AutoUpdate', 'off');
hold on;
plot([1:12],abs(HEATING_LOADS_LOW{:,2:13}));
hold off;
set(gca,'XTickLabelRotation',45 ,'FontSize', FONT_SIZE_AXIS);
xticks([1:12]); xlim([1,12]);
xticklabels(HEATING_LOADS_LOW.Properties.VariableNames(2:13));
ylim([0, 450]);
ylabel('Power Requirement [kWh]');
title('HEATING LOADS [TEMPERATURE LOWS]', 'fontsize', FONT_SIZE_TITLE);
% % SUBPLOT PLOTING HEATING LOADS USING AVERAGE HIGH TEMPERATURES
subplot(2,2,2), plot([1:12],abs(HEATING_LOADS_HIGH{CITIES,2:13}), ...
    'LineWidth', 4, 'LineStyle', '-.');
legend(CITY_NAMES, 'AutoUpdate', 'off');
hold on;
plot([1:12],abs(HEATING_LOADS_HIGH{:,2:13}));
hold off;
set(gca,'XTickLabelRotation',45,'FontSize', FONT_SIZE_AXIS);
xticks([1:12]); xlim([1,12]);
xticklabels(HEATING_LOADS_HIGH.Properties.VariableNames(2:13));
ylim([0, 450]);
ylabel('Power Requirement [kWh]');
title('HEATING LOADS [TEMPERATURE HIGHS]', 'fontsize', FONT_SIZE_TITLE);
% % SUBPLOT PLOTING COOLING LOADS USING AVERAGE LOW TEMPERATURES
subplot(2,2,3), plot([1:12],abs(COOLING_LOADS_LOW{CITIES,2:13}), ...
    'LineWidth', 4, 'LineStyle', '-.');
legend(CITY_NAMES, 'AutoUpdate', 'off');
hold on;
plot([1:12],abs(COOLING_LOADS_LOW{:,2:13}));
hold off;
set(gca,'XTickLabelRotation',45,'FontSize', FONT_SIZE_AXIS);
xticks([1:12]); xlim([1,12]);
xticklabels(COOLING_LOADS_LOW.Properties.VariableNames(2:13));
ylim([0, 450]);
ylabel('Power Requirement [kWh]');
title('COOLING LOADS [TEMPERATURE LOWS]', 'fontsize', FONT_SIZE_TITLE);
% % SUBPLOT PLOTING COOLING LOADS USING AVERAGE HIGH TEMPERATURES
subplot(2,2,4), plot([1:12],abs(COOLING_LOADS_HIGH{CITIES,2:13}), ...
    'LineWidth', 4, 'LineStyle', '-.');
legend(CITY_NAMES, 'AutoUpdate', 'off');
hold on;
plot([1:12],abs(COOLING_LOADS_HIGH{:,2:13}));
hold off;
set(gca,'XTickLabelRotation',45,'FontSize', FONT_SIZE_AXIS);
xticks([1:12]); xlim([1,12]);
xticklabels(COOLING_LOADS_HIGH.Properties.VariableNames(2:13));
ylim([0, 450]);
ylabel('Power Requirement [kWh]');
title('COOLING LOADS [TEMPERATURE HIGHS]', 'fontsize', FONT_SIZE_TITLE);

% % PLOT OF SOLAR GENERATION BY MONTH ON AVERAGE
figure; hold on;
plot([1:12], SOLAR_GENERATION{CITIES, 2:13}, ...
    'LineWidth', 4, 'LineStyle', '-.');
legend(CITY_NAMES, 'AutoUpdate', 'off');
plot([1:12], SOLAR_GENERATION{:,2:13});
set(gca,'XTickLabelRotation',45,'FontSize', FONT_SIZE_AXIS);
xticks([1:12]); xlim([1,12]);
xticklabels(SOLAR_GENERATION.Properties.VariableNames(2:13));
ylabel('Power Generation [kWh]');
title('SOLAR POWER GENERATION', 'fontsize', FONT_SIZE_TITLE);
hold off;

% % COMBINEDS HEATING AND COOLING LOADS FOR HIGH AVERAGE TEMPERATURES
figure; hold on;
plot([1:12],HEATING_LOADS_HIGH{CITIES,2:13}+abs(COOLING_LOADS_HIGH{CITIES,2:13}), ...
    'LineWidth', 4, 'LineStyle', '-.');
legend(CITY_NAMES, 'AutoUpdate', 'off');
plot([1:12],HEATING_LOADS_HIGH{:,2:13}+abs(COOLING_LOADS_HIGH{:,2:13}));
set(gca,'XTickLabelRotation',45,'FontSize', FONT_SIZE_AXIS);
xticks([1:12]); xlim([1,12]);
xticklabels(SOLAR_GENERATION.Properties.VariableNames(2:13));
ylim([0, 450]);
ylabel('Power Consumption [kWh]');
title('POWER CONSUMPTION BY AVERAGED HIGH TEMPERATURES',  ...
    'fontsize', FONT_SIZE_TITLE);
hold off;

% % COMBINEDS HEATING AND COOLING LOADS FOR LOW AVERAGE TEMPERATURES
figure; hold on;
plot([1:12],HEATING_LOADS_LOW{CITIES,2:13}+abs(COOLING_LOADS_LOW{CITIES,2:13}), ...
    'LineWidth', 4, 'LineStyle', '-.')
legend(CITY_NAMES, 'AutoUpdate', 'off');
plot([1:12],HEATING_LOADS_LOW{:,2:13}+abs(COOLING_LOADS_LOW{:,2:13}))
set(gca,'XTickLabelRotation',45, 'FontSize', FONT_SIZE_AXIS);
xticks([1:12]); xlim([1,12]);
xticklabels(SOLAR_GENERATION.Properties.VariableNames(2:13));
ylim([0, 450]);
ylabel('Power Consumption [kWh]');
title('POWER CONSUMPTION BY AVERAGED LOW TEMPERATURES', ...
    'fontsize', FONT_SIZE_TITLE);
hold off;

% PLOT THE POWER CONSUMPTION BY SOURCE AND ERROR IN CALCUALTION
MONTH_CATEGORY = reordercats(categorical({'JANUARY', ...
    'FEBRUARY' ,'MARCH', 'APRIL', 'MAY', 'JUNE', 'JULY', 'AUGUST', ...
    'SEPTEMBER', 'OCTOBER', 'NOVEMBER', 'DECEMBER'}),{'JANUARY', ...
    'FEBRUARY' ,'MARCH', 'APRIL', 'MAY', 'JUNE', 'JULY', 'AUGUST', ...
    'SEPTEMBER', 'OCTOBER', 'NOVEMBER', 'DECEMBER'});   % BAR CATEGORY
figure; 

COMPAIR_PANELS = PRESCRIBED_PANELS/round(MAX_PANELS); % COMPAIRING PRESCRIBED NUMBER OF PANELS
for i = 1:10;
    subplot(2,5,i); hold on; colormap summer;
    set(gca,'XTickLabelRotation',45, 'FontSize', FONT_SIZE_AXIS);
    GENERATION_STD = mean(SOLAR_GENERATION{4*i-3:4*i,2:13}).*1/sqrt(2*pi) ...
        .*exp(-0.5*(std(SOLAR_GENERATION{4*i-3:4*i,2:13}) ...
        ./mean(SOLAR_GENERATION{4*i-3:4*i,2:13})).^2);
    GENERATION_STD_COMP = mean(SOLAR_GENERATION{4*i-3:4*i,2:13}*COMPAIR_PANELS).*1/sqrt(2*pi) ...
        .*exp(-0.5*(std(SOLAR_GENERATION{4*i-3:4*i,2:13}) ...
        ./mean(SOLAR_GENERATION{4*i-3:4*i,2:13})).^2);
    GENERATION_COMP = bar(MONTH_CATEGORY, mean(SOLAR_GENERATION{4*i-3:4*i,2:13}) ...
        *COMPAIR_PANELS, 0.9, 'grouped', 'y');
    GENERATION_ERROR_COMP = errorbar(mean(SOLAR_GENERATION{4*i-3:4*i,2:13}) ...
        *COMPAIR_PANELS, GENERATION_STD_COMP, 'xm', 'LineWidth', ERROR_BAR_SIZE);
    GENERATION_G = bar(MONTH_CATEGORY, mean(SOLAR_GENERATION{4*i-3:4*i,2:13}), ...
        0.9, 'grouped');
    GENERATION_ERROR_G = errorbar(mean(SOLAR_GENERATION{4*i-3:4*i,2:13}) ...
        , GENERATION_STD, 'xk', 'LineWidth', ERROR_BAR_SIZE);
    DC(1:12) = mean([mean(HEATING_LOADS_HIGH{4*i-3:4*i,2:13} ...
        + abs(COOLING_LOADS_HIGH{4*i-3:4*i,2:13}));  ...
        mean(HEATING_LOADS_LOW{4*i-3:4*i,2:13} + ...
        abs(COOLING_LOADS_LOW{4*i-3:4*i,2:13}))]);      % ARRAY OF AVERAGE LOADING 
    CONSUMPTION_STD = std([mean(HEATING_LOADS_HIGH{4*i-3:4*i,2:13} ...
        + abs(COOLING_LOADS_HIGH{4*i-3:4*i,2:13}));  ...
        mean(HEATING_LOADS_LOW{4*i-3:4*i,2:13} + ...
        abs(COOLING_LOADS_LOW{4*i-3:4*i,2:13}))]);      % ARRAY OF LOADING STD 
    CONSUMPTION_G = bar(MONTH_CATEGORY, DC, 0.8, 'grouped');       % BAR GRAPH OF CONSUMPTION LIMIT
    CONSUMPTION_G.EdgeColor = [1 0.6471 0]; CONSUMPTION_G.FaceColor = [1 0.6471 0];
    CONSUMPTION_ERROR_G = errorbar(DC, CONSUMPTION_STD, 'xc', ...
        'LineWidth', ERROR_BAR_SIZE);
    ylim([0 1000]);
    title(char(strrep(strrep(FILE_NAMES(i), ".xlsx", ""),"_"," ")), 'fontsize', 18);
    ylabel('Power [kWh]', 'fontsize', FONT_SIZE_TITLE);
    hold off;
end
 legend({'Prescribed Panel Energy Generation', 'Prescribed Method Error', ...
     'Estimated Panel Energy', 'Estimated Method Error', ...
     'Estimated Energy Consumption', 'Estimated Energy Consumption Error'});