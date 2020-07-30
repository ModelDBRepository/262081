clear all;clc;close all;


%% experimental data
expTime = 0:0.05:199.95;
figure
%  data=xlsread('AP-Zaman.xlsx');
%  figure('Name','AP','NumberTitle','off')
%  plot(expTime, data(:,2));
% hold on

%% Variables Declaration

 z0=[-72, 0.0041, 0.67, 0.67, 0.0000021, 0.99, 0.99, 0.99...
    0.0021, 0.98, 0.64, 0.0029, 0.314, 0.0035, 0.634, 0.0004327...
    0.000000000606, 0.634, 0.139, 0.00516, 10.73519, 139.275, 0.000079...
    0.00008737212, 0.06607948, 0.06600742, 0.3657,0.089,0.081,30.03,0.1776,0.1]; 


c0=[0.12,    45,       -6.5,    76,            6,        1.36,     0.32,             47.13,   -0.1,    47.13, ...
    0.08,    11,       0.4537,  10.66,         -11.1,    3.49,     0.135,            80,      -6.8,    3.56,  ...
    0.079,   3.1*10^5, 0.35,    11.63,         -0.1,     32,      -2.535*(10^(-7)),  3.49,    37.78,   0.311, ...
    79.23,   -127140,  0.2444,  3.474*10^(-5), -0.04391, 0.1212,  -0.01052,         -0.1378,  40.14,   0.011  ...
    15,      -4,       26,      5,             3.05,     -0.0045,  7.02,             1.05,    -0.002,  18     ...
    0.25,    105,      45,      12,            40,       25,       25,               15,      75,      25     ...
    17,      41,       47,      12,            80,       55,       -5,               15,      75,      25     ...
    17,      9,        0.025    0.5            10.6      -11.42    45.3              6.8841   4000     45.16  ...
    0.03577  50,       98.9     -0.1           38        350       70                15       35       3700   ...
    70,      30,       35,      0.02           11.5      -11.82    87.5              10.3     50000    5100];
                 
  
         
     
                              %dinf              %f11inf                %f12inf                  %Cainactinf             %taud              %tauf11                %tauf12                   %tauf11>-24              %tauf12>-24            %tauCainact               %rinf                    %sinf                %sslowinf              %taur                        %taus                %taus>-40               %tausslow                 %y1inf_r                %tauy1_r               %y2inf_r                  %tauy2_r                                      %y3inf_r              %tauy3_r                   %xsinf                          %tauxs                        %y1inf                 %tauy1                   %y2_inf               %tauy2                          %minf                     %hinf                     %jinf                             %taum                %tauh                  %tauj
  bestc =            [   702.693062846, 6.28936390322743577,	16.47184329774172795,	7.72820764892593548,                5,	       5.70169429655,	6.49159859980375664              1.585380098276939087,	1.52777978270491110,	417.67456372875471970];		

