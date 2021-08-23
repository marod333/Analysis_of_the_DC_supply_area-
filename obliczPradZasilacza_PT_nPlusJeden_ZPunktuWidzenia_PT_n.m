% Funkcja oblicza prad zasilacza 
% PT_nPlusJeden = indexLokalizacji_PT_nPlusJeden
% Prad w [A]
% 
%                             czasPradZasilacza_PT_nPlusJeden_Tablica
%                                         |
%                                         V 
%     -->     <--  -->                  <--  -->     <--  
%     ___...________________________________..._________
%   __|___      __|___         /          __|___     __|___
%   | /\ |      | /\ |         \          | /\ |     | /\ |
%   |/__\|      |/__\|      [Pojazd]      |/__\|     |/__\|
%   PT_Begin     PT_n         o  o        PT_n+1     PT_End
% 

function czasPradZasilacza_PT_nPlusJeden_Tablica = obliczPradZasilacza_PT_nPlusJeden_ZPunktuWidzenia_PT_n(indexLokalizacji_PT_n,indexLokalizacji_PT_nPlusJeden)

% Obliczenie czasPradZasilacza_PT_nPlusJeden_Tablica
% [godzina, minuta, sekunda, dziesietnaSekundy, pradZasilacza_PT_n]
% pradZasilacza_PT_n [A]

drogaPradZasilacza_PT_nPlusJeden_Tablica_zRozkladJazdyTablica=ObliczTabliceDrogaPradZasilaczaZPunktuWidzenia_PT_nPlusJeden(indexLokalizacji_PT_n,indexLokalizacji_PT_nPlusJeden);
liczbaWierszy_drogaPradZasilacza_PT_nPlusJeden_Tablica=size(drogaPradZasilacza_PT_nPlusJeden_Tablica_zRozkladJazdyTablica,1);
liczbaKolumn_drogaPradZasilacza_PT_nPlusJeden_Tablica=size(drogaPradZasilacza_PT_nPlusJeden_Tablica_zRozkladJazdyTablica,2);

czasPradZasilacza_PT_nPlusJeden_Tablica=zeros(liczbaWierszy_drogaPradZasilacza_PT_nPlusJeden_Tablica,5);
czasPradZasilacza_PT_nPlusJeden_Tablica(:,1:4)=drogaPradZasilacza_PT_nPlusJeden_Tablica_zRozkladJazdyTablica(:,1:4);

    for indexWierszaPT_nPlusJeden =1 : liczbaWierszy_drogaPradZasilacza_PT_nPlusJeden_Tablica
        for indexKolumntyPT_nPlusJeden = 6:2:liczbaKolumn_drogaPradZasilacza_PT_nPlusJeden_Tablica
            czasPradZasilacza_PT_nPlusJeden_Tablica(indexWierszaPT_nPlusJeden,5)=czasPradZasilacza_PT_nPlusJeden_Tablica(indexWierszaPT_nPlusJeden,5)+...
                                                               drogaPradZasilacza_PT_nPlusJeden_Tablica_zRozkladJazdyTablica(indexWierszaPT_nPlusJeden, indexKolumntyPT_nPlusJeden);
        end
    end
    
% Obliczenie czasPradZasilacza_PT_nPlusJeden_Tablica
% [godzina, minuta, sekunda, dziesietnaSekundy, pradZasilacza_PT_nPlusJeden]
% pradZasilacza_PT_n [A]
end

