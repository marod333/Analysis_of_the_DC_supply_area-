% Program wprowadza polorzenie pojazdu z punktu widzenia 
% danej Podstacji Trakcyjnej PT_n
% Skrot PT oznacza Podstacja Trakcyjna
% Plik PradPodstacjiNaDanymOdcinku_I_NapiecieUzytecznept0pt1_10torów_KatowiceDoTychy_Wzorzec.xls
% Kolumny AR, AT, AV, AX, AZ, .... 

function polozeniePojazduZPunktuWidzeniaPodstacjiTrakcyjnej = ustawPolozeniePojazduZPunktuWidzenia_PT_n(lokalizacjaPojazduNaTrasieZTablicaRozkladJazdyWzorzec, lokalizacja_PT_n, lokalizacja_PT_nPlusJeden)
    if (lokalizacjaPojazduNaTrasieZTablicaRozkladJazdyWzorzec>=lokalizacja_PT_n) & (lokalizacjaPojazduNaTrasieZTablicaRozkladJazdyWzorzec<lokalizacja_PT_nPlusJeden)
        polozeniePojazduZPunktuWidzeniaPodstacjiTrakcyjnej=lokalizacjaPojazduNaTrasieZTablicaRozkladJazdyWzorzec;
    else
        polozeniePojazduZPunktuWidzeniaPodstacjiTrakcyjnej=lokalizacja_PT_n;
    end       
end