%Global Constants 
global WTF; WTF = [2.04647510899866125,	11.92794719909794310,	6.58648897632262731, 1.48129916047758270,	       1.04883200971882040    ,	 1.50833999524741880*0.8 ,	0.00126255060921924*150, 1.92496636643373242*0.55                     ,	0.96599901568628443,	0.41959961556506770,	2.93143814587899509,	5.65058517109974456,	7.73239899024922828,	1.39620774164753403, 3.34782337287740361,	5.00434006135031684,	0.10227571298196084,	0.06947435150569056,	0.00192241669329621,	0.18655223855990699,	1.34845297577182488, 1.99059379632945599,	0.57601265706540539,	2.02939950754197973,	                                     0.95911921034929937,	0.22290441432117622*0.7,	5.82311629722667856,                  1,                       1,                    1,                 0.9*11.42643131771780318/11.42,    1.12536642299172884*1.2 , 4.46773718715095303/4,  	1004.43664100245177906];
global Kr_Par; Kr_Par = [1.81733402361720464,	-0.55417183629459443,	23.10316235137340968,	31.67604665654175733,	0.00837535305879988,	0.15513986797766749,	1.27989993154076487,	0.00517326546477969,	0.01850795777776976,	0.13531156893646071,	0.11640216351986897,	10.68980816609267848,	-2.22936686878534918,	32.77405541417513035];
%                          1                       2                           3                   4                       5                               6                           7                       8                9                     10                      11                      12                      13                      14                      15                      16                      17                      18                      19                      20                      21                      22                      23                      24                                  25                      26                          27                      28                  29                      30                          31                  32                      33                      34                      35                      36                      37                      38                        39                    40  
global OPT; OPT =[3758.50463468118778110,	10.06137254002946690,	9.19702613262256463,	1.71240428948949575,	21.96350355855883763,	0.44858898515164525,	10.80526515433044210,	0.00806423802070195,	0.25953354048617150,	0.39996686338037496,	0.29838480695170388,	0.07272196526382858,	18.40477436828069813,	978.58565231755494551,	0.09421467801523954,	0.03519130668911597,	0.11158579167042615,	0.02364961306258060,	0.00681091623359616,	528.75240434248689780, 0.81134296915697490,	0.16481481784377597,	0.65561279464116595,	5789911.89205291867256165,	0.51277740678558625,	21586039.34559330716729164,	3.44723660136627030,	0.05126330455206942,	0.00615003374897892,	10.59212474596603037,	0.00096176347799506,	28.14665416369973627,	2.39739846365710285,	0.92576564972413644,	0.52343949911321874,	43.12863982383754546,	0.00071032946273072,	0.09691028113978299,	0.00128808158965711,	0.80035732019709482];
global Cm; Cm =100;
global minfshift; minfshift=0.153846;
global tauh_coef; tauh_coef =1;
global tauj_coef; tauj_coef =1;
global ISOOPT;ISOOPT=[1, 1, 1];
global kbk; kbk = 3;
global KS; KS = 18; 
global VBKo; VBKo = 0.1;
global kCaBK; kCaBK = 6;
global Clo; Clo = 140; 
global zCl; zCl = -1;
global zCa;  zCa = 2; 
global Fara; Fara=96487;
global Temp; Temp=295.0;
global RR;    RR=8314;
global Nao;   Nao=140;
global ECaL; ECaL = 65;
global Ko;  Ko=5.4;
global a;   a=c0(74);
global b;   b=1-a;
global tausss; tausss=c0(100);
global fNa;  fNa=0.3;
global fK;   fK=1-fNa;
global INaKbar;  INaKbar=2.77430000589328563; %8
global kmk;   kmk=1.5;
global ICaPbar;  ICaPbar= 41.96269987854774541;
global kNaCa;   kNaCa=3.30909185645075077;       %0.000009984*10000;
global dNaCa;   dNaCa=0.0001;
global gamma;   gamma=0.5;
global Cao;    Cao=1.2;
global kmNai; kmNai=10;
global sigmaNa; sigmaNa = 1.5;
global sigmaK; sigmaK = 1;
global  kmCaP; kmCaP = 0.5;
global kmNa; kmNa = 87.5; %mmol;
global kmCa; kmCa = 1.38; % mmol/L
global ksat; ksat = 0.1;
global kappa; kappa = 0.35;

%Conducdances

global gNa;  gNa=bestc(1);
global gNa;  gNa=WTF(34);
global gCaL;   gCaL=bestc(2);
global gt;  gt=bestc(3);
global gss;  gss=0;
global gf;  gf=bestc(4);
global gK1;    gK1=bestc(5);
global gKr; gKr=bestc(6);
global gKs; gKs=bestc(7);
global gCaT; gCaT = bestc(8);
global gClb; gClb = bestc(9);
global gSCaK; gSCaK = 0;
global gBCaK; gBCaK = 0; 
global gBNa;  gBNa= 0.03263438;
global gBK;   gBK=0.05;
global gBCa;   gBCa=0.0024962559;

%% Call updatestates function

[t,dSVb] =   ode15s(@(t,p)updateStates(t,p,c0,bestc,0,0,0,1), expTime, z0); % Run the ODE
bestY    =   dSVb(:,1);
% format shortG
% cost = sum((dSVb(:,1) - data(:,2)).^2);
% disp('cost: ' + cost)

%% Global Variables
global ENa; 
global EK;
global ak1;
global bk1;
global k1inf;
global sigma;
global minf;
global hinf;
global jinf;
global taum;
global tauh;
global tauj;
global dinf;
global f11inf;
global f12inf;
global Cainactinf;
global taud;
global tauf11;
global tauf12;
global rinf;
global sinf;
global sslowinf;
global taur;
global taus;
global tausslow;
global rssinf;
global sssinf;
global taurss;
global tauCainact;
global ECl;

%% plotting part

 plot(expTime, bestY, '-g')
 title('AP')
 xlabel('Zaman (ms)')
 ylabel('Voltaj (mv)')
   %  legend('Deney','Similasyon')
%  hold off
%xlswrite('KONTROL_AP.xlsx',bestY)
% format shortG
% cost = sum((dSVb(:,1) - data(:,2)).^2);
% disp('cost: ' + cost)

%%%%%  plotting AP results %%%%%%%

