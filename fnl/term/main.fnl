(module term.main )
(tset package.loaded "term.main" nil)
                   

(local api vim.api)
(local terminals {})
(defn init [])

(def tlist {})

; TODO: use vsplit term://top
(defn create-window [kind bufn]
  (fn split [v] (vim.cmd (.. v :split)) 
    (let [win (vim.api.nvim_get_current_win)] (vim.api.nvim_win_set_buf win bufn) win))
  
  (match kind :float (api.nvim_open_win bufn false 
                                    {:relative :editor
                                     :width 60
                                     :height 10
                                     :row 80 :col 0
                                     :style :minimal
                                    
                                    })
              :vsplit (split :v)
              :split (split "")))
  



(defn open-terminal [{: buffer : window : split &as term}]
 (when (= nil window) 
           (let [new-win (create-window split term.buffer)]
             (tset term :window new-win))))

(defn close-term [{: window &as term}] 
    (when (not= nil window) 
           (api.nvim_win_close window true)
           (tset term :window nil)))


(defn toggle [{: window &as term}]
   (if (= nil window) (term:open) (term:close)))


(defn change-split [{: open : close &as term} new-split]
  (tset term :split new-split)
  (close) (open))

(defn keymap [{: buffer} lhs rhs]
  (api.nvim_buf_set_keymap buffer "t" lhs rhs {}))

(defn setk [{: name &as term}]
  (print (.. "lua require'term.main'.tlist." name ".change-split('float')"))
  (: term :keymap "<Esc>" "<C-\\><C-n>")
  (: term :keymap "<C-v>" (.. "lua require'term.main'.terminals." name ".change-split('float')"))
  ; (keymap "kj" "<C-\\><C-n>")
  ; (keymap "<Tab>" "<C-\\><C-w>w")
  )

(defn create-term [name] 
  (let [bufn (vim.api.nvim_create_buf false false)]
  (tset terminals name {:name name :split :vsplit :window nil :buffer bufn})
  (open-terminal (. terminals name))
  (vim.cmd "term"))
  (tset (. terminals name) :toggle toggle )
  (tset (. terminals name) :open open-terminal)
  (tset (. terminals name) :close close-term)
  (tset (. terminals name) :keymap keymap)
  (tset (. terminals name) :change_split change-split)
  (setk (. terminals name))
  )




; (. terminals :t)
; (create-term :chu)

; (print (vim.inspect tlist))
; (vim.api.nvim_win_close 1027 {})
; (vim.api.nvim_open_win 1026 {})
; :nvim_chan_send
; nvim_list_chans()


; ((. (require :config.utils) :nmap) :<space>l #((: (. terminals :cahu) :toggle)))
(vim.cmd "nmap <space>l :lua require\'term.main\'.create(\'za\')<CR>")
((. (require :config.utils) :nmap) :<space>p #(print (vim.inspect (. (require :term.main) :terminals))))


; TODO: fix esc in insert mode
; TODO: fix vimp error
; TODO: implement cycle split function
; TODO: implement change split function


{:create create-term :terminals terminals}
