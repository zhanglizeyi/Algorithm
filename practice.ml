(*CSE130 practice*)

let rec last l = 
	match l with 
	| [ ] -> failwith "no element"
	| x::[ ] -> x
	| _::t -> last t  
;;

last ["a"; "b"; "c"; "d"];;


(*find the particular one*)
 let rec last_two l = 
 	match l with
 	| [] -> failwith "no element"
 	| [_] -> failwith "not enough element"
    | [a;x;y] -> (a,x,y)
    | _::t -> last_two t
;;

let at n l = 
	match l with 
	| [] -> failwith "no elt"
	| l -> List.nth l n
;;

let rec at n l = 
	match l with 
	| [] -> failwith "not enough elt"
	| h::t -> if n = 0 then h else at (n-1) t
;;

let rec countList l = 
	match l with 
	|[] -> 0
	| _ -> List.length l
;;


let length list = 
	let rec count n = function 
	|[] -> n
	|_::t -> count(n+1) t in count 0 list
;;

let reverse list = 
	match list with 
	|[] -> []
	| _::t -> List.rev list
;;






