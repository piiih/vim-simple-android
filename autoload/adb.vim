function! adb#bin()
  return android#sdkPath() . "/platform-tools/adb"
endfunction

function! adb#devices()
  let l:devices = systemlist(adb#bin() . " devices | tail -n+2 | sed -e 's/\t/,/g' | tr -d '[:space:]'")

  return l:devices
endfunction

function! adb#runApp(activity)
  let l:result = system(adb#bin() . " shell am start -n " . android#packageName() . "/." . a:activity)

  return l:result
endfunction
