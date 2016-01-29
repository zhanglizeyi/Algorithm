let x = 2;;
(*val x : int = 2*)

let x = 2 + 3 - 4.0;;
(*type error since 4.0 is float and ocaml doesn't cast*)

let x = 2 + 3;;
(*val x = int = 5*)

let x = "a";;
(*var x : string = a *)

let x = (x,3);;
(* val x : string * int = (x, 3) *)

let y = ((snd x)^"b" , 2);;
(*type x  because second is not string, it is an integer*)

let y = ((fst x)^"c" , 4);;
(*val x : string * int = (ac, 4)*)

let z = if(x = y) then (snd x) else (snd y);;
(*var z : int 4     = because x not euqal y so second elt of y*)

type myrecord = {f1: int; f2:string; f3:int};;
(*type myrecord = {f1: int; f2: string; f3:int} *)


let a = {f1 = x; f2 = (fst y); f3 = z};;
(*type error due to x is string*int*)

let b = z::(snd y)::[];;
(*var b : int list = [4;4]*)


let c = (x,y,z);;
(*var c: (string*int)*(string*int)*int = ("a",3),("ac",4),4)*)

let c = (x;y;z);;
(*x and y have warning of expression should have type unit*)

let m = if(snd x) = (snd y) then b else [];;
(*var m : int list = []*)

let n = if(1>2) then["a"; "b"] else [];;
(*val n : int list []*)

let o = if(m = n)then 2 else 3;;
(*error type cant match int [] and string []*)


let a =
    let x = 20 in
    let y = 
      let x = 5 in
	x + x 
    in
      x + y
    ;;

