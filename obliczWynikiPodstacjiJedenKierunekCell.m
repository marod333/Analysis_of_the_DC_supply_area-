% Sprawdzone OK
% Program Tworzy Cell z wynikami dla danej podstacji
% Postac cell: WynikiPodstacjiJedenKierunekCell 
% [Kierunek ruchu pojazdow, Nazwa Podstacji Trakcyjnej lub pocz¹tek/koniec opracownia,
% Lokalizacja podstacji, 
% Nazwa pradu zasilacza podstacji trakcyjnej PT_n         , PradZasilaczaPodstacjiTrakcyjnej_PT_n,
% Nazwa pradu zasilacza podstacji trakcyjnej PT_nPlusJeden, PradZasilaczaPodstacjiTrakcyjnej_PT_nPlusJeden,
% Prad podstacji trakcyjnej dla danego kierunku ruchu pojazdow,
% Nazwa napiecia na pantografie pojazdu PT_n              , NapiecieNaPantografiePojazdu_PT_n,
% Nazwa napiecia na pantografie pojazdu PT_nPlusJeden     , NapiecieNaPantografiePojazdu_PT_nPlusJEden
% Nazwa napiecia uzytecznego PT_n                         , NapiecieUzyteczne_PT_n,
% Nazwa napiecia uzytecznego PT_nPlusJeden                , NapiecieUzyteczne_PT_nPlusJeden]

%              PradZasilaczaPodstacjiTrakcyjnej_PT_nPlusJeden
%               |
%               |  PradZasilaczaPodstacjiTrakcyjnej_PT_n
%               |    | 
%               V    V  
%     -->     <--   -->                  <--  -->     <--  
%     ___...________________________________..._________
%   __|___      __|___         /          __|___     __|___
%   | /\ |      | /\ |         \          | /\ |     | /\ |
%   |/__\|      |/__\|      [Pojazd]      |/__\|     |/__\|
%   PT_Begin     PT_n         o  o        PT_n+1     PT_End
% 
%              NapiecieNaPantografiePojazdu_PT_nPlusJEden
%               |
%               |  NapiecieNaPantografiePojazdu_PT_n
%               |    | 
%               V    V  
%     -->     <--   -->                  <--  -->     <--  
%     ___...________________________________..._________
%   __|___      __|___         /          __|___     __|___
%   | /\ |      | /\ |         \          | /\ |     | /\ |
%   |/__\|      |/__\|      [Pojazd]      |/__\|     |/__\|
%   PT_Begin     PT_n         o  o        PT_n+1     PT_End
%         
%                                        
%    czasPradZasilacza_PT_n_Tablica     czasPradZasilacza_PT_nPlusJeden_Tablica
%                  |                     I 
%                  V                     V  
%     -->     <--  -->                  <--  -->     <--  
%     ___...________________________________..._________
%   __|___      __|___         /          __|___     __|___
%   | /\ |      | /\ |         \          | /\ |     | /\ |
%   |/__\|      |/__\|      [Pojazd]      |/__\|     |/__\|
%   PT_Begin     PT_n         o  o        PT_n+1     PT_End
% 
% 
% 
clear
clc

% pobranie informacji o podstacjach trakcyjnych
DaneWejsioweLokalizacjePodstacji;

% Utworzednie pustej Cell
WynikiPodstacjiJedenKierunekCell=cell(1+liczbaPodstacjiTrakcyjnych,18);
% Opis pierwszego wiersza cell: WynikiPodstacjiJedenKierunekCell
WynikiPodstacjiJedenKierunekCell(1,1)={'Kierunek ruchu pojazdow: '};
WynikiPodstacjiJedenKierunekCell(1,2)={'Nazwa podstacji trakcyjnej: '};
WynikiPodstacjiJedenKierunekCell(1,3)={'Lokalizacja podstacji trakcyjnej: '};
WynikiPodstacjiJedenKierunekCell(1,4)={'Nazwa pradu zasilacza podstacji trakcyjnej PT_n'};
WynikiPodstacjiJedenKierunekCell(1,5)={'PradZasilaczaPodstacjiTrakcyjnej_PT_n'}; %Wyniki pradu w Amperach zapisane w tablicy [godzina, mituta, sekunda, dziesietnaSekunty, PradZasilaczaPodstacjiTrakcyjnej_PT_n]
WynikiPodstacjiJedenKierunekCell(1,6)={'Nazwa pradu zasilacza podstacji trakcyjnej PT_nPlusJeden'};...
                                   %Wyniki pradu w Amperach zapisane w tablicy [godzina, mituta, sekunda, dziesietnaSekunty, PradZasilaczaPodstacjiTrakcyjnej_PT_nPlusJeden]
