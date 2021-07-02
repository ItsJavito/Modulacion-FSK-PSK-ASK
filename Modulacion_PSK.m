clc;
clear all;
close all;
% Datos binarios
x=[ 1 0 0 1 1 0 1 1 0 0 1 1 0 1 0 1];
% Periodo del bit
bp=.000001;
disp(' Datos binarios en el Transmisor :');
disp(x);
%XX representación de los datos binarios transmitidos como una señal digital XXX
bit=[]; 
for n=1:1:length(x)
    if x(n)==1;
       se=ones(1,100);
    else x(n)==0;
        se=zeros(1,100);
    end
     bit=[bit se];
end
t1=bp/100:bp/100:100*length(x)*(bp/100);
subplot(3,1,1);
plot(t1,bit,'lineWidth',2.5);grid on;
axis([ 0 bp*length(x) -.5 1.5]);
ylabel('amplitud(volt)');
xlabel(' tiempo(seg)');
title('Datos binarios transmitidos como señal digital');
%XXXXXXXXXXXXXXXXXXXXXXX Modulación PSK-binaria XXXXXXXXXXXXXXXXXXXXXXXXXXX%
%VER UNA ONDA POR CICLO
% Amplitud de la señal portadora
A=5;
% Tasa de bit
br=1/bp;
% Frecuencia portadora para el dato "1"
f1=br*8;
% Frecuencia portadora para el dato "O"
t2=bp/99:bp/99:bp;                 
ss=length(t2);
m=[];
for (i=1:1:length(x))
    if (x(i)==1)
        y=A*sin(2*pi*f1*t2);
    else
        y=A*sin(2*f1*t2*pi + pi);
    end
    m=[m y];
end
t3=bp/99:bp/99:bp*length(x);
subplot(3,1,2);
plot(t3,m);
axis([ 0 bp*length(x) -6 6]);
xlabel('tiempo(seg)');
ylabel('amplitud(volt)');
title('Forma de onda para la modulación PSK correspondiente a los Datos binarios');

%XXXXXXXXXXXXXXXXXXXX Demodulación FSK-binaria XXXXXXXXXXXXXXXXXXXXXXXXXXXXX
mn=[];
for n=ss:ss:length(m)
  t=bp/99:bp/99:bp;
% Señal portadora para el dato "1"
  y1=sin(2*pi*f1*t);
% Señal portadora para el dato "0"
  y2=sin(2*pi*f1*t + pi);  %aqui
  mm=y1.*m((n-(ss-1)):n);
  mmm=y2.*m((n-(ss-1)):n); %aqui
  t4=bp/99:bp/99:bp;
  %
  z1=trapz(t4,mm)
  %
  z2=trapz(t4,mmm) %aqui
  zz1=round(2*z1/bp)
  zz2= round(2*z2/bp) %aqui
% nivel lógico = (0+A)/2 or (A+0)/2 or 2.5 ( en este caso)
  if(zz1>A/2)
    a=1;
  else(zz2>A/2) %aqui
    a=0;
  end
  mn=[mn a];
end
disp(' Datos binarios en el Receptor :');
disp(mn);
%XXXXX Representación de los Datos binarios como una señal digital la cual se alcanza 
%después de la demodulación XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
bit=[];
for n=1:length(mn);
    if mn(n)==1;
       se=ones(1,100);
    else mn(n)==0;
        se=zeros(1,100);
    end
     bit=[bit se];
end
t4=bp/100:bp/100:100*length(mn)*(bp/100);
subplot(3,1,3)
plot(t4,bit,'LineWidth',2.5);grid on;
axis([ 0 bp*length(mn) -.5 1.5]);
ylabel('amplitud(volt)');
xlabel(' tiempo(seg)');
title('Datos binarios recibidos como señal digital después de la demodulación PSK');
%>>>>>>>>>>>>>>>>>>>>>>>>>> fin del programa >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>%