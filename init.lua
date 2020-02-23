-- buffer.margin_width_n[0] = 0 не работает почему-то

---------- KEYBOARD -----------


-- Shortcuts with non-capital russian letters
-- explanation see http://foicica.com/lists/code/201309/1152.html
--
-- non-locale symbols corresponding to russian letters
--      for юабцдефгхийклмнопярстужвьызшэщчъ (key codes 1728-1759)

local en = ".f,wltau[bqrkvyjgzhcne;dmspi'ox]"
for i = 1, string.len(en) do
  _G.keys.KEYSYMS[1727+i] = string.sub(en,i,i)
end
_G.keys.KEYSYMS[1699] = "`"  -- for ё

--print "init.lua: hi"

-- 252  -- For ncurses (Linux, Mac OSX, BSD):                                                                                                          ▒
-- 253  --   * The only Control keys recognized are 'ca'-'cz', 'c ', 'c\\', 'c]', 'c^',                                                                ▒
-- 254  --     and 'c_'.                                                                                                                               ▒
-- 255  --   * Control+Shift and Control+Meta+Shift keys are not recognized.                                                                           ▒
-- 256  --   * Modifiers for function keys F1-F12 are not recognized.                                                                                  ▒


local meta
if CURSES then 
  alt='m'
else
  alt='a'
end
print(alt)
keys['ca']=buffer.select_all
--keys['aL'] = textadept.file_types.select_lexer


-- File.
keys['cn'] = buffer.new
keys['co'] = io.open_file
keys.f3=io.open_file
keys[alt..'co'] = io.open_recent_file
keys['mo'] = io.reload_file
keys['cs'] = io.save_file
keys[alt..'cs'] = io.save_file_as
-- TODO: io.save_all_files
keys['cw'] = io.close_buffer
keys[alt..'cw'] = io.close_all_buffers
-- TODO: textadept.sessions.load
-- TODO: textadept.sessions.save
keys['cq'] = quit


-- Search.                                                                                                                                     
local m_search = textadept.menu.menubar[_L['_Search']]                                                                                         
keys['cf'] = m_search[_L['_Find']][2]                                                        
keys['cg'] = ui.find.find_next                                                                                     
--keys['cag'] = ui.find.find_prev                                                                                    
keys['cr'] = ui.find.replace                                                                            
keys[alt..'cR'] = ui.find.replace_all                                                                        
-- Find Next is an when find pane is focused in GUI.                                                                                           
-- Find Prev is ap when find pane is focused in GUI.                                                                                           
-- Replace is ar when find pane is focused in GUI.                                                                                             
-- Replace All is aa when find pane is focused in GUI.                                                                                         
keys[alt..'cf'] = ui.find.find_incremental                                                                            
if GUI then                                                                                                                                    
  keys['cF'] = m_search[_L['Find in Fi_les']][2]                                                                           
end                                                                                                                         
-- Find in Files is ai when find pane is focused in GUI.                                                                                       
if GUI then                                                                                                                                    
  keys[alt..'cg'] = m_search[_L['Goto Nex_t File Found']][2]                                                                  
  keys[alt..'cG'] = m_search[_L['Goto Previou_s File Found']][2]                                                                        
end                                                                                                                                            
keys['cj'] = textadept.editing.goto_line                                                                                   


-- Tools.
local m_tools = textadept.menu.menubar[_L['_Tools']]
keys['ce'] = m_tools[_L['Command _Entry']][2]
keys.f9 = m_tools[_L['Select Co_mmand']][2]
keys.f10=quit
keys[alt..'cr'] = textadept.run.run
keys[alt..'cc'] = textadept.run.compile
keys[alt..'cb'] = textadept.run.build
keys[alt..'ca'] = m_tools[_L['Set _Arguments...']][2]
--keys[alt..'cx'] = textadept.run.stop
--keys[not OSX and (GUI and 'cae' or 'mx')
--             or 'cme'] = m_tools[_L['_Next Error']][2]
--keys[not OSX and (GUI and 'caE' or 'mX')
--             or 'cmE'] = m_tools[_L['_Previous Error']][2]


-- View.
local m_view = textadept.menu.menubar[_L['_View']]
keys.f8 = {
    n = m_view[_L['_Next View']][2],
    p = m_view[_L['_Previous View']][2],
    s = m_view[_L['Split View _Horizontal']][2],
    v = m_view[_L['Split View _Vertical']][2],
    w = m_view[_L['_Unsplit View']][2],
    W = m_view[_L['Unsplit _All Views']][2],
    ['+'] = m_view[_L['_Grow View']][2],
    ['-'] = m_view[_L['Shrin_k View']][2]
  }
keys.f8.h = keys.f8.s
keys.f8['='] = keys.f8['+']

keys['c*'] = m_view[_L['Toggle Current _Fold']][2]
if GUI then
  keys[not OSX and 'caI' or 'cI'] = m_view[_L['Toggle Show In_dent Guides']][2]
  keys[not OSX and 'caV' or 'cV'] = m_view[_L['Toggle _Virtual Space']][2]

  --keys['c='] = buffer.zoom_in  -- в терминале почему-то хендлится терминалом
  keys['c+'] = keys['c=']
  keys['c-'] = buffer.zoom_out
  keys['c0'] = m_view[_L['_Reset Zoom']][2]
end


-- Buffer.
local m_buffer = textadept.menu.menubar[_L['_Buffer']]
keys['c\t'] = m_buffer[_L['_Next Buffer']][2]
keys.f6=keys['c\t']
keys['cs\t'] = m_buffer[_L['_Previous Buffer']][2]
keys.f7=keys['cs\t']
keys['cb'] = ui.switch_buffer
-- Indentation.
local m_indentation = m_buffer[_L['_Indentation']]
keys['c\\'] = m_buffer[_L['Toggle _Wrap Mode']][2]
if GUI then
  keys[alt..'c\n'] = m_buffer[_L['Toggle View _EOL']][2]
  keys[alt..'cs'] = m_buffer[_L['Toggle View White_space']][2]
end
keys[alt..'L'] = textadept.file_types.select_lexer