WynikiPodstacjiJedenKierunekCell(1,7)={'PradZasilaczaPodstacjiTrakcyjnej_PT_nPlusJeden'};
WynikiPodstacjiJedenKierunekCell(1,8)={'Prad podstacji trakcyjnej dla danego kierunku ruchu pojazdow'};...
                                   %Wyniki pradu w Amperach zapisane w tablicy [godzina, mituta, sekunda, dziesietnaSekunty, PradZasilaczaPodstacjiTrakcyjnej_PT_nPlusJeden]    
WynikiPodstacjiJedenKierunekCell(1,9)={'Nazwa napiecia na pantografie pojazdu PT_n'};
                                   %Wyniki napiecia w Voltach zapisane w tablicy [godzina, mituta, sekunda, dziesietnaSekunty, NapiecieNaPantografiePojazdu_PT_n]
WynikiPodstacjiJedenKierunekCell(1,10)={'NapiecieNaPantografiePojazdu_PT_n'};...
                                   %Wyniki napiecia w Voltach zapisane w tablicy [godzina, mituta, sekunda, dziesietnaSekunty, NapiecieNaPantografiePojazdu_PT_nPlusJEden]    
WynikiPodstacjiJedenKierunekCell(1,11)={'Nazwa napiecia na pantografie pojazdu PT_nPlusJeden'};
                                   %Wyniki napiecia w Voltach zapisane w tablicy [godzina, mituta, sekunda, dziesietnaSekunty, NapiecieNaPantografiePojazdu_PT_nPlusJEden]
WynikiPodstacjiJedenKierunekCell(1,12)={'NapiecieNaPantografiePojazdu_PT_nPlusJeden'};...
                                   % Nazwa sredniego napiecia uzytecznego na pantografie PT_n                        
WynikiPodstacjiJedenKierunekCell(1,13)={'Nazwa sredniego napiecia uzytecznego na pantografie PT_n'};
                                   % obliczMianownik_NapiecieSrednieUzyteczne z punktu widzenia PT_n                                   
WynikiPodstacjiJedenKierunekCell(1,14)={'wartosc mianownika sredniego napiecia uzytecznego PT_n na pantogafie'};...
                                   % obliczLicznik_NapiecieSrednieUzyteczne_OdStronyPT_n z punktu widzenia PT_n
WynikiPodstacjiJedenKierunekCell(1,15)={'wartosc licznika sredniego napiecia uzytecznego PT_n na pantogafie'};...
                                   %  wartoscSrednieNapiecieUzyteczne_OdStronyPT_n                                  
                                   %  wartoscLicznik_NapiecieSrednieUzyteczne_OdStronyPT_n/wartoscMianownik_NapiecieSrednieUzyteczne
WynikiPodstacjiJedenKierunekCell(1,16)={'SrednieNapiecieUzyteczneNaPantografie_PT_n'};...
                                   % Nazwa sredniego napiecia uzytecznego na pantografie PT_nPlusJeden
WynikiPodstacjiJedenKierunekCell(1,17)={'Nazwa sredniego napiecia uzytecznego na pantografie PT_nPlusJeden'};
                                   % obliczMianownik_NapiecieSrednieUzyteczneodStronyPT_nPlusJeden z punktu widzenia PT_n 
WynikiPodstacjiJedenKierunekCell(1,18)={'wartosc mianownika sredniego napiecia uzytecznego PT_n+1 na pantogafie'};...
                                  % obliczLicznik_NapiecieSrednieUzyteczne_OdStronyPT_nPlusJeden z punktu widzenia PT_n 
WynikiPodstacjiJedenKierunekCell(1,19)={'wartosc licznika sredniego napiecia uzytecznego PT_n+1 na pantogafie'};...
                                   %  wartoscSrednieNapiecieUzyteczne_OdStronyPT_nPlusJeden                                  
                                   %  wartoscLicznik_NapiecieSrednieUzyteczne_OdStronyPT_nPlusJeden/wartoscMianownik_NapiecieSrednieUzyteczne
WynikiPodstacjiJedenKierunekCell(1,20)= {'SrednieNapiecieUzyteczneNaPantografie_PT_n+1'};...                                
                                   

