% Program sprawdzony OK
% Program pobiera 
% indexLokalizacji_PT_n,indexLokalizacji_PT_nPlusJeden

% Program oddaje tablice: czasUPantograf_PT_nPlusJeden_Tablica
% postaæ
% [godzina, minuta, sekunda, dziesietnaSekundy, czasUPantograf_PT_nPlusJeden_Tablica]

% Funkcja oblicza spadek napiecia na pantografie z punktu widzenia PT_nPlusJeden
% spadek napiecia dotyczy wszystkich pojazdow na trasie 
% miedzy PT_n a PT_nPlusJeden
% PT_n skorelowany z indexLokalizacji_PT_n
% Prad w [A]
% Napiecie w [V]
% 
% 
%               czasUPantograf_PT_nPlusJeden_Tablica
%                                   |
%                                   |   U_stratNapieciaNaTrasie_PT_nPlusJeden
%                                   |    |        
%                                   V    V            
%     -->     <--  -->             <--  __      <--  -->     <--  
%     ___...___________________________[__]_____..._________
%   __|___      __|___           /          __|___     __|___
%   | /\ |      | /\ |           \          | /\ |     | /\ |
%   |/__\|      |/__\|        [Pojazd]      |/__\|     |/__\|
%   PT_Begin     PT_n           o  o        PT_n+1     PT_End
%   ________________T___[__]____T__T___________T_____________<-tor
% 
%  U_stratNapieciaNaTrasie_PT_nPlusJeden=suma(...
% (Opor_zast_sieciTrakcyjnej+Opor_zast_szyn+OporDodatkowy)*(Lokalizacja_PT_nPlusJeden-PolozeniePojazduNaTrasie)*PradZasilacza_PT_nPlusJeden_ZPunktuWidzenia_PT_n...
% )

function czasUPantograf_PT_nPlusJeden_Tablica = obliczUPantograf_PT_nPlusJeden_ZPunktuWidzenia_PT_n(indexLokalizacji_PT_n,indexLokalizacji_PT_nPlusJeden)

    % pobranie danych napiecieWyjsciowePodstacjiTrakcyjnejDoUPantograf 
    % z pliku DaneWejsioweDoObliczenPradowZasilaczy
    DaneWejsioweDoObliczenPradowZasilaczy;
    % usuwanie zbednych danych
    clear r_przewoduJezdnego r_linkiNosnej r_parySzyn liczbaTorowNaSzlaku 
    clear U_max_wyjsciowe_podstacjiTrakcyjnej U_min_wyjsciowe_podstacjiTrakcyjnej U_n_wyjsciowe_podstacjiTrakcyjnej
    clear r_dodatkowe r_zast_szyn r_zast_przewoduJezdnego r_zast_sieciTrakcyjnej

    % Oblicz: drogaUPantograf_PT_nPlusJeden_ZPunktuWidzenia_PT_n_Tablica 
    % z funkcji obliczTablicaDrogaUPantograf_ZPunktuWidzenia_PT_nPlusJeden
    % [godzina, minuta, sekunda, dziesietnaSekundy, liczba* [lokalizacjaPojazduNaTrasie, UPantografu_ZPunktuWidzenia_PT_nPlusJeden]]
    % "liczba" wiersz wyzej jest obliczana na podstawie liczby kolumn z RozkaldJazdyTablica
    % U_Pantograf_PT_n [V]

    drogaUPantograf_PT_nPlusJeden_ZPunktuWidzenia_PT_n_Tablica=obliczTablicaDrogaUPantograf_ZPunktuWidzenia_PT_nPlusJeden(indexLokalizacji_PT_n,indexLokalizacji_PT_nPlusJeden);
    liczbaWierszy_drogaUPantograf_PT_nPlusJeden_Tablica=size(drogaUPantograf_PT_nPlusJeden_ZPunktuWidzenia_PT_n_Tablica,1);
    liczbaKolumn_drogaUPantograf_PT_nPlusJeden_Tablica=size(drogaUPantograf_PT_nPlusJeden_ZPunktuWidzenia_PT_n_Tablica,2);

    czasUPantograf_PT_nPlusJeden_Tablica=zeros(liczbaWierszy_drogaUPantograf_PT_nPlusJeden_Tablica,5);
    czasUPantograf_PT_nPlusJeden_Tablica(:,1:4)=drogaUPantograf_PT_nPlusJeden_ZPunktuWidzenia_PT_n_Tablica(:,1:4);
%   Tworzenie macierzy kolumnowej do zapisania calkowitych strat NapieciaNaTrasie_PT_nPlusJeden
%   Macierz: U_stratNapieciaNaTrasie_PT_nPlusJeden
    U_stratNapieciaNaTrasie_PT_nPlusJeden=zeros(liczbaWierszy_drogaUPantograf_PT_nPlusJeden_Tablica,1);
    
    for indexKolumntyPT_nPlusJeden = 6:2:liczbaKolumn_drogaUPantograf_PT_nPlusJeden_Tablica
    %   Obliczenie spadku napiecia na pantogragie w danej kolumnie
    %   przypozadkowanej do drogi z kolumny wczesniejszej
        U_stratNapieciaNaTrasie_PT_nPlusJeden=U_stratNapieciaNaTrasie_PT_nPlusJeden+...
                                     (napiecieWyjsciowePodstacjiTrakcyjnejDoUPantograf-drogaUPantograf_PT_nPlusJeden_ZPunktuWidzenia_PT_n_Tablica(:,indexKolumntyPT_nPlusJeden));
    end
    
    czasUPantograf_PT_nPlusJeden_Tablica(:,5)=napiecieWyjsciowePodstacjiTrakcyjnejDoUPantograf-U_stratNapieciaNaTrasie_PT_nPlusJeden;
end

