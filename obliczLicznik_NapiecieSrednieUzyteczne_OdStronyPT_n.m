% Sprawdzone OK
% Program s³u¿y do obliczenia licznika ze wzoru na NapiecieŒrednieU¿yteczneNaPantografie
% Licznik ten jest postaci:
% suma po wszystkich pojazdach wystepujacych na trasie pomiedzy PT_n a PT_nplusJeden ... 
% ( 1/przedzialCalowania_Tj_DlaPociaguONumerze_j ...
% 
%     przedzialCalowania_Tj_DlaPociaguONumerze_j
% *ca³ka / (UPantograf_PT_n_ZPunktuWidzenia_PT_n*(Abs(IPantograf)*Dt))
%       0
% Program jest potrzebny do wzoru na srednie napiecie uzyteczne
% UPantograf_PT_n_ZPunktuWidzenia_PT_n, abs(Ipantografu)*delta_t uzupe³nine jest pomiedzy PT_n a PT_nPlusJeden

% Program pobiera 
% indexLokalizacji_PT_n, indexLokalizacji_PT_nPlusJeden

% Program oddaje tablice: wartoscLicznik_NapiecieSrednieUzyteczne_OdStronyPT_n
% postaæ wartosc rowna licznikowi ze wzoru na NapiecieSrednieUzyteczne

%              
%    UPantografDla_PT_n_RazyAbsIPantografRazyDtTablica
%                            |
%                            |  abs(Ipantografu)*delta_t        
%                            |  absIPantografRazyDt_Pomiedzy_PT_n_a_PT_nPlusJeden_Tablica
%     indexLokalizacji_PT_n  |   |      
%                 |          |   |       indexLokalizacji_PT_nPlusJeden
%                 |          |   |            |      
%                 V          V   |            V          
%     -->     <--  -->   __  --> V         <--  -->     <--  
%     ___...____________[__]____________________..._________
%   __|___      __|___           /          __|___     __|___
%   | /\ |      | /\ |           \          | /\ |     | /\ |
%   |/__\|      |/__\|        [Pojazd]      |/__\|     |/__\|
%   PT_Begin     PT_n           o  o        PT_n+1     PT_End
%   _______________T____[__]____T__T__________T______________<-tor
% 

function wartoscLicznik_NapiecieSrednieUzyteczne_OdStronyPT_n = obliczLicznik_NapiecieSrednieUzyteczne_OdStronyPT_n(indexLokalizacji_PT_n, indexLokalizacji_PT_nPlusJeden)

%     absIPantografRazyDt_Pomiedzy_PT_n_a_PT_nPlusJeden_Tablica = obliczAbsIPantografRazyDt_Tablica(indexLokalizacji_PT_n, indexLokalizacji_PT_nPlusJeden);
    zidentyfikowanyPojazdNaTrasieMiedzyPT_n_a_PT_nPlusJedenTablica = identyfikujPojazdNaTrasieMiedzyPT_naPT_nPlusJedenTablica(indexLokalizacji_PT_n,indexLokalizacji_PT_nPlusJeden);
    %     Przypadek wystepuje tylko, kiedy wykryto brak pojazdow na analizowanym odcinku trasy
    if zidentyfikowanyPojazdNaTrasieMiedzyPT_n_a_PT_nPlusJedenTablica(1,1)==0
       wartoscLicznik_NapiecieSrednieUzyteczne_OdStronyPT_n=0;
    else
        UPantografDla_PT_n_RazyAbsIPantografRazyDtTablica = obliczUPantografDla_PT_n_RazyAbsIPantografRazyDtTablica(indexLokalizacji_PT_n,indexLokalizacji_PT_nPlusJeden);
    
        liczbaWierszy_zidentyfikowanyPojazdMiedzyPTn_PTnPlusJedenTab=size(zidentyfikowanyPojazdNaTrasieMiedzyPT_n_a_PT_nPlusJedenTablica,1);
        wartoscLicznik_NapiecieSrednieUzyteczne_OdStronyPT_n=0;
        for numerPociagu_j=1:liczbaWierszy_zidentyfikowanyPojazdMiedzyPTn_PTnPlusJedenTab
            KolumnaWKroejZidentyfikowanoPojazd=zidentyfikowanyPojazdNaTrasieMiedzyPT_n_a_PT_nPlusJedenTablica(numerPociagu_j,2);
            indeksWierszaPojawieniaSiePojazduNaTrasie=zidentyfikowanyPojazdNaTrasieMiedzyPT_n_a_PT_nPlusJedenTablica(numerPociagu_j,3);
            indeksWierszaZniknieciaPojazduZTrasy=zidentyfikowanyPojazdNaTrasieMiedzyPT_n_a_PT_nPlusJedenTablica(numerPociagu_j,4);
            przedzialCalowania_Tj_DlaPociaguONumerze_j=zidentyfikowanyPojazdNaTrasieMiedzyPT_n_a_PT_nPlusJedenTablica(numerPociagu_j,5);
        
            Wartosc_CalkiDla_numerPociagu_j=obliczWynikWartosc_CalkiDla_numerPociagu_j(KolumnaWKroejZidentyfikowanoPojazd,...
                                                                                       indeksWierszaPojawieniaSiePojazduNaTrasie,...
                                                                                       indeksWierszaZniknieciaPojazduZTrasy,...
                                                                                       UPantografDla_PT_n_RazyAbsIPantografRazyDtTablica);
                                                                               
            Wartosc_LicznikDla_numerPociagu_j=Wartosc_CalkiDla_numerPociagu_j/przedzialCalowania_Tj_DlaPociaguONumerze_j;
        
            wartoscLicznik_NapiecieSrednieUzyteczne_OdStronyPT_n=wartoscLicznik_NapiecieSrednieUzyteczne_OdStronyPT_n+Wartosc_LicznikDla_numerPociagu_j;
%           Test do sprawdzenia wynikow - sprawdzone OK
%           Wartosc_CalkiDla_numerPociagu_j_TablicaDoTest(numerPociagu_j,1)=Wartosc_CalkiDla_numerPociagu_j;
%           Wartosc_CalkiDla_numerPociagu_j_TablicaDoTest(numerPociagu_j,2)=Wartosc_LicznikDla_numerPociagu_j;
%           save('Wartosc_CalkiDla_numerPociagu_j_TablicaDoTest.mat', 'Wartosc_CalkiDla_numerPociagu_j_TablicaDoTest');

        end
    end
end

function wynikWartosc_CalkiDla_numerPociagu_j = obliczWynikWartosc_CalkiDla_numerPociagu_j(arg_KolumnaWKroejZidentyfikowanoPojazd,...
                                                                                           arg_indeksWierszaPojawieniaSiePojazduNaTrasie,...
                                                                                           arg_indeksWierszaZniknieciaPojazduZTrasy,...
                                                                                           tablicaDoScalkowania)
                                                                                       
    wynikWartosc_CalkiDla_numerPociagu_j=0;
    for indexCalkowania=arg_indeksWierszaPojawieniaSiePojazduNaTrasie:arg_indeksWierszaZniknieciaPojazduZTrasy
        wynikWartosc_CalkiDla_numerPociagu_j=wynikWartosc_CalkiDla_numerPociagu_j+...
                                             tablicaDoScalkowania(indexCalkowania,arg_KolumnaWKroejZidentyfikowanoPojazd);    
    end
end
