(module :quickTerm.utils package.seeall)
; (import-macros {: def : import : import-from} :quickTerm.macros)
(require-macros :config.macros)

(import-from [find] :quickTerm.functions)

(fn find-chan [bufn]
  (-?> (vim.api.nvim_list_chans)
       (find #(= bufn (or $.buffer nil)))
       (. :id)))

; TODO: set defaults

{: find-chan}
