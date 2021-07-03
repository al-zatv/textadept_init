-- buffer.margin_width_n[0] = 0 не работает почему-то

---------- KEYBOARD -----------


-- Shortcuts with non-capital russian letters
-- explanation see http://foicica.com/lists/code/201309/1152.html
--
-- non-locale symbols corresponding to russian letters
--      for юабцдефгхийклмнопярстужвьызшэщчъ (key codes 1728-1759)

--cyr...
--local en = ".f,wltau[bqrkvyjgzhcne;dmspi'ox]"
--for i = 1, string.len(en) do
--  _G.keys.KEYSYMS[1727+i] = string.sub(en,i,i)
--end
--_G.keys.KEYSYMS[1699] = "`"  -- for ё

--print "init.lua: hi"

-- 252  -- For ncurses (Linux, Mac OSX, BSD):                                                                                                          ▒
-- 253  --   * The only Control keys recognized are 'ca'-'cz', 'c ', 'c\\', 'c]', 'c^',                                                                ▒
-- 254  --     and 'c_'.                                                                                                                               ▒
-- 255  --   * Control+Shift and Control+Meta+Shift keys are not recognized.                                                                           ▒
-- 256  --   * Modifiers for function keys F1-F12 are not recognized.                                                                                  ▒


local meta
if CURSES then 
  alt='meta+'
else
  alt='alt+'
end
print(alt)
keys['ctrl+a']=buffer.select_all
--keys['aL'] = textadept.file_types.select_lexer


-- File.
keys['ctrl+n'] = buffer.new
keys['ctrl+o'] = io.open_file
keys.f3=io.open_file
--keys[alt..'+ctrl+o'] = io.open_recent_file

keys[alt..'o'] = buffer.reload
keys['ctrl+s'] = buffer.save -- io.save_file
keys.f2 = buffer.save
keys[alt..'ctrl+s'] = buffer.save_as
-- TODO: io.save_all_files
keys['ctrl+w'] = buffer.close
keys[alt..'ctrl+w'] = io.close_all_buffers
-- TODO: textadept.sessions.load
-- TODO: textadept.sessions.save
keys['ctrl+q'] = quit


-- Search.
local m_search = textadept.menu.menubar[_L['Search']]
keys['ctrl+f'] = m_search[_L['Find']][2]
keys.f7 = keys['ctrl+f']
keys['ctrl+g'] = ui.find.find_next                                                                                     
keys[alt..'ctrl+g'] = ui.find.find_prev                                                                                    

--keys['ctrl+r'] = m_search[_L['Replace']][2]
keys['ctrl+r'] = ui.find.replace
--keys.f4 = keys['ctrl+r']
keys[alt..'ctrl+R'] = ui.find.replace_all                                                                        
-- Find Next is an when find pane is focused in GUI.                                                                                           
-- Find Prev is ap when find pane is focused in GUI.                                                                                           
-- Replace is ar when find pane is focused in GUI.                                                                                             
-- Replace All is aa when find pane is focused in GUI.                                                                                         
keys[alt..'ctrl+f'] = ui.find.find_incremental                                                                            
if GUI then                                                                                                                                    
  keys['ctrl+F'] = m_search[_L['Find in Files']][2]                                                                           
end                                                                                                                         
-- Find in Files is ai when find pane is focused in GUI.                                                                                       
if GUI then                                                                                                                                    
  keys[alt..'ctrl+g'] = m_search[_L['Goto Next File Found']][2]                                                                  
  keys[alt..'ctrl+G'] = m_search[_L['Goto Previous File Found']][2]                                                                        
end                                                                                                                                            
keys['ctrl+j'] = textadept.editing.goto_line                                                                                   


-- Tools.
local m_tools = textadept.menu.menubar[_L['Tools']]
keys['ctrl+e'] = m_tools[_L['Command Entry']][2]
keys.f9 = m_tools[_L['Select Command']][2]
keys.f10=quit
keys[alt..'ctrl+r'] = textadept.run.run
keys[alt..'ctrl+c'] = textadept.run.compile
keys[alt..'ctrl+b'] = textadept.run.build
keys[alt..'ctrl+a'] = m_tools[_L['Set Arguments...']][2]
--keys[alt..'cx'] = textadept.run.stop
--keys[not OSX and (GUI and 'cae' or 'mx')
--             or 'cme'] = m_tools[_L['Next Error']][2]
--keys[not OSX and (GUI and 'caE' or 'mX')
--             or 'cmE'] = m_tools[_L['Previous Error']][2]


-- View.
local m_view = textadept.menu.menubar[_L['View']]
keys.f8 = {
    n = m_view[_L['Next View']][2],
    p = m_view[_L['Previous View']][2],
    s = m_view[_L['Split View Horizontal']][2],
    v = m_view[_L['Split View Vertical']][2],
    w = m_view[_L['Unsplit View']][2],
    W = m_view[_L['Unsplit All Views']][2],
    ['+'] = m_view[_L['Grow View']][2],
    ['-'] = m_view[_L['Shrink View']][2]
  }
keys.f8.h = keys.f8.s
keys.f8['='] = keys.f8['+']

keys['ctrl+*'] = m_view[_L['Toggle Current Fold']][2]
if GUI then
  keys[not OSX and alt..'ctrl+I' or 'ctrl+I'] = m_view[_L['Toggle Show Indent Guides']][2]
  keys[not OSX and alt..'ctrl+V' or 'ctrl+V'] = m_view[_L['Toggle Virtual Space']][2]

  --keys['c='] = buffer.zoom_in  -- в терминале почему-то хендлится терминалом
  keys['ctrl++'] = keys['ctrl+=']
  keys['ctrl+-'] = buffer.zoom_out
  keys['ctrl+0'] = m_view[_L['Reset Zoom']][2]
end


-- Buffer.
local m_buffer = textadept.menu.menubar[_L['Buffer']]
keys.f6 = m_buffer[_L['Next Buffer']][2]
keys.f5 = m_buffer[_L['Previous Buffer']][2]
--keys['ctrl+\t'] = keys.f6
--keys['ctrl+shift+\t'] = m_buffer[_L['Previous Buffer']][2]
keys['ctrl+b'] = ui.switch_buffer
-- Indentation.
local m_indentation = m_buffer[_L['Indentation']]
keys['ctrl+\\'] = m_buffer[_L['Toggle Wrap Mode']][2]
if GUI then
  keys[alt..'ctrl+\n'] = m_buffer[_L['Toggle View _EOL']][2]
  keys[alt..'ctrl+s'] = m_buffer[_L['Toggle View Whitespace']][2]
end
keys[alt..'L'] = textadept.file_types.select_lexer

