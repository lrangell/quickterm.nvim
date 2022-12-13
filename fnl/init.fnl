; (module :quickTerm package.seeall)
(import-macros {: def : import : import-submodules : merge-right} :macros)

; (require-macros :qt-macros)
; (import-submodules :quickTerm utils config functions)
(import utils config functions)

(def api vim.api)
(def layouts [:float :vsplit :split])
(def default-keymaps {:toggle :<space>k})

(def terminal {:split :float
               :window nil
               :new_line "\n"
               :transform (fn [text]
                            text)})

; TODO: auto move to last line
; TODO: fix vimp error
; TODO: implement cycle split function
; TODO: implement change split function
; TODO: center float and use % of screen
; TODO: start in insert mode on toggle

(fn screen-size [p]
  (let [{: width : height} (. (vim.api.nvim_list_uis) 1)
        term-width (math.floor (* width p))
        term-heigth (math.floor (* height p))]
    {:width term-width
     :height term-heigth
     :col (- (/ (- width term-width) 2) 1)
     :row (- (/ (- height term-heigth) 2) 1)}))

(fn terminal.create_window [{: bufn : split}]
  (fn open-split [v]
    (vim.cmd (.. v :split))
    (let [win (vim.api.nvim_get_current_win)]
      (vim.api.nvim_win_set_buf win bufn)
      win))

  (match split
    :float (api.nvim_open_win bufn true
                              (merge-right {:relative :editor
                                            :noautocmd true
                                            :style :minimal
                                            :border :solid}
                                           (screen-size 0.9)))
    :vsplit (open-split :v)
    :split (open-split "")))

(fn terminal.open [{: bufn : window : split : visible &as term}]
  (when (= nil window)
    (tset term :window (term:create_window))))

(fn terminal.close [{: window &as term}]
  (when (not= nil window)
    (api.nvim_win_hide window)
    (tset term :window nil)))

(fn terminal.toggle [{: visible &as term}]
  (if visible (term:close) (term:open))
  (tset term :visible (not visible)))

; TODO: fix it
(fn cycle [term]
  (let [curr-split (utils.find (fn [l]
                                 (= term.split l))
                               layouts)
        next-split (% (+ curr-split 1) #layouts)]
    (pp curr-split)
    (pp next-split)))

; TODO: warn invalid splits
; TODO: focus new window
(fn terminal.change_split [term new_split]
  (tset term :split new_split)
  (term:close)
  (term:open))

(fn keymap [term mode lhs rhs]
  (vim.keymap.set (or mode :t) lhs rhs {}))

(fn terminal.find_chan [term]
  (-> (api.nvim_list_chans)
      (utils.find (fn [c]
                    (= term.bufn (. c :buffer))))
      (. :id)
      (tset term :chan_id)))

(fn terminal.send [{: chan_id : new_line : transform &as term} text]
  (when (= chan_id nil)
    (set term.chan_id (utils.find-chan term.bufn)))
  (api.nvim_chan_send chan_id (.. (transform text) new_line)))

; TODO: clean up
(fn terminal.init [{: cmd : bufn &as term}]
  (functions.merge-inplace term {:window (term:create_window) :visible true})
  (api.nvim_buf_call term.bufn (partial vim.fn.termopen :zsh))
  (api.nvim_command :startinsert)
  (vim.fn.feedkeys (or (.. cmd "\n") ""))
  (each [lhs rhs (pairs {:<Esc> "<C-\\><C-n>"
                         :<Esc><Esc> (partial term:close)
                         :Tab "<C-\\><C-w>w"})]
    (vim.keymap.set :t lhs rhs {:buffer bufn})))

(fn create [{: cmd : keymaps : split}]
  (let [bufn (vim.api.nvim_create_buf false false)
        new-term (merge-right terminal {: bufn : cmd : split})
        all-keymaps (merge-right default-keymaps (or keymaps {}))]
    (each [method lhs (pairs all-keymaps)]
      (vim.keymap.set [:n :t] lhs
                      (fn []
                        (: new-term method))))
    (new-term:init)
    new-term))

; (create {:cmd :ls :keymaps {:toggle :<space>l}})

{: create}
