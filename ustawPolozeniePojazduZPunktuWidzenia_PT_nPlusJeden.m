% Program wprowadza polorzenie pojazdu z punktu widzenia 
% danej Podstacji Trakcyjnej PT_n+1
% Skrot PT oznacza Podstacja Trakcyjna
% Plik PradPodstacjiNaDanymOdcinku_I_NapiecieUzytecznept0pt1_10torów_KatowiceDoTychy_Wzorzec.xls
% Kolumny BM, BO, BQ, BS, BU .... 

function polozeniePojazduZPunktuWidzeniaPodstacjiTrakcyjnej = ustawPolozeniePojazduZPunktuWidzenia_PT_nPlusJeden(lokalizacjaPojazduNaTrasieZTablicaRozkladJazdyWzorzec, lokalizacja_PT_n, Lokalizacja_PT_nPlusJeden)
    if (lokalizacjaPojazduNaTrasieZTablicaRozkladJazdyWzorzec>=lokalizacja_PT_n) & (lokalizacjaPojazduNaTrasieZTablicaRozkladJazdyWzorzec<Lokalizacja_PT_nPlusJeden)
        polozeniePojazduZPunktuWidzeniaPodstacjiTrakcyjnej=lokalizacjaPojazduNaTrasieZTablicaRozkladJazdyWzorzec;
    else
        polozeniePojazduZPunktuWidzeniaPodstacjiTrakcyjnej=Lokalizacja_PT_nPlusJeden;
    end       
end

