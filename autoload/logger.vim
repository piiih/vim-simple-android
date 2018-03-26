function! logger#info(message)
  redraw
  echomsg a:message
endfunction

function! logger#warning(message)
  echohl warningmsg
  echomsg a:message
  echohl normal
endfunction

function! logger#error(message)
  echohl errormsg
  echomsg a:message
  echohl normal
endfunction
