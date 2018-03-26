function! android#sdkPath()
  let g:android_sdk_path = "$HOME/Android/Sdk"

  if $ANDROID_HOME != ''
    let g:android_sdk_path = $ANDROID_HOME
  endif

  return g:android_sdk_path
endfunction

function! android#packageName()
  let l:manifest = android#manifestFile()

  let l:result = system("cat " . $PWD . "/app/src/main/AndroidManifest.xml | awk /package=/ | cut -d= -f2 | sed -e 's/[^A-Za-z\.]//g'")

  return substitute(l:result, '\n\+$', '', '')
endfunction

function! android#install(activity)
  if len(adb#devices()) <= 0
    let l:emulatorLaunched = emulator#launch()
  else
    let l:emulatorLaunched = 1
  endif

  if l:emulatorLaunched
    let l:appInstalled = gradle#install('debug')
  endif

  if l:appInstalled
    let l:result = adb#runApp(a:activity)
    echomsg l:result
  endif
endfunction

function! android#emulator()
  call emulator#launch()
endfunction

function! android#setUpCommands()
  command! -nargs=1 Android call android#install(<f-args>)
  command! AndroidEmulator call android#emulator()
endfunction
