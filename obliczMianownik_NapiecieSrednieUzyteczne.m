% Sprawdzone ok
% Program s³u¿y do obliczenia mianownika ze wzoru na NapiecieŒrednieU¿yteczneNaPantografie
% Mianownik ten jest postaci:
% suma po wszystkich pojazdach wystepujacych na trasie pomiedzy PT_n a PT_nplusJeden ... 
% ( 1/przedzialCalowania_Tj_DlaPociaguONumerze_j ...
% 
%     przedzialCalowania_Tj_DlaPociaguONumerze_j
% *ca³ka / (Abs(IPantograf)*Dt)
%       0
% Program jest potrzebny do wzoru na srednie napiecie uzyteczne
% abs(Ipantografu)*delta_t uzupe³nine jest pomiedzy PT_n a PT_nPlusJeden

% Program pobiera 
% indexLokalizacji_PT_n, indexLokalizacji_PT_nPlusJeden

% Program oddaje tablice: wartoscMianownik_NapiecieSrednieUzyteczne
% postaæ wartosc rowna mianownikowi ze wzoru na NapiecieSrednieUzyteczne

%                         abs(Ipantografu)*delta_t
%              absIPantografRazyDt_Pomiedzy_PT_n_a_PT_nPlusJeden_Tablica
%                                |       
%        indexLokalizacji_PT_n   |      indexLokalizacji_PT_nPlusJeden
%                  |             |            |      
%                  V             |            V          
%     -->     <--  -->   __  --> V         <--  -->     <--  
%     ___...____________[__]____________________..._________
%   __|___      __|___           /          __|___     __|___
%   | /\ |      | /\ |           \          | /\ |     | /\ |
%   |/__\|      |/__\|        [Pojazd]      |/__\|     |/__\|
%   PT_Begin     PT_n           o  o        PT_n+1     PT_End
%   _______________T____[__]____T__T__________T______________<-tor
% 

function wartoscMianownik_NapiecieSrednieUzyteczne = obliczMianownik_NapiecieSrednieUzyteczne(indexLokalizacji_PT_n, indexLokalizacji_PT_nPlusJeden)

    absIPantografRazyDt_Pomiedzy_PT_n_a_PT_nPlusJeden_Tablica = obliczAbsIPantografRazyDt_Tablica(indexLokalizacji_PT_n, indexLokalizacji_PT_nPlusJeden);
    zidentyfikowanyPojazdNaTrasieMiedzyPT_n_a_PT_nPlusJedenTablica = identyfikujPojazdNaTrasieMiedzyPT_naPT_nPlusJedenTablica(indexLokalizacji_PT_n,indexLokalizacji_PT_nPlusJeden);
%     Przypadek wystepuje tylko, kiedy wykryto brak pojazdow na analizowanym odcinku trasy
    if zidentyfikowanyPojazdNaTrasieMiedzyPT_n_a_PT_nPlusJedenTablica(1,1)==0
       wartoscMianownik_NapiecieSrednieUzyteczne=0.0000000000000001;
    else
    
        liczbaWierszy_zidentyfikowanyPojazdMiedzyPTn_PTnPlusJedenTab=size(zidentyfikowanyPojazdNaTrasieMiedzyPT_n_a_PT_nPlusJedenTablica,1);
        wartoscMianownik_NapiecieSrednieUzyteczne=0;
        for numerPociagu_j=1:liczbaWierszy_zidentyfikowanyPojazdMiedzyPTn_PTnPlusJedenTab
            KolumnaWKroejZidentyfikowanoPojazd=zidentyfikowanyPojazdNaTrasieMiedzyPT_n_a_PT_nPlusJedenTablica(numerPociagu_j,2);
            indeksWierszaPojawieniaSiePojazduNaTrasie=zidentyfikowanyPojazdNaTrasieMiedzyPT_n_a_PT_nPlusJedenTablica(numerPociagu_j,3);
            indeksWierszaZniknieciaPojazduZTrasy=zidentyfikowanyPojazdNaTrasieMiedzyPT_n_a_PT_nPlusJedenTablica(numerPociagu_j,4);
            przedzialCalowania_Tj_DlaPociaguONumerze_j=zidentyfikowanyPojazdNaTrasieMiedzyPT_n_a_PT_nPlusJedenTablica(numerPociagu_j,5);
        
            Wartosc_CalkiDla_numerPociagu_j=obliczWynikWartosc_CalkiDla_numerPociagu_j(KolumnaWKroejZidentyfikowanoPojazd,...
                                                                                       indeksWierszaPojawieniaSiePojazduNaTrasie,...
                                                                                       indeksWierszaZniknieciaPojazduZTrasy,...
                                                                                       absIPantografRazyDt_Pomiedzy_PT_n_a_PT_nPlusJeden_Tablica);
                                                                               
            Wartosc_MianownikDla_numerPociagu_j=Wartosc_CalkiDla_numerPociagu_j/przedzialCalowania_Tj_DlaPociaguONumerze_j;
        
            wartoscMianownik_NapiecieSrednieUzyteczne=wartoscMianownik_NapiecieSrednieUzyteczne+Wartosc_MianownikDla_numerPociagu_j;
%           Test do sprawdzenia wynikow - sprawdzone OK
%           Wartosc_CalkiDla_numerPociagu_j_TablicaDoTest(numerPociagu_j,1)=Wartosc_CalkiDla_numerPociagu_j;
%           Wartosc_CalkiDla_numerPociagu_j_TablicaDoTest(numerPociagu_j,2)=Wartosc_MianownikDla_numerPociagu_j;
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