for indexPodstacji_PT_n=1:liczbaPodstacjiTrakcyjnych
%   Kierunek ruchu pojazdow: 
    WynikiPodstacjiJedenKierunekCell(indexPodstacji_PT_n+1,1)={['z ', kierunekTrasy{1, 2}, ' do ', kierunekTrasy{2, 2}]};
%   Nazwa podstacji trakcyjnej:   
    WynikiPodstacjiJedenKierunekCell(indexPodstacji_PT_n+1,2)={lokalizacjaPotstacjiTrakcyjnych{indexPodstacji_PT_n, 2}};
%   Lokalizacja podstacji trakcyjnej: 
    WynikiPodstacjiJedenKierunekCell(indexPodstacji_PT_n+1,3)={lokalizacjaPotstacjiTrakcyjnych{indexPodstacji_PT_n, 1}};
%   Nazwa pradu zasilacza podstacji trakcyjnej PT_n
    if indexPodstacji_PT_n<liczbaPodstacjiTrakcyjnych
        WynikiPodstacjiJedenKierunekCell(indexPodstacji_PT_n+1,4)={['Przebieg pradu zasilacza Podstacji Trakcyjnej ', lokalizacjaPotstacjiTrakcyjnych{indexPodstacji_PT_n, 2},...
                                                               ' na odcinku od ', lokalizacjaPotstacjiTrakcyjnych{indexPodstacji_PT_n, 2}, ...
                                                               ' do ', lokalizacjaPotstacjiTrakcyjnych{indexPodstacji_PT_n+1, 2}]};
%       PradZasilaczaPodstacjiTrakcyjnej_PT_n
        PradZasilaczaPodstacjiTrakcyjnej_PT_n=obliczPradZasilacza_PT_n_ZPunktuWidzenia_PT_n(indexPodstacji_PT_n,indexPodstacji_PT_n+1);
        WynikiPodstacjiJedenKierunekCell(indexPodstacji_PT_n+1,5)={PradZasilaczaPodstacjiTrakcyjnej_PT_n};
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        % Prad podstacji trakcyjnej dla danego kierunku ruchu pojazdow
        % Uzupelnienie calkowity prad podstacji trakcyjnej dla poczatku trasy PT_Begin
        if indexPodstacji_PT_n==1
            WynikiPodstacjiJedenKierunekCell(indexPodstacji_PT_n+1,8)={PradZasilaczaPodstacjiTrakcyjnej_PT_n};
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
%       Nazwa napiecia na pantografie pojazdu PT_n  
        WynikiPodstacjiJedenKierunekCell(indexPodstacji_PT_n+1,9)={['Chwilowy spadek napiecia na pantografie [V], obiekt inercyjny PT_n: ', lokalizacjaPotstacjiTrakcyjnych{indexPodstacji_PT_n, 2} ,...
                                                               '. Spadek napiecia na odcinku: x [m] >= ', lokalizacjaPotstacjiTrakcyjnych{indexPodstacji_PT_n, 2}, ' = ', num2str(lokalizacjaPotstacjiTrakcyjnych{indexPodstacji_PT_n, 1}),...
                                                               '; x [m] < ', lokalizacjaPotstacjiTrakcyjnych{indexPodstacji_PT_n+1, 2},  ' = ', num2str(lokalizacjaPotstacjiTrakcyjnych{indexPodstacji_PT_n+1, 1})]};
%       NapiecieNaPantografiePojazdu_PT_n                                             
        WynikiPodstacjiJedenKierunekCell(indexPodstacji_PT_n+1,10)={obliczUPantograf_PT_n_ZPunktuWidzenia_PT_n(indexPodstacji_PT_n,indexPodstacji_PT_n+1)};
        % Nazwa sredniego napiecia uzytecznego na pantografie PT_n 
        WynikiPodstacjiJedenKierunekCell(indexPodstacji_PT_n+1,13)={['Srednie napiecie uzyteczne na pantografie [V], obiekt inercyjny PT_n: ', lokalizacjaPotstacjiTrakcyjnych{indexPodstacji_PT_n, 2} ,...
                                                               '. Analizowany odcinek trasy: x [m] >= ', lokalizacjaPotstacjiTrakcyjnych{indexPodstacji_PT_n, 2}, ' = ', num2str(lokalizacjaPotstacjiTrakcyjnych{indexPodstacji_PT_n, 1}),...
                                                               '; x [m] < ', lokalizacjaPotstacjiTrakcyjnych{indexPodstacji_PT_n+1, 2},  ' = ', num2str(lokalizacjaPotstacjiTrakcyjnych{indexPodstacji_PT_n+1, 1})]};
