% Program sprawdzony
% Program pobiera 
% indexLokalizacji_PT_n,indexLokalizacji_PT_nPlusJeden
% DaneWejsioweDoObliczenPradowZasilaczy
% DaneWejsioweLokalizacjePodstacji

% Program oddaje tablice: drogaUPantograf_ZPunktuWidzenia_PT_nPlusJeden_Tablica
% postaæ
% [godzina, minuta, sekunda, dziesietnaSekundy, liczba* [lokalizacjaPojazduNaTrasie, UPantografu_ZPunktuWidzenia_PT_nPlusJeden]]
% "liczba" wiersz wyzej jest obliczana na podstawie liczby kolumn z RozkaldJazdyTablica


% Funkcja oblicza spadek napiecia na pantografie z punktu widzenia PT_nPlusJeden
% PT_nPlusJeden = indexLokalizacji_PT_nPlusJeden
% Prad w [A]
% Napiecie w [V]
% 
% 
%                               drogaUPantograf_ZPunktuWidzenia_PT_nPlusJeden_Tablica
%                                           |
%                   U_stratNapieciaNaTrasie |
%      indexLokalizacji_PT_n           |    |
%                  |                   |    |
%                  V                   V    V 
%     -->     <--  -->                __  <--  -->     <--  
%     ___..._________________________[__]_______..._________
%   __|___      __|___           /          __|___     __|___
%   | /\ |      | /\ |           \          | /\ |     | /\ |
%   |/__\|      |/__\|        [Pojazd]      |/__\|     |/__\|
%   PT_Begin     PT_n           o  o        PT_n+1     PT_End
%   ________________T_________T__T___[__]______T_____________<-tor
% 
%  U_stratNapieciaNaTrasie=((Opor_zast_sieciTrakcyjnej+Opor_zast_szyn+OporDodatkowy)*(Lokalizacja_PT_nPlusJeden-PolozeniePojazduNaTrasie))*PradZasilacza_PT_nPlusJeden_ZPunktuWidzenia_PT_n
% (...
% (r_zast_sieciTrakcyjnej+r_zast_szyn+r_dodatkowe).*...
% (lokalizacja_PT_nPlusJeden-drogaPojazduWDanejKolumnie)...
% )...
% .*pradZasilaczaWDanejKolumnie);

function drogaUPantograf_ZPunktuWidzenia_PT_nPlusJeden_Tablica = obliczTablicaDrogaUPantograf_ZPunktuWidzenia_PT_nPlusJeden(indexLokalizacji_PT_n,indexLokalizacji_PT_nPlusJeden)

% pobranie danych wejsciowych z pliku DaneWejsioweDoObliczenPradowZasilaczy
DaneWejsioweDoObliczenPradowZasilaczy;

%    zmiana jednostki z Ohm/km na Ohm/m
%    1 1/(1 [km]) = 1/(1000 [m])=1/1000 [1/m]
r_zast_sieciTrakcyjnej=r_zast_sieciTrakcyjnej/1000; %[ohm/m]
r_zast_szyn=r_zast_szyn/1000; %[ohm/m]
r_dodatkowe=r_dodatkowe/1000; %[ohm/m]

% pobranie danych wejsciowych z pliku DaneWejsioweLokalizacjePodstacji
DaneWejsioweLokalizacjePodstacji;

% lokalizacjaPotstacjiTrakcyjnych(numer_podstacji,1)
% przyklad
% lokalizacja_PT_nPlusJeden=lokalizacjaPotstacjiTrakcyjnych(2,1);
lokalizacja_PT_nPlusJeden=lokalizacjaPotstacjiTrakcyjnych(indexLokalizacji_PT_nPlusJeden,1);
lokalizacja_PT_nPlusJeden=cell2mat(lokalizacja_PT_nPlusJeden);

% pobierz droge i prad zasilacza do obliczen spadku napiecia UPantograf_ZPunktuWidzenia_PT_n

drogaPradZasilacza_PT_nPlusJeden_Tablica_zRozkladJazdyTablica=ObliczTabliceDrogaPradZasilaczaZPunktuWidzenia_PT_nPlusJeden(indexLokalizacji_PT_n,indexLokalizacji_PT_nPlusJeden);
liczbaWierszy_drogaPradZasilacza_PT_nPlusJeden_Tablica=size(drogaPradZasilacza_PT_nPlusJeden_Tablica_zRozkladJazdyTablica,1);
liczbaKolumn_drogaPradZasilacza_PT_nPlusJeden_Tablica=size(drogaPradZasilacza_PT_nPlusJeden_Tablica_zRozkladJazdyTablica,2);

drogaUPantograf_ZPunktuWidzenia_PT_nPlusJeden_Tablica=zeros(liczbaWierszy_drogaPradZasilacza_PT_nPlusJeden_Tablica,liczbaKolumn_drogaPradZasilacza_PT_nPlusJeden_Tablica);
drogaUPantograf_ZPunktuWidzenia_PT_nPlusJeden_Tablica(:,1:4)=drogaPradZasilacza_PT_nPlusJeden_Tablica_zRozkladJazdyTablica(:,1:4);

    for indexKolumntyPT_nPlusJeden = 6:2:liczbaKolumn_drogaPradZasilacza_PT_nPlusJeden_Tablica
    %   Wpisanie drogi do drogaUPantograf_ZPunktuWidzenia_PT_nPlusJeden_Tablica
        drogaPojazduWDanejKolumnie=drogaPradZasilacza_PT_nPlusJeden_Tablica_zRozkladJazdyTablica(:,indexKolumntyPT_nPlusJeden-1);
        pradZasilaczaWDanejKolumnie=drogaPradZasilacza_PT_nPlusJeden_Tablica_zRozkladJazdyTablica(:,indexKolumntyPT_nPlusJeden);
        drogaUPantograf_ZPunktuWidzenia_PT_nPlusJeden_Tablica(:,indexKolumntyPT_nPlusJeden-1)=drogaPojazduWDanejKolumnie;
    %   Obliczenie spadku napiecia na pantogragie w danej kolumnie
    %   przypozadkowanej do drogi z kolumny wczesniejszej
    drogaUPantograf_ZPunktuWidzenia_PT_nPlusJeden_Tablica(:,indexKolumntyPT_nPlusJeden)= napiecieWyjsciowePodstacjiTrakcyjnejDoUPantograf-(...
                                                                        (...
                                                                        (r_zast_sieciTrakcyjnej+r_zast_szyn+r_dodatkowe).*...
                                                                        (lokalizacja_PT_nPlusJeden-drogaPojazduWDanejKolumnie)...
                                                                        )...
                                                                        .*pradZasilaczaWDanejKolumnie);
    end
end

