function! emulator#launch()
  let l:avds = emulator#listAvds()

  for avd in l:avds
    echomsg index(l:avds, avd) . " - " . avd
  endfor

  call inputsave()
  let l:device = input('Choose your device: ')
  call inputrestore()

  let l:result = system(emulator#bin() . " -avd " . l:avds[l:device] . " &> /dev/null &")

  redraw!

  return 1
endfunction

function! emulator#listAvds()
  let l:result = systemlist(emulator#bin() . " -list-avds")

  return l:result
endfunction

function! emulator#bin()
  return android#sdkPath() . "/emulator/emulator"
endfunction
