% Funkcja oblicza prady zasilaczy 
% PT_n = indexLokalizacji_PT_n
% Prad w [A]
% 
%   czasPradZasilacza_PT_n_Tablica
%                  |                      
%                  V                       
%     -->     <--  -->                  <--  -->     <--  
%     ___...________________________________..._________
%   __|___      __|___         /          __|___     __|___
%   | /\ |      | /\ |         \          | /\ |     | /\ |
%   |/__\|      |/__\|      [Pojazd]      |/__\|     |/__\|
%   PT_Begin     PT_n         o  o        PT_n+1     PT_End
% 

function czasPradZasilacza_PT_n_Tablica = obliczPradZasilacza_PT_n_ZPunktuWidzenia_PT_n(indexLokalizacji_PT_n,indexLokalizacji_PT_nPlusJeden)

% Obliczenie czasPradZasilacza_PT_n_Tablica
% [godzina, minuta, sekunda, dziesietnaSekundy, pradZasilacza_PT_n]
% pradZasilacza_PT_n [A]

drogaPradZasilacza_PT_n_Tablica_zRozkladJazdyTablica=ObliczTabliceDrogaPradZasilaczaZPunktuWidzenia_PT_n(indexLokalizacji_PT_n,indexLokalizacji_PT_nPlusJeden);
liczbaWierszy_drogaPradZasilacza_PT_n_Tablica=size(drogaPradZasilacza_PT_n_Tablica_zRozkladJazdyTablica,1);
liczbaKolumn_drogaPradZasilacza_PT_n_Tablica=size(drogaPradZasilacza_PT_n_Tablica_zRozkladJazdyTablica,2);

czasPradZasilacza_PT_n_Tablica=zeros(liczbaWierszy_drogaPradZasilacza_PT_n_Tablica,5);
czasPradZasilacza_PT_n_Tablica(:,1:4)=drogaPradZasilacza_PT_n_Tablica_zRozkladJazdyTablica(:,1:4);

    for indexWierszaPT_n =1 : liczbaWierszy_drogaPradZasilacza_PT_n_Tablica
        for indexKolumntyPT_n = 6:2:liczbaKolumn_drogaPradZasilacza_PT_n_Tablica
            czasPradZasilacza_PT_n_Tablica(indexWierszaPT_n,5)=czasPradZasilacza_PT_n_Tablica(indexWierszaPT_n,5)+...
                                                               drogaPradZasilacza_PT_n_Tablica_zRozkladJazdyTablica(indexWierszaPT_n, indexKolumntyPT_n);
        end
    end
    
% Obliczenie czasPradZasilacza_PT_nPlusJeden_Tablica
% [godzina, minuta, sekunda, dziesietnaSekundy, pradZasilacza_PT_nPlusJeden]
% pradZasilacza_PT_n [A]

end

