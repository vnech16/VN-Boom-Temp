%Make sure the airport data file is located in a directory MatLab can open
clc
clear
close all

fileName = 'AirportData.txt'; % filename with JSON structure
fid = fopen(fileName); % Opening the file
raw = fread(fid,inf); % Reading the contents
str = char(raw'); % Transformation
fclose(fid); % Closing the file
data = jsondecode(str); % Using the jsondecode function to parse JSON from string

RunwayName={data.name}; %Pulling out specific parametor
% RunwayName=cell2mat(RunwayName); %Convert to single matrix

%% Runway Length
RunwayLengths={data.longestRunwayLength}; %Pulling out specific parametor
RunwayLengths=cell2mat(RunwayLengths); %Convert to single matrix

%Initiate some variables for iteration
results=0; 
r=0;

for OveFieldLength=0:1000:16000       %Making the bins
    disp(OveFieldLength)
    r=r+1;                          %Iteration variable
    results(r,1)=(OveFieldLength);    %#ok<SAGROW> %First column for indepandant variable, sample length
    
    c=find(OveFieldLength<=RunwayLengths);         
    results(r,2)=length(c);         %#ok<SAGROW> %Second column for dependant variable
end

bar(results(:,1),results(:,2))
xlabel('Ove Field Length [ft]')
ylabel('Available Runways')
hold on 
xline(11000)

%% Runway Lengths Top10
RunwayLengths={data.longestRunwayLength}; %Pulling out specific parametor
RunwayLengths=cell2mat(RunwayLengths); %Convert to single matrix
[ValRL,indexRL]=mink(RunwayLengths,200);
Bottom200lengths=[RunwayName(indexRL)',num2cell(ValRL)']

%% Runway Altitudes Top10
RunwayElevations={data.elevation}; %Pulling out specific parametor
RunwayElevations=cell2mat(RunwayElevations); %Convert to single matrix
[ValRE,indexRE]=maxk(RunwayElevations,10);
Top10altitudes=[RunwayName(indexRE)',num2cell(ValRE)']









