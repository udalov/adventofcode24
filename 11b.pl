% swipl 11b.pl -> "main(R, 75)."

add_pair([(Value, Count)], [], Value, Count) :- !.
add_pair([(Value, NewCount)|Xs], [(Value, C)|Xs], Value, Count) :-
    plus(C, Count, NewCount), !.
add_pair([X|Rest], [X|Xs], Value, Count) :-
    add_pair(Rest, Xs, Value, Count), !.

solve(A, 0, A, []) :- !.

solve(R, K, [], B) :-
    succ(KK, K),
    solve(R, KK, B, []), !.

solve(R, K, [(0, C)|Ns], B) :-
    add_pair(B1, B, 1, C),
    solve(R, K, Ns, B1), !.

solve(R, K, [(N, C)|Ns], B) :-
    number_string(N, S),
    string_length(S, L),
    divmod(L, 2, L2, 0),
    sub_string(S, 0, L2, _, S1),
    sub_string(S, _, L2, 0, S2),
    number_codes(N1, S1),
    number_codes(N2, S2),
    add_pair(B1, B, N1, C),
    add_pair(B2, B1, N2, C),
    solve(R, K, Ns, B2), !.

solve(R, K, [(N, C)|Ns], B) :-
    number_string(N, S),
    string_length(S, L),
    mod(L, 2) =:= 1,
    M is N * 2024,
    add_pair(B1, B, M, C),
    solve(R, K, Ns, B1), !.

sum_list_values(0, []) :- !.
sum_list_values(R, [(_, X)|Xs]) :-
    sum_list_values(R1, Xs),
    plus(R1, X, R), !.

solve_and_sum(R, K, A) :-
    solve(L, K, A, []),
    sum_list_values(R, L), !.

solve_list(0, [], _).
solve_list(R, [N|Ns], It) :-
    number_codes(M, N),
    solve_and_sum(R1, It, [(M, 1)]),
    solve_list(R2, Ns, It),
    plus(R1, R2, R).

main(Result, It) :-
    read_file_to_string("in", Line, []),
    normalize_space(string(Trimmed), Line),
    split_string(Trimmed, " ", "", Numbers),
    solve_list(Result, Numbers, It).
