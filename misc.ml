(* CSE 130: Programming Assignment 3
 * misc.ml
 *)

(* For this assignment, you may use the following library functions:

   List.map
   List.fold_left
   List.fold_right
   List.split
   List.combine
   List.length
   List.append
   List.rev

   See http://caml.inria.fr/pub/docs/manual-ocaml/libref/List.html for
   documentation.
*)

(* Do not change the skeleton code! The point of this assignment is to figure
 * out how the functions can be written this way (using fold). You may only
 * replace the   failwith "to be implemented"   part. *)


(*****************************************************************)
(******************* 1. Warm Up   ********************************)
(*****************************************************************)


let sqsum xs = 
  let f a x = x*x + a in  (*function gives operation*)
  let base = 0 in  (*base case equal zero*)
    List.fold_left f base xs (*from left  f 0 []*)
;;
let _ = sqsum [];;
let _ = sqsum [1;2;3;4];;
let _ = sqsum [(-1); (-2); (-3); (-4)];;


let pipe fs = 
  let f a x = fun helper -> x (a helper) in
  let base = fun x -> x in
    List.fold_left f base fs
;;

pipe [] 3;;
pipe [(fun x-> 2*x);(fun x -> x + 3)] 3;;
pipe [(fun x -> x + 3);(fun x-> 2*x)] 3;;

(*Take two inputs with one string and one array list and return a string
  run list from head to tail concast each element in array list *)
let rec sepConcat sep sl = match sl with 
  | [] -> ""
  | h :: t -> 
      let f a x = a ^ sep ^ x in  (*from first string and concat sep then concat next*)
      let base =  h in (*head*)
      let l =  t in (*call tail*)
        List.fold_left f base l
;;

sepConcat ", " ["foo";"bar";"baz"];;
sepConcat "---" [];;
sepConcat "" ["a";"b";"c";"d";"e"];;
sepConcat "X" ["hello"];;


(*list.map that map f from head to tail and build f head; f next ...; f tail*)
let stringOfList f l = "[" ^ (sepConcat "; " (List.map f l)) ^ "]";;

let _ = stringOfList string_of_int [1;2;3;4;5;6];;
let _ = stringOfList (fun x -> x) ["foo"];;
let _ = stringOfList (stringOfList string_of_int) [[1;2;3];[4;5];[6];[]];;

(*****************************************************************)
(******************* 2. Big Numbers ******************************)
(*****************************************************************)

let rec clone x n = 
    if n > 0 then x::(clone x (n-1)) (*return empty list (base) if condition not correct*)
    else [] (* x cons recusive function *)
;;

let _ = clone 3 5;;
let _ = clone "foo" 2;; 
let _ = clone clone (-3);;

let padZero l1 l2 = 
  if (List.length l1) < (List.length l2) then 
    let x = abs(List.length l2 - List.length l1) in 
      let helper = clone 0 x in 
      (helper @ l1, l2)

  else if(List.length l2) < (List.length l1) then
    let y = abs(List.length l1 - List.length l2) in 
    let helper1 = clone 0 y in 
    (l1, helper1 @ l2)

  else (l1,l2)
;;

let _ = padZero [9;9] [1;0;0;2];;
let _ = padZero [1;0;0;2] [9;9];;  

let rec removeZero l = match l with 
  |[]   -> []
  |h::t -> if h = 0 then removeZero t
            else l
;;

removeZero [0;0;0;1;0;0;2];;
removeZero [9;9];;
removeZero [0;0;0;0];;
 
let bigAdd l1 l2 = 
  let add (l1, l2) = 
    let f a x = 
      let (x1,x2)   = x in
      let (contain, result) = a in
      let sum       = x1 + x2 + contain in
      let store     = sum / 10 in
      let remainder = sum mod 10 in
      let holder    = remainder::result in 
        if (List.length holder = List.length l1) then (0, store::holder)
        else (store, holder) in
    let base = (0,[]) in
    let args = List.rev(List.combine l1 l2) in
    let (_, res) = List.fold_left f base args in
      res
  in 
    removeZero (add (padZero l1 l2))
;;

bigAdd [9;9] [1;0;0;2];;
bigAdd [9;9;9;9] [9;9;9];;

let rec mulByDigit i l = 
  if(i < 0 || i > 9) then []
  else 
    let mul i l = 
      let base = (0,[]) in 
        let f a x = 
          let (contain,result) = a in 
          let product = (x * i) + contain in 
          let store = product / 10 in 
          let remainder = product mod 10 in 
          let holder = remainder::result in 
            if   (List.length holder = List.length l) then (0,store::holder)
            else (store,holder) in 
          let (_,res) = List.fold_left f base (List.rev l) in 
                res in 
                removeZero(mul i l )
;;

mulByDigit 9 [9;9;9;9];;

let bigMul l1 l2 = 
  let f a x =
    let (x_1,x_2) = x in 
    let product = mulByDigit x_2 x_1 in 
    let (contain,result) = a in 
    let mylist = clone 0 contain in 
    let sum = bigAdd result (product @ mylist) in 
        (contain + 1, sum) in 
    let base = (0,[]) in
    let args = 
    let(myl1,myl2) = padZero l1 l2 in
        List.rev(List.combine (clone myl1 (List.length myl2)) myl2) in
    let (_, res) = List.fold_left f base args in
        res
;;

let _ = bigMul [9;9;9;9] [9;9;9;9]
let _ = bigMul [9;9;9;9;9] [9;9;9;9;9] 


