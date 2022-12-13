(local m {})

(fn m.import [...]
  (icollect [_ name (ipairs [...])]
    `(local ,name (require ,(tostring name)))))

(fn m.import-from [kv mod]
  (icollect [_ name (ipairs kv)]
    `(local ,name (. (require ,(tostring mod)) ,(tostring name)))))

(fn m.def [name v]
  `(local ,name ,v))

(fn m.import-submodules [prefix ...]
  (icollect [_ name (ipairs [...])]
    `(local ,name (require ,(.. prefix "." (tostring name))))))

(fn m.merge-right [left-tbl right-tbl]
  `(vim.tbl_deep_extend :force ,left-tbl ,right-tbl))

; {: import : def : import-submodules : merge-right}

m
