function dSV = updateStates(t, p, c, bestc, clamp, duration, holdingvoltage, control)
V=p(1);
m=p(2);
h=p(3);
j=p(4);
d=p(5);
f11=p(6);
f12=p(7);
Cainact=p(8);
r=p(9);
s=p(10);
sslow=p(11);
rss=p(12);
sss=p(13);
y=p(14);
PC1=p(15);
Po1=p(16);
Po2=p(17);
PC2=p(18);
HTRPNCa=p(19);
LTRPNCa=p(20);
Nai=p(21);
Ki=p(22);
Cai=p(23);
Cass=p(24);
CaJSR=p(25);
CaNSR=p(26);
y1_r=p(27);
y1=p(28);
y2=p(29);
Cli=p(30);
xs=p(31);
y2_r=p(32);

global Cao;    
global Clo; 
global zCl;  
global Fara; 
global Temp; 
global RR;    
global Nao;   
global ECaL;  
global Ko;    
global a;   
global b;   
global tausss; 
global gss;   
global fNa;  
global fK;  
global WTF;
global OPT
global kmNai; 
global sigmaNa; 
global sigmaK; 
global  kmCaP;
global kmNa; 
global kmCa;
global ksat; 
global kappa; 
global kmk;
global Kr_Par;
global Cm;
global minfshift;
global tauh_coef;
global tauj_coef;

if control==0
    if  (60<=t)&&(t<=duration)
        V=clamp;
    else 
        V=holdingvoltage;
    end
end

global ISOOPT;
das = [5.60681706122327572,	0.89569071460167926,	4.86132447866875150*1/4];
SAD = [2.56428696755122099,	1.54582201447388190,	0.90285354391065875,	0.00161264095065032,	0.14844147776872957,	0.48157003399756093,	17.57613543767341469,	0.39050945833520073,	11.08468874904325574];

 %INa%

minf = WTF(28)*1/(1+0.00165*exp(-minfshift*V+-0.220981)); 
hinf = WTF(29)*1/(1+20*exp(0.166667*V+10.3005));
jinf = WTF(30)*1/(1+20*exp(0.166667*V+10.3005));
taum = das(1)*1/(-4581.148*exp(0.02658706*V-3.173348)+879.0479*exp(0.02601976*V-1.462856)-0.00055085*exp(-0.05350117*V+7.812605)+0.00000005031833*exp(-0.06861765*V+16.49407));
tauh = tauh_coef*das(2)*2*1/(0.604042*exp(0.000208302*V+2.40481)+8.62238e-007*exp(0.0410774*V+14.6605)+-6.92416*exp(0.00115309*V+0.0464334));
tauj = tauj_coef*0.6*das(3)*1.4*1/(0.0395595*exp(-0.0222401*V+-0.0798323)-2.62823*exp(0.001759*V+0.0249754)+-1.12806*exp(0.0103543*V+0.14098)+0.0136933*exp(0.00503438*V+5.68786));

dm=(minf-m)/taum;
dh=(hinf-h)/tauh;
dj=(jinf-j)/tauj;

ENa=(log(Nao / Nai) * RR * Temp / Fara);
INa=OPT(1)*m^3*h*j*(V-ENa);

%ICaL%

dinf = 1./(1+WTF(1).*exp(-0.18.*V-3.5)); 
f11inf = 1./(1+WTF(2).*exp(0.2.*V+2.5)); 
f12inf = 1./(1+WTF(2).*exp(0.2.*V+4.06704));
Cainactinf=1/(1+Cass/1);

taud =0.35*1.93289277018277161*WTF(4)*1/(0.321128*exp(-0.02531594*V+6.696409)+10.83169*exp(-0.0172372*V+1.297683)-4.452274*exp(-0.02430877*V+4.208)+0.006673*exp(0.125818*V-1.155094));

if (V<=-24)
 tauf11 = 1/(0.000277993*exp(-0.0952253*V+-1.50471)+0.954033*exp(0.110419*V+-0.595677));
 tauf12 = 1/(5.1693e-005*exp(-0.0902712*V+0.264952)+-3.16992*exp(0.112547*V+-1.84516)+0.00216701*exp(0.086623*V+5.07041)+413.37*exp(1.53804*V+19.0502));
else
 tauf11 = 1/(-0.171445*exp(0.0212861*V+2.32256)+2.29941*exp(0.0207738*V+-0.245512));
 tauf12 = 1/(13204.6*exp(-556.709*V+-51.1203)+-8959.66*exp(6523.77*V+950.013))+1.12902*exp(-0.116624*V+0.880366)+11.0349*exp(0.00205575*V+1.95679);
end
tauCainact=WTF(9)*c(72)*1.73049314894288120;

dd=(dinf-d)/taud;
df11=(f11inf-f11)/tauf11;
df12=(f12inf-f12)/tauf12;
dCainact=(Cainactinf-Cainact)/tauCainact;

ICaL=OPT(2)*d*(V-ECaL)*(Cainact*f11+(1-Cainact)*f12);

%It%