%       obliczMianownik_NapiecieSrednieUzyteczne z punktu widzenia PT_n
        wartoscMianownik_NapiecieSrednieUzyteczne=obliczMianownik_NapiecieSrednieUzyteczne(indexPodstacji_PT_n,indexPodstacji_PT_n+1);
        WynikiPodstacjiJedenKierunekCell(indexPodstacji_PT_n+1,14)={wartoscMianownik_NapiecieSrednieUzyteczne};
%       obliczLicznik_NapiecieSrednieUzyteczne_OdStronyPT_n z punktu widzenia PT_n
        wartoscLicznik_NapiecieSrednieUzyteczne_OdStronyPT_n=obliczLicznik_NapiecieSrednieUzyteczne_OdStronyPT_n(indexPodstacji_PT_n,indexPodstacji_PT_n+1);
        WynikiPodstacjiJedenKierunekCell(indexPodstacji_PT_n+1,15)={wartoscLicznik_NapiecieSrednieUzyteczne_OdStronyPT_n};
%       wartoscSrednieNapiecieUzyteczne_OdStronyPT_n                                  
%       wartoscLicznik_NapiecieSrednieUzyteczne_OdStronyPT_n/wartoscMianownik_NapiecieSrednieUzyteczne
        WynikiPodstacjiJedenKierunekCell(indexPodstacji_PT_n+1,16)={wartoscLicznik_NapiecieSrednieUzyteczne_OdStronyPT_n/wartoscMianownik_NapiecieSrednieUzyteczne};
        clear wartoscLicznik_NapiecieSrednieUzyteczne_OdStronyPT_n wartoscMianownik_NapiecieSrednieUzyteczne

    end
    
    if indexPodstacji_PT_n>1
%      Nazwa pradu zasilacza podstacji trakcyjnej PT_nPlusJeden      
       WynikiPodstacjiJedenKierunekCell(indexPodstacji_PT_n+1,6)={['Przebieg pradu zasilacza Podstacji Trakcyjnej ', lokalizacjaPotstacjiTrakcyjnych{indexPodstacji_PT_n, 2},...
                                                               ' na odcinku od ', lokalizacjaPotstacjiTrakcyjnych{indexPodstacji_PT_n, 2}, ...
                                                               ' do ', lokalizacjaPotstacjiTrakcyjnych{indexPodstacji_PT_n-1, 2}]};
%      PradZasilaczaPodstacjiTrakcyjnej_PT_nPlusJeden
       PradZasilaczaPodstacjiTrakcyjnej_PT_nPlusJeden=obliczPradZasilacza_PT_nPlusJeden_ZPunktuWidzenia_PT_n(indexPodstacji_PT_n-1,indexPodstacji_PT_n);
       WynikiPodstacjiJedenKierunekCell(indexPodstacji_PT_n+1,7)={PradZasilaczaPodstacjiTrakcyjnej_PT_nPlusJeden};    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  
%     Uzupelnienie calkowity prad podstacji dla konca trasy PT_End
       if indexPodstacji_PT_n==liczbaPodstacjiTrakcyjnych
            WynikiPodstacjiJedenKierunekCell(indexPodstacji_PT_n+1,8)={PradZasilaczaPodstacjiTrakcyjnej_PT_nPlusJeden};
       end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
%      Nazwa napiecia na pantografie pojazdu PT_nPlusJeden
       WynikiPodstacjiJedenKierunekCell(indexPodstacji_PT_n+1,11)={['Chwilowy spadek napiecia na pantografie [V], obiekt inercyjny PT_n+1: ', lokalizacjaPotstacjiTrakcyjnych{indexPodstacji_PT_n, 2} ,...
                                                               '. Spadek napiecia na odcinku: x [m] >= ', lokalizacjaPotstacjiTrakcyjnych{indexPodstacji_PT_n-1, 2}, ' = ', num2str(lokalizacjaPotstacjiTrakcyjnych{indexPodstacji_PT_n-1, 1}),...
                                                               '; x [m] < ', lokalizacjaPotstacjiTrakcyjnych{indexPodstacji_PT_n, 2},  ' = ', num2str(lokalizacjaPotstacjiTrakcyjnych{indexPodstacji_PT_n, 1})]};