%       INa_AP(expTime,c0,z0,bestc)
%       ICaL_AP(expTime,c0,z0,bestc)
%       It_AP(expTime,c0,z0,bestc) 
%       IK1_AP(expTime,c0,z0,bestc)
%       Ibackground(expTime,c0,z0,bestc)
%       Ipump(expTime,c0,z0,bestc)
%       Ihf_AP(expTime,c0,z0,bestc)
%       IKr_AP(expTime,c0,z0,bestc)
%       IKs_AP(expTime,c0,z0,bestc)
%       ICaT_AP(expTime,c0,z0,bestc)
%       IClb_AP(expTime,c0,z0,bestc)

%%%%%   plotting voltage clamp results %%%%%%

%       INa_vClamp_LAST(expTime,c0,z0,bestc);
%       ICal_vClamp_LAST(expTime,c0,z0,bestc)
%       IKr_vClamp_LAST(expTime,c0,z0,bestc)
%       IKs_vClamp_LAST(expTime,c0,z0,bestc)
%       It_vClamp_LAST(expTime,c0,z0,bestc)
%       ICaT_vClamp_LAST(expTime,c0,z0,bestc)
%       IK1_vClamp_LAST(expTime,c0,z0,bestc)
%       INaCa_vClamp_LAST(expTime,c0,z0,bestc)
%       IClCaclamp =IClCa_vClamp_LAST(expTime,c0,z0,bestc)


%%%%PLOTTING STATE-VARIABLES%%%%%%

% %to plot V choose 1
% %to plot m choose 2
% %to plot h choose 3
% %to plot j choose 4
% %to plot d choose 5
% %to plot f11 choose 6
% %to plot f12 choose 7
% %to plot Cainact choose 8
% %to plot r choose 9
% %to plot s choose 10
% %to plot sslow choose 11
% %to plot rss choose 12
% %to plot sss choose 13
% %to plot y choose 14
% % to plot PC1 choose 15
% % to plot Po1 choose 16
% % to plot Po2 choose 17
% % to plot PC2 choose 18
% % to plot HTRPNCa choose 19
% %to plot LTRPNCa choose 20
% %to plot Nai choose 21
% %to plot Ki choose 22
% %to plot Cai choose 23
% %to plot Cass choose 24
% %to plot CaJSR choose 25
% %to plot CaNSR choose 26

%       stateVariables(expTime,c0,z0,bestc,2)
%       stateVariables(expTime,c0,z0,bestc,3)
%       stateVariables(expTime,c0,z0,bestc,4)    
 
%%% Lead Potantial Analysis  %%%
%Lead_Pot_Analysis(expTime,c0,z0,bestc);

%%%% PLOTTING TIME-CONSTANTS %%%%%%%

%% to plot taum choose 2
%% to plot tauh choose 3
%% to plot tauj choose 4
%% to plot taud choose 5
%% to plot tauf11 choose 6
%% to plot tauf12 choose 7
%% to plot tauCainact choose 8
%% to plot taur choose 9
%% to plot taus choose 10
%% to plot tausslow choose 11
%% to plot taurss choose 12
%% to plot tausss choose 13
%% to plot tauy choose 14
%% to plot tauy1_r choose 15
%% to plot tauy2_r choose 16
%% to plot tauy3_r choose 17
%% to plot tauy1 choose 18
%% to plot tauy2 choose 19
%% to plot tauxs choose 20
% 
%           StateVariables_tau(c0,2)
%           StateVariables_tau(c0,3)
%           StateVariables_tau(c0,4)
%           StateVariables_tau(c0,5)
%           StateVariables_tau(c0,6)
%           StateVariables_tau(c0,7)
%           StateVariables_tau(c0,8)
%          StateVariables_tau(c0,9)
%          StateVariables_tau(c0,10)

   %%%%% PLOTTING STEADY-STATES %%%%%%%

%% to plot minf choose 2
%% to plot hinf choose 3
%% to plot jinf choose 4
%% to plot dinf choose 5
%% to plot f11inf choose 6
%% to plot f12inf choose 7
%% to plot Cainactinf choose 8
%% to plot rinf choose 9
%% to plot sinf choose 10
%% to plot sslowinf choose 11
%% to plot rssinf choose 12
%% to plot sssinf choose 13
%% to plot yinf choose 14
%% to plot y1inf_r choose 15
%% to plot y2inf_r choose 16
%% to plot y3inf_r choose 17
%% to plot y1inf choose 18
%% to plot y2inf choose 19
%% to plot xsinf choose 20
%% to plot K1inf choose 21
 
%    StateVariables_inf(c0,4)
%    StateVariables_inf(c0,5)
%   StateVariables_inf(c0,6)
%   StateVariables_inf(c0,7)
%   StateVariables_inf(c0,8)
%   StateVariables_inf(c0,9)
%    StateVariables_inf(c0,10)