rinf = 1/(1+2.90432*exp(-0.0875657*V+-1.99439));
sinf = 1/(1+7.37449*exp(0.145262*V+4.58235));
sslowinf  = 1/(1+7.37449*exp(0.145262*V+4.58235));

OPT(21) = 0.81134;
OPT(22) = 0.16481;
OPT(23) = 0.65561;

taur =ISOOPT(1)*(1/23.137)*OPT(21)*WTF(13)*1/(0.05666259*exp(-0.1*V-4.629299)+0.0006836628*exp(0.03577*V+4.592708));
if (V<-40)
taus = ISOOPT(2)*1./(0.392218.*exp(0.103817.*V+1.51579)+9.47479e-007.*exp(-0.101324.*V+0.120094));
else
taus = ISOOPT(2)*1./(-0.594439.*exp(0.000894656.*V+-0.0142439)+0.180925.*exp(0.000845693.*V+1.22256));
end
tausslow =ISOOPT(3)*(1/3)* OPT(23)*WTF(16)*1/(1.031676*exp(0.09350471*V+0.8956964)+0.01238496*exp(-0.02151897*V-5.554121)+41406280*exp(-0.2160407*V-46.40482)-0.00000000000325579*exp(0.0936115*V+27.37296));

dr=(rinf-r)/taur;
ds=(sinf-s)/taus;
dsslow=(sslowinf-sslow)/tausslow;

EK=(log(Ko / Ki) * RR * Temp / Fara);
It=OPT(3)*r*(a*s+b*sslow)*(V-EK);

rssinf = 1/(1+3.02649*exp(-0.0846024*V+-2.08033)); 
sssinf = 1/(1+5.87715*exp(0.0970874*V+6.72407));

taurss = 1/(0.00004091154*exp(-0.1*V+0.07842934)+0.1908238*exp(0.03577*V-3.564662));

drss=(rssinf-rss)/taurss;
dsss=(sssinf-sss)/tausss;

Iss=0*rss*sss*(V-EK);

%Ihf%

yinf=1/(1+exp((V+138.6)/10.48));
tauy=1000/(0.11885*exp((V+80)/28.37)+0.56236*exp((V+80)/(-14.19)));

dy=(yinf-y)/tauy;

Ihf=OPT(4)*y*(fNa*(V-ENa)+fK*(V-EK));

%Background currents

IBNa=OPT(10)*(V-ENa);
IBK=OPT(11)*(V-EK);
IBCa=OPT(12)*(V-ECaL);
IB=IBNa+IBCa+IBK;

%IK1%

EK1=((RR*Temp)/Fara)*log(Ko/Ki);

k1inf = 1/(1+1.2*exp(0.0814709*V+6.86));

IK1=OPT(5)*k1inf*(V-EK1);

y1inf_r = 1/(1+Kr_Par(1)*exp(Kr_Par(2)*V+Kr_Par(3)));
tauy1_r=Kr_Par(4)*0.0739*1/(Kr_Par(5)*exp(Kr_Par(6)*V+Kr_Par(7))+Kr_Par(8)*exp(Kr_Par(9)*V+Kr_Par(10)));
y2inf_r = 1/(1+Kr_Par(11)*exp(Kr_Par(12)*V+Kr_Par(13)));
tauy2_r = Kr_Par(14); 

IKr = y1_r*y2_r*OPT(6)*(V-EK);
dy1_r = (y1inf_r-y1_r)/tauy1_r;
dy2_r = (y2inf_r-y2_r)/tauy2_r;
 
xsinf = 1/(1+0.1669*exp(-0.06689*V+0.6416)); 
tauxs=0.0739*1/(0.0008245*exp(0.005448*V+1.23898)+0.000548*exp(-0.04264666*V+0.3405));
dxs = (xsinf-xs)/tauxs;

IKs = OPT(7)*(xs)^2*(V - EK);

% ICat t type Ca2+ current

WTF(26) = 0.161;
y1inf = 1./(1+exp(-0.162.*V-6.92));
y2inf = 1./(1+1*exp(WTF(26).*V+12.2));

tauy1 = WTF(25)*1/(0.321128*exp(-0.02531594*V+6.696409)+10.83169*exp(-0.0172372*V+1.297683)-4.452274*exp(-0.02430877*V+4.208)+0.006673*exp(0.125818*V-1.155094));
tauy2 = WTF(27)*1/(0.0081053*exp(-0.0824904*V+-5.18152)+0.000875418*exp(0.0312989*V+4.59337));

dy1 = (y1inf-y1)/tauy1;
dy2 = (y2inf-y2)/tauy2;
ICaT = OPT(8)*y1*y2*(V-ECaL);

%%IClb background Cl current
JNKCCl = 2.708 * 10^(-6);

ECl=(log(Clo / Cli) * RR * Temp / (zCl*Fara));
IClb = OPT(9)* (V-ECl);

dCli = (Cm * IClb/zCl/Fara)+2*JNKCCl;


%  ------------------- CA2+ HANDLING MECHANISM AND PUMP CURRENTS ------------

