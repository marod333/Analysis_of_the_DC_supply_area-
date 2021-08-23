% Spradzone ok
% Program s³u¿y do obliczenia tablicy, w której
% wskazano:
% numerPociagu_j
% numerPociagu_j to jest j w Tj i |Ipj| ze wzoru na napiecie uzyteczne,
% KolumnaWKroejZidentyfikowanoPojazd,
% kiedy pojazd pojawi³ siê na trasie miêdzy PT_n a PT_nPlusJeden,
% kiedy pojazd znikno³ z trasy miêdzy PT_n a PT_nPlusJeden,
% Tj ze wzoru na napiêcie u¿yteczne
% Tj=(indeksWierszaZniknieciaPojazduZTrasy - indeksWierszaPojawieniaSiePojazduNaTrasie+1)*delta_t
% Tj - przedzialCalowania_Tj_DlaPociaguONumerze_j,

% delta_t - z DaneWejsioweDoObliczenPradowZasilaczy
% delta_t to krokCzasuObliczenPrzejazduTeoretycznego

% Program oddaje tablice: zidentyfikowanyPojazdNaTrasieMiedzyPT_n_a_PT_nPlusJedenTablica
% postaæ
% [numerPociagu_j, KolumnaWKroejZidentyfikowanoPojazd, indeksWierszaPojawieniaSiePojazduNaTrasie, 
% indeksWierszaZniknieciaPojazduZTrasy, przedzialCalowania_Tj_DlaPociaguONumerze_j]
% KolumnaWKroejZidentyfikowanoPojazd - to kolumna, z ktorej jest
% pobierany AbsIPantografRazyDt_Tablica lub
% obliczUPantografDla_PT_n_RazyAbsIPantografRazyDtTablica
% obliczUPantografDla_PT_nPlusJeden_RazyAbsIPantografRazyDtTablica
% w obliczeniach licznikU_SrednieUzyteczne_PT_n, mianownikU_SrednieUzyteczne_PT_n
% w obliczeniach licznikU_SrednieUzyteczne_PT_nPlusJeden, mianownikU_SrednieUzyteczne_PT_nPlusJeden


% Funkcja pobiera indexLokalizacji_PT_n, indexLokalizacji_PT_nPlusJeden
% PT_n = indexLokalizacji_PT_n
% Prad w [A]
% Napiecie w [V]
% 
%        indexLokalizacji_PT_n             indexLokalizacji_PT_nPlusJeden
%                  |                             |
%                  V                             V
%     -->     <--  -->   __   -->           <--   -->    <--  
%     ___...____________[__]______________________..._________
%   __|___      __|___             /           __|___     __|___
%   | /\ |      | /\ |             \           | /\ |     | /\ |
%   |/__\|      |/__\|          [Pojazd]       |/__\|     |/__\|
%   PT_Begin     PT_n             o  o         PT_n+1     PT_End
%   _______________T____[__]______T__T___________T_____________<-tor
% 

function zidentyfikowanyPojazdNaTrasieMiedzyPT_n_a_PT_nPlusJedenTablica = identyfikujPojazdNaTrasieMiedzyPT_naPT_nPlusJedenTablica(indexLokalizacji_PT_n,indexLokalizacji_PT_nPlusJeden)

%   pobierz delta_t
    DaneWejsioweDoObliczenPradowZasilaczy;
    clear r_przewoduJezdnego r_linkiNosnej r_parySzyn liczbaTorowNaSzlaku 
    clear U_max_wyjsciowe_podstacjiTrakcyjnej U_min_wyjsciowe_podstacjiTrakcyjnej U_n_wyjsciowe_podstacjiTrakcyjnej
    clear r_dodatkowe r_zast_szyn r_zast_przewoduJezdnego r_zast_sieciTrakcyjnej
    clear napiecieWyjsciowePodstacjiTrakcyjnejDoUPantograf
    
    absIPantografRazyDtMiedzyPTn_PTnPlusJedenTablica = obliczAbsIPantografRazyDt_Tablica(indexLokalizacji_PT_n, indexLokalizacji_PT_nPlusJeden);
    
    liczbaWierdzy_absIPantografRazyDtMiedzyPTn_PTnPlusJedenTablica=size(absIPantografRazyDtMiedzyPTn_PTnPlusJedenTablica,1);
    liczbaKolumn_absIPantografRazyDtMiedzyPTn_PTnPlusJedenTablica=size(absIPantografRazyDtMiedzyPTn_PTnPlusJedenTablica,2);
    
    numerPociagu_j=0;
%     Program identyfikuje pojazd na trasie po jego polozeniu znajdujacym
%     sie w kolumie 5 +2*liczba a¿ do liczbaKolumn_absIPantografRazyDtMiedzyPTn_PTnPlusJedenTablica
    for indexKolumny = 5:2:liczbaKolumn_absIPantografRazyDtMiedzyPTn_PTnPlusJedenTablica
        zmianaKolumny=1;
        for indexWiersza = 2:liczbaWierdzy_absIPantografRazyDtMiedzyPTn_PTnPlusJedenTablica
