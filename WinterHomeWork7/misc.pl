%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Helpers

%isin(X,L) is true if X appears in L
isin(X,[X|_]).
isin(X,[_|T]) :- isin(X,T).

% zip(L1,L2,L3) is true if L3 is the result of interleaving L1 and L2
% e.g. zip([1,2],[3,4],[1,3,2,4])   is true
zip([],[],[]).
zip([H1|T1],[H2|T2],[H1,H2|T]) :- zip(T1,T2,T).

% assoc(L,K,V) is true if L is a list of 2-element lists and one of them is [K,V]
% e.g. assoc([[key1,value1],['a',1],[3,4]], 3, 4) is true
assoc([[X,Y]|_],X,Y).
assoc([_|T],X,Y) :- assoc(T,X,Y).

% remove_duplicates(L1,L2) is true if L2 is the result of removing all duplicate elements from L1.
% The remaining elements should be in the original order.
% e.g. remove_duplicates([1,1,2,2,3,3,4,4],[1,2,3,4]) is true
clean([],Soln,Y) :- reverse(Y,Soln).
clean([H|T],Soln,Y) :- isin(H,Y),!,clean(T,Soln,Y).
clean([H|T],Soln,Y) :- clean(T,Soln,[H|Y]).
remove_duplicates(L1,L2) :- clean(L1,L2,[]).

% union(L1,L2,L3) is true if L3 is the set union of L1 and L2.
% There should be no duplicates in L3.
% e.g. union([1,2,3],[2,3,4],[1,2,3,4]) is true
union(L1,L2,L3) :- append(L1,L2,L),remove_duplicates(L,L3).

% intersection(L1,L2,L3) is true if L3 is the set intersection of L1 and L2.
% There should be no duplicates in L3.
% e.g. intersection([1,2,3],[2,3,4],[2,3]) is true
its([],_,X,Y) :- reverse(X,Y).
its([H|T],L,X,Y) :- isin(H,L),!,its(T,L,[H|X],Y).
its([_|T],L,X,Y) :- its(T,L,X,Y).
intersection(L1,L2,L3) :- its(L1,L2,[],L3).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Problem 1: Facts

%first is the food and second is the price.

cost(carne_asada,3).
cost(lengua,2).
cost(birria,2).
cost(carnitas,2).
cost(adobado,2).
cost(al_pastor,2).
cost(guacamole,1).
cost(rice,1).
cost(beans,1).
cost(salsa,1).
cost(cheese,1).
cost(sour_cream,1).
cost(taco,1).
cost(tortilla,1).
cost(sopa,1).

%menu items, name and ingredients go into the item.

ingredients(carnitas_taco, [taco,carnitas, salsa, guacamole]).
ingredients(birria_taco, [taco,birria, salsa, guacamole]).
ingredients(al_pastor_taco, [taco,al_pastor, salsa, guacamole, cheese]).
ingredients(guacamole_taco, [taco,guacamole, salsa,sour_cream]).
ingredients(al_pastor_burrito, [tortilla,al_pastor, salsa]).
ingredients(carne_asada_burrito, [tortilla,carne_asada, guacamole, rice, beans]).
ingredients(adobado_burrito, [tortilla,adobado, guacamole, rice, beans]).
ingredients(carnitas_sopa, [sopa,carnitas, guacamole, salsa,sour_cream]).
ingredients(lengua_sopa, [sopa,lengua,beans,sour_cream]).
ingredients(combo_plate, [al_pastor, carne_asada,rice, tortilla, beans, salsa, guacamole, cheese]).
ingredients(adobado_plate, [adobado, guacamole, rice, tortilla, beans, cheese]).

%name of the store and how many employees and sells how many differents.

taqueria(el_cuervo, [ana,juan,maria],
        [carnitas_taco, combo_plate, al_pastor_taco, carne_asada_burrito]).

taqueria(la_posta,
        [victor,maria,carla], [birria_taco, adobado_burrito, carnitas_sopa, combo_plate, adobado_plate]).

taqueria(robertos, [hector,carlos,miguel],
        [adobado_plate, guacamole_taco, al_pastor_burrito, carnitas_taco, carne_asada_burrito]).

taqueria(la_milpas_quatros, [jiminez, martin, antonio, miguel],
        [lengua_sopa, adobado_plate, combo_plate]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Problem 1: Rules

%L is the list get from taqueria and check if X in L.
available_at(X,Y) :- taqueria(Y,_,L), isin(X,L).

%test case: available_at(combo_plate, el_cuervo).

%X stands the store name and Y  is not equal to Z
%bagof build in function -> return all the duplicates in the list.

multi_avaliable_h(X) :- available_at(X, Y), available_at(X, Z), Z \= Y.
multi_available(X) :- bagof(X,multi_avaliable_h(X), Dups), remove_duplicates(Dups, NoDups), isin(X, NoDups).  


%create a healper 
overworked_helper(X) :- taqueria(Y, List_1, _), isin(X, List_1), taqueria(Z, List_2, _), isin(X, List_2), Y \= Z.
overworked(X) :- bagof(X, overworked_helper(X), Dups), remove_duplicates(Dups, NoDups), isin(X, NoDups).

%take ingredients and elements of ingredients then sum them up. 

sum([], 0).
sum([H|T],C) :- sum(T, CT), cost(H, P), C is CT + P. 
total_cost(X,K) :- ingredients(X,List_1), sum(List_1,K).

%When X is the food name and List is the ingredients, union with search ingredients with real ingredients
%if Lidy true if List and L union with No Duplicates 

has_ingredients(X,L) :- ingredients(X,List), union(List, L, List).

avoids_ingredients(X,L) :- ingredients(X,List), intersection(L,List,[]).

%example
%p1 is asking to check if has_ingredients X list of [taco, guacamole]  

p1(L,X) :- bagof(Y, has_ingredients(Y,X), L).
p2(L,Y) :- bagof(Z, avoids_ingredients(Z,Y), L).
find_items(L,X,Y) :- p1(L1,X), p2(L2,Y), intersection(L1,L2,L).


link(san_diego, seattle).
link(seattle, dallas).
link(dallas,new_york).
link(new_york, chicago).
link(new_york,seattle).
link(chicago,boston).
link(boston, san_diego).


path_2(A,B) :- link(A,Z),link(Z,B).
path_3(A,B) :- link(A,Z),link(Z,Y),link(Y,B).

path_N(A,B,N) :- N is 1, link(A,B)
path_N(A,B,N) :- N > 1, M is N-1, link(A,Z), path_N(Z,B,M)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
