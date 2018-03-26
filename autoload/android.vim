function! android#getSdkPath()
  echomsg $ANDROID_HOME

endfunction

command! Android call android#getSdkPath()
