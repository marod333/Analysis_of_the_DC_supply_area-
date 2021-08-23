% Program wprowadza prad pojazdu z punktu widzenia 
% danej Podstacji Trakcyjnej PT_n
% Skrot PT oznacza Podstacja Trakcyjna
% Plik PradPodstacjiNaDanymOdcinku_I_NapiecieUzytecznept0pt1_10torów_KatowiceDoTychy_Wzorzec.xls
% Kolumny BN, BP, BR, BT, BV.... 

function pradPojazduZPunktuWidzeniaPodstacjiTrakcyjnej = ustawPradPojazduZPunktuWidzenia_PT_nPlusJeden(lokalizacjaPojazduNaTrasieZTablicaRozkladJazdyWzorzec, lokalizacja_PT_n, Lokalizacja_PT_nPlusJeden, pradPojazduZTablicaRozkladJazdyWzorzec,arg_r_zast_sieciTrakcyjnej, arg_r_zast_szyn, arg_r_dodatkowe)
%     arg_r_zast_sieciTrakcyjnej, arg_r_zast_szyn, arg_r_dodatkowe pochodz¹
%     JEDNOSTKA [Ohm/km]
%     z pliku DaneWejsioweDoObliczenPradowZasilaczy

%    zmiana jednostki z Ohm/km na Ohm/m w arg_r_zast_sieciTrakcyjnej, arg_r_zast_szyn, arg_r_dodatkowe 
%    1 1/(1 [km]) = 1/(1000 [m])=1/1000 [1/m]
arg_r_zast_sieciTrakcyjnej=arg_r_zast_sieciTrakcyjnej/1000; %[ohm/m]
arg_r_zast_szyn=arg_r_zast_szyn/1000; %[ohm/m]
arg_r_dodatkowe=arg_r_dodatkowe/1000; %[ohm/m]

    if (lokalizacjaPojazduNaTrasieZTablicaRozkladJazdyWzorzec>=lokalizacja_PT_n) & (lokalizacjaPojazduNaTrasieZTablicaRozkladJazdyWzorzec<Lokalizacja_PT_nPlusJeden)
        
        Licznik_pradPojazduZPunktuWidzeniaPodstacjiTrakcyjnej=pradPojazduZTablicaRozkladJazdyWzorzec/((arg_r_zast_sieciTrakcyjnej+arg_r_zast_szyn+arg_r_dodatkowe)*(Lokalizacja_PT_nPlusJeden-lokalizacjaPojazduNaTrasieZTablicaRozkladJazdyWzorzec));
        
        Mianownik_pradPojazduZPunktuWidzeniaPodstacjiTrakcyjnej=...
            (...
            1/...
            ((arg_r_zast_sieciTrakcyjnej+arg_r_zast_szyn+arg_r_dodatkowe)*(lokalizacjaPojazduNaTrasieZTablicaRozkladJazdyWzorzec-lokalizacja_PT_n))...
            )...
           +(...
            1/...
            ((arg_r_zast_sieciTrakcyjnej+arg_r_zast_szyn+arg_r_dodatkowe)*(Lokalizacja_PT_nPlusJeden-lokalizacjaPojazduNaTrasieZTablicaRozkladJazdyWzorzec))...
            );
        pradPojazduZPunktuWidzeniaPodstacjiTrakcyjnej=Licznik_pradPojazduZPunktuWidzeniaPodstacjiTrakcyjnej/Mianownik_pradPojazduZPunktuWidzeniaPodstacjiTrakcyjnej;          
    else
        pradPojazduZPunktuWidzeniaPodstacjiTrakcyjnej=0;
    end
end

