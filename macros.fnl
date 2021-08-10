; (module :quickTerm.macros package.seeall)
; (local funcions (require :quickTerm.funcions))
; (fn table? [x]
;   (= (type x) :table))
;
; (fn ensure-table [key-or-table val]
;   (if (table? key-or-table) key-or-table {key-or-table val}))
;
; (fn ensure-pairs [...]
;   (-> ... ensure-table pairs))
;
(fn import [...]
  (icollect [_ name (ipairs [...])]
    `(local ,name (require ,(tostring name)))))

;
(fn import-from [kv mod]
  (icollect [_ name (ipairs kv)]
    `(local ,name (. (require ,(tostring mod)) ,(tostring name)))))

;
(fn def [name v]
  `(local ,name ,v))

(fn setm [tbl kvs]
  (icollect [k v (pairs kvs)]
    `(tset ,tbl ,k ,v)))

;
; (fn full-mapper [mode prefix maps]
;   `(do
;      ,(unpack (icollect [lhs rhs (pairs maps)]
;                 `(vim.keymap.set ,mode ,(.. (or prefix "") lhs) ,rhs)))))
;
; (fn mapper [mode prefix]
;   (fn [maps]
;     (full-mapper mode prefix maps)))
;
(fn import-submodules [prefix ...]
  (icollect [_ name (ipairs [...])]
    `(local ,name (require ,(.. prefix "." (tostring name))))))

;
; ; (fn nmap [maps] (full-mapper :n "" maps))
;

{: import : import-from : def : import-submodules : setm}
