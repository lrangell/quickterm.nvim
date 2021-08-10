(module :quickTerm.utils package.seeall)
(import-macros {: def : import : import-from} :quickTerm.macros)

(import-from [find] :quickTerm.functions)

(fn find-chan [bufn]
  (-?> (vim.api.nvim_list_chans)
       (find #(= bufn (or $.buffer nil))) ; TODO: dont use fn
       (. :id)))

; TODO: set defaults
; (fn setup [])

{: find-chan}
