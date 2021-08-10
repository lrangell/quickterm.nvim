(module :quickTerm.funcions package.seeall)
(local M {})

(fn M.map [f xs]
  (icollect [_ x (ipairs xs)]
    (f x)))

(fn M.table? [x]
  (= (type x) :table))

(fn M.ensure-table [key-or-table val]
  (if (M.table? key-or-table) key-or-table {key-or-table val}))

(fn M.ensure-pairs [...]
  (-> ... M.ensure-table pairs))

(fn M.string? [x]
  (= :string (type x)))

(fn M.nil? [x]
  (= nil x))

(fn M.table? [x]
  (= :table (type x)))

(fn M.run! [f xs]
  (when xs
    (let [nxs (M.count xs)]
      (when (> nxs 0)
        (for [i 1 nxs]
          (f (. xs i)))))))

(fn M.reduce [f init xs]
  (var result init)
  (M.run! (fn [x]
            (set result (f result x))) xs)
  result)

(fn M.find [t p]
  (var x nil)
  (each [_ v (ipairs t) :until (not= nil x)]
    (when (p v)
      (set x v)))
  x)

M
