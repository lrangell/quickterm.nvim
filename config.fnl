(module term.config)


(def defaults {:keymaps {:terminal {:cycle_split "C-v" :normal_mode "<esc><esc>"}}
               :split "vsplit"})

(fn mapper [mode] 
  (fn plugin-cmd [function-name] )
  (fn [from to] (vim.api.nvim_set_keymap mode from {} )))

(defn setup [{: keymaps : split}])
