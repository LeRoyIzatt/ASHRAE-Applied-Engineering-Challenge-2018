%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% TEAM SANDL | ASHRAE ENGINEERING CHALLENGE
% ESTIMATED POWER DEMANDS
% ESTIMATED ENERGY CONSUMPTION | HEATING & COOLING
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% SCRIPT WILL DISPLAY THE ENERGY GENERATION AND ENERGY CONSUMPTION FOR
% THE SPECIFIED COUNTRY NUMBER AS i
% COUNTRY NUMBERS ARE DEFINED IN HEATINGLOADS.m

% COUNTRY NUMBER ALLOCATION
% ESTONIA = 1; GERMANY = 2; GREECE = 3; POLAND = 4; SWEDEN = 5;
% SWITZERLAND = 6; UKRAINE = 7; UNITED_KINGDOM = 8; UNITED_STATES = 9; UTAH =10;

% DISPLAYS THE RELATED PLOTS FROM RUNNING SCRIPT HEATINGLOADS.m

%% START A NEW FIGURE
figure; 
i = GREECE;     % NAME OF THE COUNTRY TO DISPLAY PLOTS FOR
COMPAIR_PANELS = PRESCRIBED_PANELS/round(MAX_PANELS); % COMPAIRING PRESCRIBED NUMBER OF PANELS
% DEFINE COLORS
GENERATION_COLOR = [1 0.80 0];              % GOLD
CONSUMPTION_COLOR = [0.04 0.52 0.33];       % GREEN
                          
for j = 1;
    hold on; colormap summer;
    set(gca,'XTickLabelRotation',45, 'FontSize', FONT_SIZE_AXIS);
    GENERATION_STD = mean(SOLAR_GENERATION{4*i-3:4*i,2:13}).*1/sqrt(2*pi) ...
        .*exp(-0.5*(std(SOLAR_GENERATION{4*i-3:4*i,2:13}) ...
        ./mean(SOLAR_GENERATION{4*i-3:4*i,2:13})).^2);
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
    CONSUMPTION_G.FaceColor = CONSUMPTION_COLOR;
    GENERATION_G.FaceColor = GENERATION_COLOR;
    CONSUMPTION_ERROR_G = errorbar(DC, CONSUMPTION_STD, 'xc', ...
        'LineWidth', ERROR_BAR_SIZE);
    ylim([0 1000]);
    title(char(strrep(strrep(FILE_NAMES(i), ".xlsx", ""),"_"," ")), 'fontsize', 18);
    ylabel('Power [kWh]', 'fontsize', FONT_SIZE_TITLE);
    hold off;
end
 legend({'Prescribed Panel Energy Generation', 'Prescribed Method Error', ...
     'Estimated Panel Energy Consumption', 'Estimated Method Error', ...
     'Estimated Energy Consumption', 'Estimated Energy Consumption Error'});

% % COMBINEDS HEATING AND COOLING LOADS FOR AVERAGE TEMPERATURES
figure; hold on;
plot([1:12],HEATING_LOADS_HIGH{:,2:13}+abs(COOLING_LOADS_HIGH{:,2:13}));
plot([1:12],HEATING_LOADS_LOW{:,2:13}+abs(COOLING_LOADS_LOW{:,2:13}));
HT_LOADS = plot([1:12],mean(HEATING_LOADS_LOW{:,2:13}+abs(COOLING_LOADS_LOW{:,2:13})), 'b', ...
    'LineWidth', 4, 'LineStyle', '-.');
LT_LOADS = plot([1:12],mean(HEATING_LOADS_HIGH{:,2:13}+abs(COOLING_LOADS_HIGH{:,2:13})), 'r', ...
    'LineWidth', 4, 'LineStyle', '-.');
legend([HT_LOADS, LT_LOADS],'HIGH TEMPERATURES','LOW TEMPERATURES');
set(gca,'XTickLabelRotation',45, 'FontSize', FONT_SIZE_AXIS);
set(gca,'FontSize', FONT_SIZE_AXIS);
xticks([1:12]); xlim([1,12]);
xticklabels(SOLAR_GENERATION.Properties.VariableNames(2:13));
ylim([0, 450]);
ylabel('Power Consumption [kWh]');
title('POWER CONSUMPTION BY AVERAGED TEMPERATURES', ...
    'fontsize', FONT_SIZE_TITLE);
hold off;

% % AVERAGE POWER GENERATION PLOTS
figure; hold on;
plot([1:12], SOLAR_GENERATION{:,2:13});
SOLAR_MIN = plot([1:12], mean(SOLAR_GENERATION{:,2:13}), 'k', ...
    'LineWidth', 4, 'LineStyle', '-.');
set(gca,'XTickLabelRotation',45,'FontSize', FONT_SIZE_AXIS);

legend([SOLAR_MIN],'AVERAGE GENERATION');
set(gca,'XTickLabelRotation',45, 'FontSize', FONT_SIZE_AXIS);
set(gca,'FontSize', FONT_SIZE_AXIS);
xticks([1:12]); xlim([1,12]);
xticklabels(SOLAR_GENERATION.Properties.VariableNames(2:13));
ylabel('Power Generation [kWh]');
title('SOLAR POWER GENERATION', 'fontsize', FONT_SIZE_TITLE);
hold off;
