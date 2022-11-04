(module :quickTerm.config)
(import-macros {: def : import : import-from} :quickTerm.macros)

(def defaults {:keymaps {:terminal {:cycle_split :C-v :normal_mode :<esc><esc>}}
               :split :vsplit})

(fn mapper [mode]
  (fn plugin-cmd [function-name])

  (fn [from to]
    (vim.api.nvim_set_keymap mode from {})))

(fn setup [{: keymaps : split}])
