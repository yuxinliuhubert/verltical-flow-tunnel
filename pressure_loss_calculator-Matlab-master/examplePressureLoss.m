%% Example_PressureLossCalculator (SI Units)
%   This script shows how to use the Matlab tool "Pressure loss calculator"
%  by Tol,Hakan Ibrahim from the PhD study at Technical University of Denmark 
%   PhD Topic: District Heating in Areas with Low-Energy Houses

%% Given Data
L=4            % The length of the pipe segment                     [m]
v=4;            % Flow speed                                        [m/s]
d=1000;         % density of fluid                                  [m/s]
Din=400;       % Pipe inner diameter                               [mm]
aRou=0.01;       % Absolute roughness                                [mm]
T_DW=20;        % Water temperature for Darch-Weisbach equation     [°C] 
T_HW=10;        % Water temperature for Hazen-Williams equation     [°C]


%% Fasten your seat belts, the code is running!

Rin_meter = (Din*1e-3)/2
area = pi*(Rin_meter^2)
mFlow = area*v*d % Mass flow of water                                [kg/s]


%% Darcy-Weisbach
% Pressure loss by use of Darcy-Weisbach via solving implicit Colebrook-White algorithm
plDW_ColebrookWhite=PressureLossCalculator(L,Din,mFlow,T_DW,aRou,'Solver','Darcy-Weisbach','fAlgorithm','Colebrook-White','fTol',0.001,'MaxIterations',2000)

% Pressure loss by use of Darcy-Weisbach via Clamond algorithm
plDW_Clamond=PressureLossCalculator(L,Din,mFlow,T_DW,aRou,'Solver','Darcy-Weisbach','fAlgorithm','Clamond')

% Pressure loss by use of Darcy-Weisbach via Zigrang-Sylvester algorithm
% plDW_ZigrangSylvester=PressureLossCalculator(L,Din,mFlow,T_DW,aRou,'Solver','Darcy-Weisbach','fAlgorithm','Zigrang-Sylvester')

plDW_PSI_ColeBrook = plDW_ColebrookWhite*14.5

%% Hazen-Williams
% Pressure loss by use of Hazen-Williams
% plHazenWilliams=PressureLossCalculator(L,Din,mFlow,T_HW,aRou,'Solver','Hazen-Williams')
% 