sig = 1/7*(exp(Nao/67.3) - 1);
fNaK = 1/(1+ OPT(16)*exp(-OPT(17)*V*Fara/(RR*Temp)) + OPT(18)*sig*exp(-OPT(19)*V*Fara/(RR*Temp)));
INaK=OPT(13)*(1/(1 + (kmNai/Nai)^sigmaNa))*(1/(1 + ((kmk / Ko)^sigmaK)))*fNaK;
ICaP=OPT(14)*(1/(1 + kmCaP/Cai));
INaCa=OPT(15)*(1/(kmNa^3 + Nao^3))*(1/kmCa + Cao)*(1/(1 + ksat*exp((kappa -1)*V*Fara/(RR*Temp))))*(exp(kappa*V*Fara/(RR*Temp))*(Nai^3)*Cao - exp((kappa - 1)*V*Fara/(RR*Temp))*(Nao^3)*Cai);

kbm=OPT(27);
kcp=OPT(28);
kcm=OPT(29);
nn=4;
mm=3;
kap=OPT(24);
kam=OPT(25);
kbp=OPT(26);
v1=OPT(30);
dPC1=-kap*Cass^nn*PC1+kam*Po1;
dPo1=kap*Cass^nn*PC1-kam*Po1-kbp*Cass^mm*Po1+kbm*Po2-kcp*Po1+kcm*PC2;
dPo2=kbp*Cass^mm*Po1-kbm*Po2;
dPC2=kcp*Po1-kcm*PC2;

Jrel=v1*(Po1+Po2)*(CaJSR-Cass);

%SERCA Ca-pump
Kfb=OPT(31);
Krb=OPT(32);
KSR=OPT(33);
Nfb=1.2;
Nrb=1;
vmaxf=0.00004;
vmaxr=0.0009;
fb=(Cai/Kfb)^Nfb;
rb=(CaNSR/Krb)^Nrb;
Jup=KSR*(vmaxf*fb-vmaxr*rb)/(1+fb+rb);

%%Intracellular and sarcoplasmic reticulum Ca fluxes
tautr=OPT(34);
tauxfer=OPT(35);
HTRPNtot=0.14;
LTRPNtot=0.07;
khtrpnp=20;
khtrpnp=OPT(36);
khtrpnm=OPT(37);
kltrpnp=OPT(38);
kltrpnm=OPT(39);

Jtr= (CaNSR-CaJSR)/tautr;
Jxfer=(Cass-Cai)/tauxfer;
Jtrpn=(khtrpnp*Cai*(HTRPNtot-HTRPNCa)-khtrpnm*HTRPNCa)+(kltrpnp*Cai*(LTRPNtot-LTRPNCa)-kltrpnm*LTRPNCa);
dHTRPNCa=khtrpnp*Cai*(HTRPNtot-HTRPNCa)-khtrpnm*HTRPNCa;
dLTRPNCa=kltrpnp*Cai*(LTRPNtot-LTRPNCa)-kltrpnm*LTRPNCa;

%Intracellular Ion Concentrations
Vmyo=9.36;
KmCMDN=0.00238;
KmCSQN=0.8;
KmEGTA=0.00015;
CMDNtot=0.05;
CSQNtot=15;
EGTAtot=10;
VJSR=0.056;
Vss=0.0012;
VNSR=0.504;

betai=(1+(CMDNtot*KmCMDN)/(KmCMDN+Cai)^2); 
betass=(1+(CMDNtot*KmCMDN)/(KmCMDN+Cass)^2)^(-1);
betajsr=(1+(CSQNtot*KmCSQN)/(KmCSQN+CaJSR)^2)^(-1);

ACaP =OPT(40);
dNai=-(INa+IBNa+3*INaCa+3*INaK+Ihf)*(ACaP*Cm)/(Vmyo*Fara); 
dKi=-(ACaP*Cm)*(IKr+IKs+IBK+It+IK1+Ihf-2*INaK)/(Vmyo*Fara);
dCai=betai*(Jxfer-Jup-Jtrpn-(IBCa-2*INaCa+ICaP)*(ACaP*Cm)/(2*Vmyo*Fara));

dCass=betass*(Jrel*VJSR/Vss-Jxfer*Vmyo/Vss-(ICaL*(ACaP*Cm)/(2*Vss*Fara)));
dCaJSR=betajsr*(Jtr-Jrel);
dCaNSR=Jup*Vmyo/VNSR-Jtr*VJSR/VNSR;

if(65<=t)&&(t<=70)
Iapp=OPT(20);
else
    Iapp=0;
end
dV=(-INa-ICaL-It-Iss-Ihf-IB-IK1-INaK-ICaP-INaCa-IKr-IKs-ICaT-IClb+Iapp)/Cm;

dSV=[dV;dm;dh;dj;dd;df11;df12;dCainact;dr;ds;dsslow;drss;dsss;dy;dPC1;dPo1;dPo2;dPC2;dHTRPNCa;dLTRPNCa;dNai;dKi;dCai;dCass;dCaJSR;dCaNSR;dy1_r;dy1;dy2;dCli;dxs;dy2_r];
end