%      NapiecieNaPantografiePojazdu_PT_nPlusJEden
       WynikiPodstacjiJedenKierunekCell(indexPodstacji_PT_n+1,12)={obliczUPantograf_PT_nPlusJeden_ZPunktuWidzenia_PT_n(indexPodstacji_PT_n-1,indexPodstacji_PT_n)};

%      Nazwa sredniego napiecia uzytecznego na pantografie PT_nPlusJeden
       WynikiPodstacjiJedenKierunekCell(indexPodstacji_PT_n+1,17)={['Srednie napiecie uzyteczne na pantografie [V], obiekt inercyjny PT_n+1: ', lokalizacjaPotstacjiTrakcyjnych{indexPodstacji_PT_n, 2} ,...
                                                               '. Spadek napiecia na odcinku: x [m] >= ', lokalizacjaPotstacjiTrakcyjnych{indexPodstacji_PT_n-1, 2}, ' = ', num2str(lokalizacjaPotstacjiTrakcyjnych{indexPodstacji_PT_n-1, 1}),...
                                                               '; x [m] < ', lokalizacjaPotstacjiTrakcyjnych{indexPodstacji_PT_n, 2},  ' = ', num2str(lokalizacjaPotstacjiTrakcyjnych{indexPodstacji_PT_n, 1})]};    
%      obliczMianownik_NapiecieSrednieUzyteczne z punktu widzenia PT_nPlusJeden
       wartoscMianownik_NapiecieSrednieUzyteczne=obliczMianownik_NapiecieSrednieUzyteczne(indexPodstacji_PT_n-1,indexPodstacji_PT_n);
       WynikiPodstacjiJedenKierunekCell(indexPodstacji_PT_n+1,18)={wartoscMianownik_NapiecieSrednieUzyteczne};
    
%      obliczLicznik_NapiecieSrednieUzyteczne_OdStronyPT_nPlusJeden z punktu widzenia PT_n
       wartoscLicznik_NapiecieSrednieUzyteczne_OdStronyPT_nPlusJeden=obliczLicznik_NapiecieSrednieUzyteczne_OdStronyPT_nPlusJeden(indexPodstacji_PT_n-1,indexPodstacji_PT_n);
       WynikiPodstacjiJedenKierunekCell(indexPodstacji_PT_n+1,19)={wartoscLicznik_NapiecieSrednieUzyteczne_OdStronyPT_nPlusJeden};
%      wartoscSrednieNapiecieUzyteczne_OdStronyPT_nPlusJeden                                  
%      wartoscLicznik_NapiecieSrednieUzyteczne_OdStronyPT_nPlusJeden/wartoscMianownik_NapiecieSrednieUzyteczne
       WynikiPodstacjiJedenKierunekCell(indexPodstacji_PT_n+1,20)={wartoscLicznik_NapiecieSrednieUzyteczne_OdStronyPT_nPlusJeden/wartoscMianownik_NapiecieSrednieUzyteczne};
       clear wartoscLicznik_NapiecieSrednieUzyteczne_OdStronyPT_nPlusJeden wartoscMianownik_NapiecieSrednieUzyteczne
 
    end
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%   Prad podstacji trakcyjnej dla danego kierunku ruchu pojazdow
    if indexPodstacji_PT_n<liczbaPodstacjiTrakcyjnych && indexPodstacji_PT_n>1
        PradPodstacjiTrakcyjnej_PT_n=PradZasilaczaPodstacjiTrakcyjnej_PT_n;
        PradPodstacjiTrakcyjnej_PT_n(:,5)=PradPodstacjiTrakcyjnej_PT_n(:,5)+PradZasilaczaPodstacjiTrakcyjnej_PT_nPlusJeden(:,5);
        WynikiPodstacjiJedenKierunekCell(indexPodstacji_PT_n+1,8)={PradPodstacjiTrakcyjnej_PT_n};
    end
%   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
    clear PradZasilaczaPodstacjiTrakcyjnej_PT_n
    clear PradZasilaczaPodstacjiTrakcyjnej_PT_nPlusJeden
    clear PradPodstacjiTrakcyjnej_PT_n 
%   Koniec obliczen pradow podstacji sprawdzone
end

save (['WynikiPodstacjiKierunek_z_',kierunekTrasy{1, 2}, '_do_', kierunekTrasy{2, 2}],'WynikiPodstacjiJedenKierunekCell');