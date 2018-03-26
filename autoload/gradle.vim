function! gradle#runWrapper()
  let l:result = system(gradle#bin() . " wrapper")

  return l:result
endfunction

function! gradle#runBuild()
  let l:result = system(gradle#bin() . " build")

  return l:result
endfunction

function! gradle#install(mode)
  call logger#info("Installing apk...")
  let l:result = system(gradle#bin(). " install" . gradle#capitalize(a:mode), 'testing')

  redraw!

  echomsg ""

  if matchstr(l:result, 'BUILD FAILED') != ''
    call logger#error('ERROR: Build failed while installing apk')
    return l:result
  endif

  return 1
endfunction

function! gradle#capitalize(word)
  let l:word = split(a:word, '\zs')
  let l:word[0] = toupper(l:word[0])
  return join(l:word, '')
endfunction

function! gradle#bin()
  return "./gradlew"
endfunction
