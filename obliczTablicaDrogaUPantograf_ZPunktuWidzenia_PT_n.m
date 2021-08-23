% Sprawdzony OK
% Program pobiera 
% indexLokalizacji_PT_n,indexLokalizacji_PT_nPlusJeden
% DaneWejsioweDoObliczenPradowZasilaczy
% DaneWejsioweLokalizacjePodstacji

% Program oddaje tablice: drogaUPantograf_ZPunktuWidzenia_PT_n_Tablica
% postaæ
% [godzina, minuta, sekunda, dziesietnaSekundy, liczba* [lokalizacjaPojazduNaTrasie, UPantografu_ZPunktuWidzenia_PT_n]]
% "liczba" wiersz wyzej jest obliczana na podstawie liczby kolumn z RozkaldJazdyTablica


% Funkcja oblicza spadek napiecia na pantografie z punktu widzenia PT_n
% PT_n = indexLokalizacji_PT_n
% Prad w [A]
% Napiecie w [V]
% 
% 
%   drogaUPantograf_ZPunktuWidzenia_PT_n_Tablica
%                   |
%                   |   U_stratNapieciaNaTrasie
%                   |     |               
%                   V     V                
%     -->     <--  -->   __               <--  -->     <--  
%     ___...____________[__]____________________..._________
%   __|___      __|___           /          __|___     __|___
%   | /\ |      | /\ |           \          | /\ |     | /\ |
%   |/__\|      |/__\|        [Pojazd]      |/__\|     |/__\|
%   PT_Begin     PT_n           o  o        PT_n+1     PT_End
%   ________________T___[__]____T__T___________T_____________<-tor
% 
%  U_stratNapieciaNaTrasie==(Opor_zast_sieciTrakcyjnej+Opor_zast_szyn+OporDodatkowy)*(PolozeniePojazduNaTrasie-Lokalizacja_PT_n)*PradZasilacza_PT_n_ZPunktuWidzenia_PT_n
%  Kod U_stratNapieciaNaTrasie:
% (...
% (r_zast_sieciTrakcyjnej+r_zast_szyn+r_dodatkowe).*...
%  (drogaPojazduWDanejKolumnie-lokalizacja_PT_n)...
% )...
% .*pradZasilaczaWDanejKolumnie)

function drogaUPantograf_ZPunktuWidzenia_PT_n_Tablica = obliczTablicaDrogaUPantograf_ZPunktuWidzenia_PT_n(indexLokalizacji_PT_n,indexLokalizacji_PT_nPlusJeden)

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
% lokalizacja_PT_n=lokalizacjaPotstacjiTrakcyjnych(2,1);
lokalizacja_PT_n=lokalizacjaPotstacjiTrakcyjnych(indexLokalizacji_PT_n,1);
lokalizacja_PT_n=cell2mat(lokalizacja_PT_n);

% pobierz droge i prad zasilacza do obliczen spadku napiecia UPantograf_ZPunktuWidzenia_PT_n

drogaPradZasilacza_PT_n_Tablica_zRozkladJazdyTablica=ObliczTabliceDrogaPradZasilaczaZPunktuWidzenia_PT_n(indexLokalizacji_PT_n,indexLokalizacji_PT_nPlusJeden);
liczbaWierszy_drogaPradZasilacza_PT_n_Tablica=size(drogaPradZasilacza_PT_n_Tablica_zRozkladJazdyTablica,1);
liczbaKolumn_drogaPradZasilacza_PT_n_Tablica=size(drogaPradZasilacza_PT_n_Tablica_zRozkladJazdyTablica,2);

drogaUPantograf_ZPunktuWidzenia_PT_n_Tablica=zeros(liczbaWierszy_drogaPradZasilacza_PT_n_Tablica,liczbaKolumn_drogaPradZasilacza_PT_n_Tablica);
drogaUPantograf_ZPunktuWidzenia_PT_n_Tablica(:,1:4)=drogaPradZasilacza_PT_n_Tablica_zRozkladJazdyTablica(:,1:4);

    for indexKolumntyPT_n = 6:2:liczbaKolumn_drogaPradZasilacza_PT_n_Tablica
    %   Wpisanie drogi do drogaUPantograf_ZPunktuWidzenia_PT_n_Tablica
        drogaPojazduWDanejKolumnie=drogaPradZasilacza_PT_n_Tablica_zRozkladJazdyTablica(:,indexKolumntyPT_n-1);
        pradZasilaczaWDanejKolumnie=drogaPradZasilacza_PT_n_Tablica_zRozkladJazdyTablica(:,indexKolumntyPT_n);
        drogaUPantograf_ZPunktuWidzenia_PT_n_Tablica(:,indexKolumntyPT_n-1)=drogaPojazduWDanejKolumnie;
    %   Obliczenie spadku napiecia na pantogragie w danej kolumnie
    %   przypozadkowanej do drogi z kolumny wczesniejszej
    drogaUPantograf_ZPunktuWidzenia_PT_n_Tablica(:,indexKolumntyPT_n)= napiecieWyjsciowePodstacjiTrakcyjnejDoUPantograf-(...
                                                                        (...
                                                                        (r_zast_sieciTrakcyjnej+r_zast_szyn+r_dodatkowe).*...
                                                                        (drogaPojazduWDanejKolumnie-lokalizacja_PT_n)...
                                                                        )...
                                                                        .*pradZasilaczaWDanejKolumnie);
    end
end

