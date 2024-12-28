% swipl 11a.pl -> "main(R)."

solve(1, 0, _) :- !.
solve(R, K, 0) :-
    succ(KK, K),
    solve(R, KK, 1), !.
solve(R, K, N) :-
    succ(KK, K),
    number_string(N, S),
    string_length(S, L),
    divmod(L, 2, L2, 0),
    sub_string(S, 0, L2, _, S1),
    sub_string(S, _, L2, 0, S2),
    number_codes(N1, S1),
    number_codes(N2, S2),
    solve(R1, KK, N1),
    solve(R2, KK, N2),
    plus(R1, R2, R), !.
solve(R, K, N) :-
    succ(KK, K),
    number_string(N, S),
    string_length(S, L),
    mod(L, 2) =:= 1,
    M is N * 2024,
    solve(R, KK, M), !.

solve_list(0, []).
solve_list(R, [N|Ns]) :-
    number_codes(M, N),
    solve(R1, 25, M),
    solve_list(R2, Ns),
    plus(R1, R2, R).

main(Result) :-
    read_file_to_string("in", Line, []),
    normalize_space(string(Trimmed), Line),
    split_string(Trimmed, " ", "", Numbers),
    solve_list(Result, Numbers).
