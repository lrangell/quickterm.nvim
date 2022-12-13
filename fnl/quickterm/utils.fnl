(import-macros {: def : import : import-from} :quickterm.macros)
(import-from [find] :quickterm.functions)

(fn find-chan [bufn]
  (-?> (vim.api.nvim_list_chans)
       (find #(= bufn (or $.buffer nil)))
       (. :id)))

; TODO: set defaults

{: find-chan}
