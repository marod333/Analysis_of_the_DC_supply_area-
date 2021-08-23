% Sprawdzone ok
% Program s³u¿y do obliczenia tablicy UPantograf_PT_nPlusJeden_ZPunktuWidzenia_PT_n*abs(Ipantografu)*delta_t
% ze wzoru na srednie napiecie uzyteczne
% licznik: calka UPantograf_PT_nPlusJeden_ZPunktuWidzenia_PT_n*(abs(Ipantografu)*delta_t)

% Program pobiera 
% indexLokalizacji_PT_n, indexLokalizacji_PT_nPlusJeden

% Program oddaje tablice: UPantografDla_PT_nPlusJeden_RazyAbsIPantografRazyDtTablica
% postaæ
% [godzina, minuta, sekunda, dziesietnaSekundy, liczba * [lokalizacjaPojazduNaTrasie, UPantograf_PT_nPlusJeden_ZPunktuWidzenia_PT_n*(abs(IPantograf)*Dt)]]
% liczba wymieniona wyzej wynika z wymiaru RozkaldJazdyTablica

% Funkcja pobiera spadek napiecia na pantografie z punktu widzenia PT_nPlusJeden
% spadek napiecia dotyczy wszystkich pojazdow na trasie 
% znajdujacych sie miedzy PT_n a PT_nPlusJeden
% PT_n = indexLokalizacji_PT_n
% Prad w [A]
% Napiecie w [V]
% 
% 
%              UPantografDla_PT_nPlusJeden_RazyAbsIPantografRazyDtTablica
%                                      |
%                                      |
%          AbsIPantografRazyDt_Tablica |       
%                                  |   V       
%     -->     <--  -->      -->    V  <-- __  <--   -->    <--  
%     ___..._____________________________[__]_____..._________
%   __|___      __|___             /           __|___     __|___
%   | /\ |      | /\ |             \           | /\ |     | /\ |
%   |/__\|      |/__\|          [Pojazd]       |/__\|     |/__\|
%   PT_Begin     PT_n             o  o    __   PT_n+1     PT_End
%   ______________T_______________T__T___[__]____T_____________<-tor
% 

function UPantografDla_PT_nPlusJeden_RazyAbsIPantografRazyDtTablica = obliczUPantografDla_PT_nPlusJedenRazyAbsIPantografRazyDtTablica(indexLokalizacji_PT_n,indexLokalizacji_PT_nPlusJeden)
%   obliczenie absIPantografRazyDt_Tablica
%   [godzina, mituda sekunda, dziesietnaSekundy, liczba* [lokalizacjaPojazduNaTrasie,  abs(Ipantografu)*delta_t]]
    absIPantografRazyDt_Tablica = obliczAbsIPantografRazyDt_Tablica(indexLokalizacji_PT_n, indexLokalizacji_PT_nPlusJeden);   
    liczbaKolumn_RozkaldJazdyTablica=size(absIPantografRazyDt_Tablica,2);
        
    
%   obliczenie UPantograf_ZPunktuWidzenia_PT_n_Tablica
%   [godzina, minuta, sekunda, dziesietnaSekundy, liczba* [lokalizacjaPojazduNaTrasie, UPantografu_ZPunktuWidzenia_PT_n]]
%   "liczba" wiersz wyzej jest obliczana na podstawie liczby kolumn z RozkaldJazdyTablica

    drogaUPantograf_ZPunktuWidzenia_PT_nPlusJeden_Tablica = obliczTablicaDrogaUPantograf_ZPunktuWidzenia_PT_nPlusJeden(indexLokalizacji_PT_n,indexLokalizacji_PT_nPlusJeden);
                                                   
    UPantografDla_PT_nPlusJeden_RazyAbsIPantografRazyDtTablica=absIPantografRazyDt_Tablica;
    for indeksKolumy = 6:2:liczbaKolumn_RozkaldJazdyTablica
    UPantografDla_PT_nPlusJeden_RazyAbsIPantografRazyDtTablica(:,indeksKolumy)=UPantografDla_PT_nPlusJeden_RazyAbsIPantografRazyDtTablica(:,indeksKolumy).*...
                                                                      drogaUPantograf_ZPunktuWidzenia_PT_nPlusJeden_Tablica(:,indeksKolumy);
    end
end

