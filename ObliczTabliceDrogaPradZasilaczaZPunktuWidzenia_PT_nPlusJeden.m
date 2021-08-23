% Program sluzy do obliczania tablicy drogi i pradu zasilacza z punktu widzenia Podstacji Trakcyjnej - PT_nPlusJeden
% 
%                                      drogaPradZasilacza_PT_nPlusJeden_Tablica_zRozkladJazdyTablica
%                                        |
%                                        V
%     -->     <--  -->                  <--  -->     <--  
%     ___...________________________________..._________
%   __|___      __|___         /          __|___     __|___
%   | /\ |      | /\ |         \          | /\ |     | /\ |
%   |/__\|      |/__\|      [Pojazd]      |/__\|     |/__\|
%   PT_Begin     PT_n         o  o        PT_n+1     PT_End
% 
% Dane wejsciowe
% Program wymaga utworzonego rozkladu jazdy plik:
% TablicaRozkladJazdyWzorzec.mat
% W ktorym zosta³ zdefiniowany rozklad jazdy przypisany dla danego
% zasilacza
% 
% Funkcja pobiera index podstacji trakcyjnej PT_n i PT_nPlusJeden
% Funkcja oddaje tablice 
% [godzina, droga, sektunda, dziesietnaSekundy, droga, prad, droga, prad, ... ]
% z punktu widzenia PT_nPlusJeden
% Tablica nosi nazwe
% drogaPradZasilacza_PT_nPlusJeden_Tablica_zRozkladJazdyTablica

function drogaPradZasilacza_PT_nPlusJeden_Tablica_zRozkladJazdyTablica = ObliczTabliceDrogaPradZasilaczaZPunktuWidzenia_PT_nPlusJeden(indexLokalizacji_PT_n,indexLokalizacji_PT_nPlusJeden)

% clear drogaPradZasilacza_PT_nPlusJeden_Tablica_zRozkladJazdyTablica
% clear liczbaWierszy_RozkaldJazdyTablica liczbaKolumn_RozkaldJazdyTablica

% Wczytywanie danych wejsciowych
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
% Przygotowanie tablicy "drogaPradZasilacza_PT_nPlusJeden_Tablica_zRozkladJazdyTablica"
% w tej samej formie co rozklad jazdy zapisany w tablicy 
% ('plik RozkaldJazdyTablica.mat')
% Do uzupelnienia drogi i pradu zasilacza z punktu widzenia PT_n

liczbaWierszy_RozkaldJazdyTablica=size(RozkaldJazdyTablica,1);
liczbaKolumn_RozkaldJazdyTablica=size(RozkaldJazdyTablica,2);

drogaPradZasilacza_PT_nPlusJeden_Tablica_zRozkladJazdyTablica = zeros(liczbaWierszy_RozkaldJazdyTablica,liczbaKolumn_RozkaldJazdyTablica);
drogaPradZasilacza_PT_nPlusJeden_Tablica_zRozkladJazdyTablica(:,1:4) =  RozkaldJazdyTablica(:, 1:4);

    % Uzupelnienie tablicy
    % "drogaPradZasilacza_PT_nPlusJeden_Tablica_zRozkladJazdyTablica"
    % wartosciami drogi z punktu widzenia PT_n
    for indexKolumnyUzupelnianiaDrogi = 5:2:liczbaKolumn_RozkaldJazdyTablica
        for indexWierszaUzupelnianiaDrogi = 1:liczbaWierszy_RozkaldJazdyTablica
            drogaPradZasilacza_PT_nPlusJeden_Tablica_zRozkladJazdyTablica(indexWierszaUzupelnianiaDrogi,indexKolumnyUzupelnianiaDrogi)=...
                ustawPolozeniePojazduZPunktuWidzenia_PT_nPlusJeden(...
                                                                   RozkaldJazdyTablica(indexWierszaUzupelnianiaDrogi,indexKolumnyUzupelnianiaDrogi),...  
                                                                   lokalizacja_PT_n,...
                                                                   lokalizacja_PT_nPlusJeden...
                                                                   );
        end
    end

    % Uzupelnienie tablicy
    % "drogaPradZasilacza_PT_nPlusJeden_Tablica_zRozkladJazdyTablica"
    % wartosciami pradu z punktu widzenia PT_n
    for indexKolumnyUzupelnianiaPradu = 6:2:liczbaKolumn_RozkaldJazdyTablica
        for indexWierszaUzupelnianiaPradu = 1:liczbaWierszy_RozkaldJazdyTablica
            drogaPradZasilacza_PT_nPlusJeden_Tablica_zRozkladJazdyTablica(indexWierszaUzupelnianiaPradu,indexKolumnyUzupelnianiaPradu)=...
                ustawPradPojazduZPunktuWidzenia_PT_nPlusJeden(...
                                                          ...%indexKolumnyUzupelnianiaPradu-1 = lokalizacja pojazdu na trasie
                                                              RozkaldJazdyTablica(indexWierszaUzupelnianiaPradu,indexKolumnyUzupelnianiaPradu-1),...  
                                                         ... % lokalizacja_PT_n- 0.00001 
                                                         ... % bo wychodzi NaN jak trafi kilometr w podstacje     
                                                              lokalizacja_PT_n-0.00001,...
                                                         ... % lokalizacja_PT_nPlusJeden - 0.00001 
                                                         ... % bo wychodzi NaN jak trafi kilometr w podstacje
                                                              lokalizacja_PT_nPlusJeden-0.00001,...
                                                         ... % Prad pojazdu z pradPojazduZTablicaRozkladJazdyWzorzec
                                                              RozkaldJazdyTablica(indexWierszaUzupelnianiaPradu,indexKolumnyUzupelnianiaPradu),...
                                                              r_zast_sieciTrakcyjnej,...
                                                              r_zast_szyn,...
                                                              r_dodatkowe...
                                                              );
        end
    end


end
    