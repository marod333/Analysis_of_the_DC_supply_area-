% Lokalizacja podstacji
% skrot PT oznacza Podstacja trakcyjna
%     -->     <--  -->                  <--  -->     <--  
%     ___...________________________________..._________
%   __|___      __|___         /          __|___     __|___
%   | /\ |      | /\ |         \          | /\ |     | /\ |
%   |/__\|      |/__\|      [Pojazd]      |/__\|     |/__\|
%   PT_Begin     PT_n         o  o        PT_n+1     PT_End
%    I                                                  I
%    V                                                  V
%  metr poczatku opracowania                         metr konca opracowania
%  lub                                               lub
%  metr lokalizacji pierwszej podstacji              metr lokalizacji pierwszej podstacji
%  przed metr poczatku opracowania                   za metr konca opracowania

clear lokalizacjaPotstacjiTrakcyjnych liczbaPodstacjiTrakcyjnych

% Zmienna lokalizacjaPotstacjiTrakcyjnych typ cell
% kolumna 1: Lokalizacjapodstacji w metrach
% kolumna 2: Nazwa podstacji
% kierunekTrasy w [m]
% przyklad:
% kierunekTrasy={80368,      'PT_Begin';... %Lokalizacja poczatku opracowania lub PT_Begin - lokalizacji podstacji przed podstacj¹ oznaczon¹ jako pierwsza w zakresie opracowania'
%                83370,      'PT_End' };    %Lokalizacja koñca opracowania lub PT_End - lokalizacja podstacji po podstacji oznaczonej jako ostatnia w zakresie opracowania
           
kierunekTrasy={80368,      'PT_Begin';... %Lokalizacja poczatku opracowania lub PT_Begin - lokalizacji podstacji przed podstacj¹ oznaczon¹ jako pierwsza w zakresie opracowania'
               83370,      'PT_End'};    %Lokalizacja koñca opracowania lub PT_End - lokalizacja podstacji po podstacji oznaczonej jako ostatnia w zakresie opracowania

% w kierunekTrasy{1,1},      kierunekTrasy{1,2}
% lub
% kierunekTrasy{2,1},      kierunekTrasy{2,2}
% Mozna wpisac lokalizacje podstacji trakcyjnych, ktore sa przed i za metrem
% obliczanego opracowania wtedy nie zmieniamy cell-ki kierunekTrasy
%%%%% Uwaga lokalizacje podstacji nie moga byc mniejsze od 0 !!!!!
% lokalizacjaPotstacjiTrakcyjnych w [m]
lokalizacjaPotstacjiTrakcyjnych = {...
%  Przyklad
%                      1,    'PT Katowice';     
%                   7900,      'PT Ligota'
                   kierunekTrasy{1,1},      kierunekTrasy{1,2} %Lokalizacja poczatku opracowania lub PT_Begin - lokalizacji podstacji przed podstacj¹ oznaczon¹ jako pierwsza w zakresie opracowania'
                   80370,     'PT 1';
                   82370,     'PT 2';
                   kierunekTrasy{2,1},      kierunekTrasy{2,2}  %Lokalizacja koñca opracowania lub PT_End - lokalizacja podstacji po podstacji oznaczonej jako ostatnia w zakresie opracowania 
};      
  
liczbaPodstacjiTrakcyjnych = size(lokalizacjaPotstacjiTrakcyjnych,1);
