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

let rec sum l = match l with 
  |[] -> 0
  |h::t -> h + sum (t*t)
;;

let sqsum xs = 
  let f a x = a + (x*x) in
    List.fold_left f 0 xs
;;

let pipe fs = 
  let f a x = fun h -> x (a h) in
  let base = fun x -> x in
    List.fold_left f base fs
;;

let rec sepConcat sep sl = match sl with 
  | [] -> ""
  | h :: t -> 
      let f a x = a ^ sep ^ x in
      let base = h in
      let l = t in
        List.fold_left f base l
;;



sepConcat ", " ["foo", "bar", "baz"];;

let rec x l = 
  let f x = x*2 in match l with 
    |[]-> []
    |_ -> List.map f l
;;

let stringOfList f l =  "["^ sepConcat ";" (List.map f l) ^"]";;

(*****************************************************************)
(******************* 2. Big Numbers ******************************)
(*****************************************************************)

let rec clone x n = 
  if n <= 0 then []
  else x::(clone x (n-1))
;;

let rec padZero l1 l2 = 
  let diff = (List.length l1) - (List.length l2) in
  let k = clone 0 diff in 
  if diff >= 0 then k@l2 
  else k@l1 
;;

(* let rec padZero l1 l2 =
  if (List.length l1) > (List.length l2) then padZero (0::l1) l2
  else if (List.length l1) < (List.length l2) then padZero l1 (0::l2)
  else l1
;;  *)

let rec removeZero l = failwith "to be implemented"

let bigAdd l1 l2 = 
  let add (l1, l2) = 
    let f a x =  in
    let base = failwith "to be implemented" in
    let args = failwith "to be implemented" in
    let (_, res) = List.fold_left f base args in
      res
  in 
    removeZero (add (padZero l1 l2))

let rec mulByDigit i l = failwith "to be implemented"

let bigMul l1 l2 = 
  let f a x = failwith "to be implemented" in
  let base = failwith "to be implemented" in
  let args = failwith "to be implemented" in
  let (_, res) = List.fold_left f base args in
    res




