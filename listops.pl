m([keawa, kalani, haku, alii, kaeo, eric, shawn, wayne, steve,
   brad, caleb, kai, mark, roger, mako, keina, ben, mathew, joel,
   kainalu, tim, sam, richard, kamehameha]).
f([elizabeth, raeshell, sarah, geri, jordan, zeli, hannah, mia,
   haley, lucy, cici, kani, buni, sheryl, opau, marybeth, heather,
   chloe, paina]).
%fourth generation
family([eric, raeshell, [keawa, kalani, elizabeth]]).
family([sarah, shawn, [alii, kaeo, jordan]]).
family([steve, hannah, [haley, brad, caleb]]).
%third generation
family([geri, wayne, [raeshell, sarah, steve]]).
family([zeli, kai, [eric, mia]]).
%second generation
family([lucy, mark, [wayne, cici]]).
family([ben, sheryl, [geri, mathew, joel]]).
family([roger, kani, [zeli, buni, mako, keina]]).
family([kainalu, opau, [kai]]).
%first generation
family([tim, marybeth, [lucy]]).
family([sam, heather, [ben]]).
family([chloe, richard, [roger]]).
family([kamehameha, paina, [kainalu]]).


male(X) :- m(M), member(X, M).
female(X) :- f(F), member(X, F).

father(X) :- male(X), parent(X).
father(X, Y) :-
  family([M, F | [Children]]),
  (X = M; X = F), male(X),
  member(Y, Children).
mother(X) :- female(X), parent(X).
mother(X, Y) :-
  family([M, F | [Children]]),
  (X = M; X = F), female(X),
  member(Y, Children).
parent(X) :- family([M, F | [_]]), (X = M; X = F).
parent(X, Y) :-
  family([M, F | [Children]]),
  (X = M; X = F),
  member(Y, Children).

siblings(X, Y) :-
  family([_, _ | [Children]]),
  member(X, Children),
  member(Y, Children),
  X \= Y.
brothers(X, Y) :-
  siblings(X, Y),
  male(X),
  male(Y).
brother(X, Y) :-
  siblings(X, Y),
  male(X).
sisters(X, Y) :-
  siblings(X, Y),
  female(X),
  female(Y).
sister(X, Y) :-
  siblings(X, Y),
  female(X).

cousins(X, Y) :-
  family([M, _ | [_]]),
  parent(M, X),
  siblings(M, S),
  parent(S, Y).
cousins(X, Y) :-
  family([_, F | [_]]),
  parent(F, X),
  siblings(F, S),
  parent(S, Y).

uncle(X, Y) :-
  family([M, _ | [_]]),
  parent(M, Y),
  brother(X, M).
uncle(X, Y) :-
  family([_, F | [_]]),
  parent(F, Y),
  brother(X, F).
aunt(X, Y) :-
  family([M, _ | [_]]),
  parent(M, Y),
  sister(X, M).
aunt(X, Y) :-
  family([_, F | [_]]),
  parent(F, Y),
  sister(X, F).

grandchild(X, Y) :-
  parent(M, X),
  parent(Y, M).
grandson(X, Y) :-
  grandchild(X, Y),
  male(X).
granddaughter(X, Y) :-
  grandchild(X, Y),
  female(X).

greatgrandparent(X, Y) :-
  grandchild(Y, M),
  parent(X, M).

ancestor(X, Y) :-
  greatgrandparent(M, Y),
  parent(X, M).

show_families :- family(F), write_list(F).
write_list([X,Y | [Sub]]) :-
  write(X), nl, write(Y), nl,
  write_sublist(Sub).

write_sublist([]).
write_sublist([H|T]) :-
    write(H), nl,
    write_sublist(T).

%parent(X) :- family([H | T]), write(H), nl, write(T), nl, member1(X, H), parent(T).
% father(X, Y) :- male(X), family(Xfamily(X, _, [Y | Tail]).