%           Sprawdzenie czy pojazd nie jest w trakcie przejazdu po trasie,
%           który rozpocz¹³ siê przed 24h:00m:00s:00dziesiednychSekundy (czyli z koñca rozk³adu jazdy)
%           oraz który koñczy siê po godzinie 00h:00m:00s:00dziesiednychSekundy
%           Sprawdzenie dotyczy przypadku po 00h:00m:00s:00dziesiednychSekundy
            if (absIPantografRazyDtMiedzyPTn_PTnPlusJedenTablica(1,indexKolumny) ~= 0) && zmianaKolumny==1
                numerPociagu_j=numerPociagu_j+1;
                zmianaKolumny=0;
                zidentyfikowanyPojazdNaTrasieMiedzyPT_n_a_PT_nPlusJedenTablica(numerPociagu_j,1)=numerPociagu_j;
                zidentyfikowanyPojazdNaTrasieMiedzyPT_n_a_PT_nPlusJedenTablica(numerPociagu_j,2)=indexKolumny+1;
%           identyfikuj indeksWierszaPojawieniaSiePojazduNaTrasie
                zidentyfikowanyPojazdNaTrasieMiedzyPT_n_a_PT_nPlusJedenTablica(numerPociagu_j,3)=1;            
            end
            
%           identyfikuj indeksWierszaPojawieniaSiePojazduNaTrasie
            if (absIPantografRazyDtMiedzyPTn_PTnPlusJedenTablica(indexWiersza-1,indexKolumny) == 0)&&...
               (absIPantografRazyDtMiedzyPTn_PTnPlusJedenTablica(indexWiersza,indexKolumny) ~= 0)
              
                numerPociagu_j=numerPociagu_j+1;
              
                zidentyfikowanyPojazdNaTrasieMiedzyPT_n_a_PT_nPlusJedenTablica(numerPociagu_j,1)=numerPociagu_j;
                zidentyfikowanyPojazdNaTrasieMiedzyPT_n_a_PT_nPlusJedenTablica(numerPociagu_j,2)=indexKolumny+1;
                zidentyfikowanyPojazdNaTrasieMiedzyPT_n_a_PT_nPlusJedenTablica(numerPociagu_j,3)=indexWiersza;
            
            end
            
%           identyfikuj indeksWierszaZniknieciaPojazduZTrasy
            if (absIPantografRazyDtMiedzyPTn_PTnPlusJedenTablica(indexWiersza-1,indexKolumny) ~= 0)&&...
               (absIPantografRazyDtMiedzyPTn_PTnPlusJedenTablica(indexWiersza,indexKolumny) == 0)

               zidentyfikowanyPojazdNaTrasieMiedzyPT_n_a_PT_nPlusJedenTablica(numerPociagu_j,4)=indexWiersza-1;
            end
            
        end
%           Sprawdzenie czy pojazd nie jest w trakcie przejazdu po trasie,
%           który rozpocz¹³ siê przed 24h:00m:00s:00dziesiednychSekundy (czyli z koñca rozk³adu jazdy)
%           oraz który koñczy siê po godzinie 00h:00m:00s:00dziesiednychSekundy
%           Dotyczy przypadek przed 24h:00m:00s:00dziesiednychSekundy
        if absIPantografRazyDtMiedzyPTn_PTnPlusJedenTablica(end,indexKolumny) ~= 0
           zidentyfikowanyPojazdNaTrasieMiedzyPT_n_a_PT_nPlusJedenTablica(numerPociagu_j,4)=liczbaWierdzy_absIPantografRazyDtMiedzyPTn_PTnPlusJedenTablica;
        end
    end
%   Przypadek wystepuje tylko, kiedy wykryto brak pojazdow na analizowanym odcinku trasy
    if numerPociagu_j==0
       zidentyfikowanyPojazdNaTrasieMiedzyPT_n_a_PT_nPlusJedenTablica(numerPociagu_j+1,1)=0;
       zidentyfikowanyPojazdNaTrasieMiedzyPT_n_a_PT_nPlusJedenTablica(numerPociagu_j+1,2)=NaN;
       zidentyfikowanyPojazdNaTrasieMiedzyPT_n_a_PT_nPlusJedenTablica(numerPociagu_j+1,3)=NaN;
       zidentyfikowanyPojazdNaTrasieMiedzyPT_n_a_PT_nPlusJedenTablica(numerPociagu_j+1,4)=NaN;
       zidentyfikowanyPojazdNaTrasieMiedzyPT_n_a_PT_nPlusJedenTablica(numerPociagu_j+1,5)=NaN;
    end
%   uzupelnienie delta_t, przedzialCalowania_Tj_DlaPociaguONumerze_j
    for indexWiersza =1:numerPociagu_j

%   przedzialCalowania_Tj_DlaPociaguONumerze_j
    zidentyfikowanyPojazdNaTrasieMiedzyPT_n_a_PT_nPlusJedenTablica(indexWiersza,5)=(...
...                  % indeksWierszaZniknieciaPojazduZTrasy
                     zidentyfikowanyPojazdNaTrasieMiedzyPT_n_a_PT_nPlusJedenTablica(indexWiersza,4)- ...
...                  % indeksWierszaPojawieniaSiePojazduNaTrasie
                     zidentyfikowanyPojazdNaTrasieMiedzyPT_n_a_PT_nPlusJedenTablica(indexWiersza,3)+1 ...
                     )*delta_t;
    end

    
end