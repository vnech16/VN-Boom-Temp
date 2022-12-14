%% Clean
clc;clear;close all
%% Import Data
ComRanking = readtable('CommerciallyViableAirports3PointScale07Dec22.xlsx');

fileName = 'AirportData.txt'; % filename with JSON structure
fid = fopen(fileName); % Opening the file
raw = fread(fid,inf); % Reading the contents
str = char(raw'); % Transformation
fclose(fid); % Closing the file
data = jsondecode(str); % Using the jsondecode function to parse JSON from string
RunwayData = struct2table(data);

RunwayData = renamevars(RunwayData,["iataCode"],["CODE"]);
ComRanking = renamevars(ComRanking,["DepAirportCode"],["CODE"]);

T = join(ComRanking,RunwayData,'Keys','CODE');
T=T(:,[1 2 3 12 16 17 22 23]);

% id = T.CommercialPotential == "Medium";
id = T.CommercialPotential == "Medium" | T.CommercialPotential == "High";
newTbl = T(id,:);

TenShortestRunways=sortrows(newTbl,"longestRunwayLength","ascend");
TenShortestRunways=TenShortestRunways(1:10,:)

TenHighestRunways=sortrows(newTbl,"elevation","descend");
TenHighestRunways=TenHighestRunways(1:10,:)

DesignCases=[TenShortestRunways;TenHighestRunways];

% ind1 = T(:,1) == 'Medium';

