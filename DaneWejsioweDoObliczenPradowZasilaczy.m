clear r_przewoduJezdnego r_linkiNosnej r_parySzyn liczbaTorowNaSzlaku 
clear U_max_wyjsciowe_podstacjiTrakcyjnej U_min_wyjsciowe_podstacjiTrakcyjnej U_n_wyjsciowe_podstacjiTrakcyjnej
clear r_dodatkowe r_zast_szyn r_zast_przewoduJezdnego r_zast_sieciTrakcyjnej
clear napiecieWyjsciowePodstacjiTrakcyjnejDoUPantograf delta_t
clc

% krokCzasuObliczenPrzejazduTeoretycznego
% Krok konieczny do obliczen UsrednieUzyteczne
% to jest dt we wzorze w na calke w liczniku i mianowniku
delta_t=0.1;

% Dane do obliczen pradow zasilaczy oraz spadkow napiec na pantografie
% rezystywnosc przewodu jezdnego [Ohm/km]
% r przewód jezdny:
% Cu100	0.183	Ohm/km
% CuAg100	0.183	Ohm/km
% CuAg150	0.122	Ohm/km

r_przewoduJezdnego = 0.122; %[ohm/km]

% rezystywnosc linki nosnej [Ohm/km]
% przyklad = 0.1237; [Ohm/km] - Linka o przekroju 150 mm2
% L150: œrednica d = 15,82 mm?, rezystancja 1 km w temperaturze 20?C: R = 0.1237 ?, masa 1 m: 1,345 kg
% L120: œrednica d = 14 m?, rezystancja 1 km w temperaturze 20?C: R = 0.1570 ?, masa 1 m: 1,060 kg,
% L95: œrednica d = 12,60 mm?, rezystancja 1 km w temperaturze 20?C: R = 0.1938 ?, masa 1 m: 0,859 kg.

r_linkiNosnej = 0.1237; % [Ohm/km]

% rezystywnosc szyn [Ohm/km]
% przyklad S60 2 szyny - pary szyn = 0.011,
% ksi¹¿ka system zasilania trakcji elektrycznej pr¹du sta³ego
% Mierzejswski Szl¹g Ga³uszewski str 52
r_parySzyn = 0.011; % [Ohm/km]

% liczba torow na szlaku - liczba par szyn
% przyklad:
% 1 tor - 2 szyny = 1 para
% 2 tory - 4 szyny = 2 pary
liczbaTorowNaSzlaku=2;

% napiecie wyjsciowe podstacji trakcyjnej [V]
% to jest maksymalne napiecie na zaciskach pantografu
% bez poboru pradu przez pojazd
U_max_wyjsciowe_podstacjiTrakcyjnej=3300; % [V]

% minimalne napiecie wyjsciowe podstacji trakcyjnej [V]
% to jest minimalne napiecie na zaciskach pantografu
% bez poboru pradu przez pojazd
U_min_wyjsciowe_podstacjiTrakcyjnej=2900; % [V]

% znamionowe napiecie wyjsciowe podstacji trakcyjnej [V]
% to jest znamionowe napiecie na zaciskach pantografu
% bez poboru pradu przez pojazd
U_n_wyjsciowe_podstacjiTrakcyjnej=3000; % [V]

% Napiecie zasilania podstacji trakcyjnej do Upantograf
napiecieWyjsciowePodstacjiTrakcyjnejDoUPantograf=U_max_wyjsciowe_podstacjiTrakcyjnej;

% wartosc oporu dodatkowego wynikajaca z faktu
% istnienia oporu przed podstacja trakcyjna
% domyslna wartosc r_dodatkowe [Ohm/km];
% patrz plik excel komorka H8 - rdjp+szynys60
r_dodatkowe=0;

% rezystywnoœæ zastêpcza szyn wynikajaca z liczby torow na szlaku
r_zast_szyn = r_parySzyn/liczbaTorowNaSzlaku;

% rezystywnosc zastepcza przewodu jezdnego [Ohm/km]
% rownolegle polaczenie dwoch linej nosnych
r_zast_przewoduJezdnego = (r_przewoduJezdnego*r_przewoduJezdnego)/(r_przewoduJezdnego+r_przewoduJezdnego);

% rezystywnosc zastepcza sieci trakcyjnej
% rownolegle polaczenie
% rezystywnosc zastepcza przewodu jezdnego [Ohm/km]
% i
% rezystywnosc linki nosnej [Ohm/km]
r_zast_sieciTrakcyjnej = (r_zast_przewoduJezdnego*r_linkiNosnej)/(r_zast_przewoduJezdnego+r_linkiNosnej);

