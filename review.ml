(*
review for winter ocaml 2016
*)


(*Q1*)

type expr = 
	|Const of int
	|Var of string
	|Op of string * expr * expr
;;

(* 
Op("+", Var "a", Const 4)
Op ("+", Var "a", Op ("-", Var "b", Const 4)) represents a+(b-4)
*)

let rec rename_var e v1 v2 = match e with 
	| Const i  	   -> Const i 
	| Var s 	   -> Var (if s = v1 then v2 else s) (*cast Var type of expression type*) 
	| Op (s,e1,e2) -> Op (s, rename_var(e1,v1,v2),rename_var(e2,v1,v2))
;; 


(*Q1*)

let to_str e = 
	let rec str_helper e top_level = match e with 
		| Const i 	   -> string_of_int i
		| Var s 	   -> s
		| Op (s,e1,e2) -> 
				let stringExpr = (str_helper e1 false) ^ s ^ (str_helper e2 false) in 
						if top_level then 
							stringExpr
						 else
						 	"(" ^ stringExpr ^ ")" 
		in str_helper e true
;;


(*Q2*)

let average_if f l = 
	let folding_fn (sum, count) x = 
		if f x then (sum+x, count+1)
		else (sum.count)
		in let base = (0,0) in 
		let (sum,count) = List.fold_left folding_fn base l in 
		if count = 0 then sum = 0
	else sum / count
;;


(*Q3*)

let length_2 l = 
	List.fold_left (+) 0 (List.map length l)
;;


(*Q5*)
let f1 = List.map(fun x -> 2*x);;
f1 [1;2;3;4] ;;
(*return [2;4;6;8]*)

let f2 = List.fold_left(fun acc elmt -> (elmt+2)::acc) [];;
f2 [3;5;7;9];; 
(*return [11;9;7;5]*)

let f3 = List.fold_left (fun acc y -> acc@[3*y]) [];;
f3 [1;3;6];;
(*[3;9;18]*)

let f = List.fold_left (fun acc elmtList -> elmtList acc);;
f 1 [(+) 1; (-) 2];;
(*the first will give 1+1 then 2 and fold with (-)2 then 0*)

f "abc" [(^) "zzz"; (^) "yyy"];;
(*zzzabc -> yyyzzzabc   flipover *)

 f [1;2;3] [f1;f2;f3];;
(*f [1;2;3] [List.map(fun x->2*x),List.fold_left(elmt+2)::acc,List.fold_left(acc@[3*y]) *)
(*
f1: mult everything in list by 2
f2: adds 2 and reverses
f3: mult 3 and notreverse 
*)

total [2;4;6] -> [8;6;4] -> [24;18;12]
(*each one runing one the performace *)
f1 [2;4;6]
f2 [3;4;5]->[5;4;3]
f3 [3;6;9]


(*cse101*)
(*
T(n) <= 2T(n/2) + cn^2
<= 2[2T(n/2^2) + c(n/2)^2] + cn^2
<= 2^2T(n/2^2)+ cn^2 + cn^2
<= 2^i T(n/2^i) + cn^2[1+1/2 + 1/2^2 + 1/2^3]...
T(n) <= 2^log(n) T(n/log(n)) + cn^2 [1+1/2 + 1/2^2 ... ]
n T(1) + cn^2[(1-1/2 log(n)/(1-1/2)]
nT(1) + 2cn^2(1-1/n)
nT(1) + 2cn(n-1)
*)
