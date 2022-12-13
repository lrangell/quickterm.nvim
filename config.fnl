(module :quickTerm.config)
(require-macros :quickTerm.qt-macros)

(local defaults {:keymaps {:terminal {:cycle_split :C-v
                                      :normal_mode :<esc><esc>}}
                 :split :vsplit})

(fn setup [{: keymaps : split}])
