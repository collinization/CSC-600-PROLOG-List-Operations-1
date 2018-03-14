m([keawa, kalani, haku, alii, kaeo, eric, shawn, wayne, steve]).
f([elizabeth, raeshell, sarah, geri, jordan, zeli]).
family([eric, raeshell, [keawa, kalani, elizabeth]]).
family([geri, wayne, [raeshell, sarah, steve]]).
family([sarah, shawn, [alii, kaeo, jordan]]).

male(X) :- m(M), member(X, M).
female(X) :- f(F), member(X, F).
father(X) :- male(X), parent(X).
father(X, Y) :- family([M, F | [Children]]), (X = M; X = F), male(X), member(Y, Children).
mother(X) :- female(X), parent(X).
mother(X, Y) :- family([M, F | [Children]]), (X = M; X = F), female(X), member(Y, Children).
parent(X) :- family([M, F | [_]]), (X = M; X = F).
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
