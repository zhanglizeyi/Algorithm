(* CSE 130: Programming Assignment 2
 * misc.ml
 *)

(* ***** DOCUMENT ALL FUNCTIONS YOU WRITE OR COMPLETE ***** *)

let rec assoc (d,k,l) = match l with 
  |[] -> d
  |(a,b)::t -> if k = a then b 
               else assoc(d,k,t)
;;    


let remove l n = match l with 
  |[]   -> false 
  |_ -> List.mem n l
;;

(* fill in the code wherever it says : failwith "to be written" *)
let removeDuplicates l = 
  let rec helper (seen,rest) = 
      match rest with 
        [] -> seen
      | h::t -> 
        let seen' = if List.mem h seen = false then h::seen else seen in
        let rest' = t in 
	  helper (seen',rest') 
  in
      List.rev (helper ([],l))
;;



let f x = let xx = x*x*x in (xx,xx<100);
(* Small hint: see how ffor is implemented below *)

let rec wwhile (f,b) = 
  let helper = (f b) in match helper with 
    |(b,c) -> if c = false then b
              else wwhile(f,b)
;;

let rec wh (f,b) = 
    let helper = (f b) in match helper with
      |(b, boolean) -> if boolean = false then b 
                      else wh(f,b)
;;

(* fill in the code wherever it says : failwith "to be written" *)
let fixpoint (f,b) = wwhile ((),b)


let fix(f,b) = wh((fun x -> let b = (f x) in (b, b != x)),b);;


(* ffor: int * int * (int -> unit) -> unit
   Applies the function f to all the integers between low and high
   inclusive; the results get thrown away.
 *)

let rec ffor (low,high,f) = 
  if low>high 
  then () 
  else let _ = f low in ffor (low+1,high,f)
      
(************** Add Testing Code Here ***************)



















