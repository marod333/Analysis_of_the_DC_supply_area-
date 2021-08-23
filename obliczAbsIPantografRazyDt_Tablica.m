% Sprawdzone ok
% Program s³u¿y do obliczenia tablicy: absIPantografRazyDt_Pomiedzy_PT_n_a_PT_nPlusJeden_Tablica
% Program jest potrzebny do wzoru na srednie napiecie uzyteczne
% mianownik: calka (abs(Ipantografu)*delta_t)
% abs(Ipantografu)*delta_t uzupe³nine jest pomiedzy PT_n a PT_nPlusJeden

% Program pobiera 
% indexLokalizacji_PT_n, indexLokalizacji_PT_nPlusJeden, delta_t

% Program oddaje tablice: absIPantografRazyDt_Pomiedzy_PT_n_a_PT_nPlusJeden_Tablica
% postaæ
% [godzina, minuta, sekunda, dziesietnaSekundy, liczba*[lokalizacjaPojazduNaTrasiePomiedzy_PT_n_a_PT_nPlusJeden, abs(Ipantografu)*delta_t]
% liczba wymieniona wyzej wynika z wymiaru RozkaldJazdyTablica

%                         abs(Ipantografu)*delta_t
%              absIPantografRazyDt_Pomiedzy_PT_n_a_PT_nPlusJeden_Tablica
%                                |            
%                                |          
%     -->     <--  -->   __  --> V           <--  -->     <--  
%     ___...____________[__]____________________..._________
%   __|___      __|___           /          __|___     __|___
%   | /\ |      | /\ |           \          | /\ |     | /\ |
%   |/__\|      |/__\|        [Pojazd]      |/__\|     |/__\|
%   PT_Begin     PT_n           o  o        PT_n+1     PT_End
%   ________________T___[__]____T__T___________T_____________<-tor
% 

function absIPantografRazyDt_Pomiedzy_PT_n_a_PT_nPlusJeden_Tablica = obliczAbsIPantografRazyDt_Tablica(indexLokalizacji_PT_n, indexLokalizacji_PT_nPlusJeden)

clc
DaneWejsioweDoObliczenPradowZasilaczy;
DaneWejsioweLokalizacjePodstacji;
load('RozkaldJazdyTablica.mat');
% lokalizacjaPotstacjiTrakcyjnych(numer_podstacji,1)
% przyklad
% lokalizacja_PT_n=lokalizacjaPotstacjiTrakcyjnych(2,1);
lokalizacja_PT_n=lokalizacjaPotstacjiTrakcyjnych(indexLokalizacji_PT_n,1);
lokalizacja_PT_n=cell2mat(lokalizacja_PT_n);
% lokalizacja_PT_nPlusJeden=lokalizacjaPotstacjiTrakcyjnych(numer_podstacji,1); 
% przyklad
% lokalizacja_PT_nPlusJeden=lokalizacjaPotstacjiTrakcyjnych(3,1);
lokalizacja_PT_nPlusJeden=lokalizacjaPotstacjiTrakcyjnych(indexLokalizacji_PT_nPlusJeden,1);
lokalizacja_PT_nPlusJeden=cell2mat(lokalizacja_PT_nPlusJeden);
% Przygotowanie tablicy "drogaPradZasilacza_PT_n_Tablica_zRozkladJazdyTablica"
% w tej samej formie co rozklad jazdy zapisany w tablicy 
% ('plik RozkaldJazdyTablica.mat')
% Do uzupelnienia drogi i pradu zasilacza z punktu widzenia PT_n

liczbaWierszy_RozkaldJazdyTablica=size(RozkaldJazdyTablica,1);
liczbaKolumn_RozkaldJazdyTablica=size(RozkaldJazdyTablica,2);

absIPantografRazyDt_Pomiedzy_PT_n_a_PT_nPlusJeden_Tablica = zeros(liczbaWierszy_RozkaldJazdyTablica,liczbaKolumn_RozkaldJazdyTablica);
absIPantografRazyDt_Pomiedzy_PT_n_a_PT_nPlusJeden_Tablica(:,1:4) =  RozkaldJazdyTablica(:, 1:4);
    
    for indeksKolumy = 5:2:(liczbaKolumn_RozkaldJazdyTablica-1)
        for indeksWiersza = 1:liczbaWierszy_RozkaldJazdyTablica
%             ustawienie lokalizacjaPojazduNaTrasiePomiedzy_PT_n_a_PT_nPlusJeden
            lokalizacjaPojazduNaTrasieZ_RozkaldJazdyTablica=RozkaldJazdyTablica(indeksWiersza,indeksKolumy);
            absIPantografRazyDt_Pomiedzy_PT_n_a_PT_nPlusJeden_Tablica(indeksWiersza,indeksKolumy) = ...
                ustawlokalizacjaPojazduNaTrasiePomiedzy_PT_n_a_PT_nPlusJeden(lokalizacjaPojazduNaTrasieZ_RozkaldJazdyTablica,...
                                                                             lokalizacja_PT_n,...
                                                                             lokalizacja_PT_nPlusJeden);
%            ustawienie pradu pobieranego w lokalilzacji: lokalizacjaPojazduNaTrasiePomiedzy_PT_n_a_PT_nPlusJeden
           if absIPantografRazyDt_Pomiedzy_PT_n_a_PT_nPlusJeden_Tablica(indeksWiersza,indeksKolumy)~=0
              absIPantografRazyDt_Pomiedzy_PT_n_a_PT_nPlusJeden_Tablica(indeksWiersza,indeksKolumy+1)=abs(RozkaldJazdyTablica(indeksWiersza,indeksKolumy+1))...
                                                                                                      *delta_t;
           end
        end
        %     absIPantografRazyDt_Tablica(:,indeksKolumy)=abs(absIPantografRazyDt_Tablica(:,indeksKolumy))*delta_t;
    end
end

function lokalizacjaPojazduNaTrasiePomiedzy_PT_n_a_PT_nPlusJeden = ustawlokalizacjaPojazduNaTrasiePomiedzy_PT_n_a_PT_nPlusJeden(lokalizacjaPojazduNaTrasieZ_RozkaldJazdyTablica,...
                                                                                                                                lokalizacja_PT_n,...
                                                                                                                                lokalizacja_PT_nPlusJeden)
    if (lokalizacjaPojazduNaTrasieZ_RozkaldJazdyTablica>=lokalizacja_PT_n) && (lokalizacjaPojazduNaTrasieZ_RozkaldJazdyTablica<lokalizacja_PT_nPlusJeden)
        lokalizacjaPojazduNaTrasiePomiedzy_PT_n_a_PT_nPlusJeden=lokalizacjaPojazduNaTrasieZ_RozkaldJazdyTablica;
    else
        lokalizacjaPojazduNaTrasiePomiedzy_PT_n_a_PT_nPlusJeden=0;
    end
end
