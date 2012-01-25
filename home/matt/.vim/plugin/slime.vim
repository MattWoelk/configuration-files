
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function Send_to_Screen(text)
  if !exists("g:screen_sessionname") || !exists("g:screen_windowname")
    call Screen_Vars()
  end

  echo system("screen -S " . g:screen_sessionname . " -p " . g:screen_windowname . " -X stuff '" . substitute(a:text, "'", "'\\\\''", 'g') . "'")
endfunction

function Screen_Session_Names(A,L,P)
  return system("screen -ls | awk '/Attached/ {print $1}'")
endfunction

function Screen_Vars()
  if !exists("g:screen_sessionname") || !exists("g:screen_windowname")
    let g:screen_sessionname = ""
    let g:screen_windowname = "0"
  end

  let g:screen_sessionname = input("session name: ", "", "custom,Screen_Session_Names")
  let g:screen_windowname = input("window name: ", g:screen_windowname)
endfunction

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

vmap <C-c><C-c> "ry :call Send_to_Screen(@r)<CR>
nmap <C-c><C-c> vip<C-c><C-c>

nmap <C-c>v :call Screen_Vars()<CR>


" (from: http://technotales.wordpress.com/2007/10/03/like-slime-for-vim/)

"UPDATE:The new version of slime.vim. The previous version is still available.
"
"I started reading Practical Common Lisp yesterday. No discussion about Lisp can be complete without talking about Slime. Slime basically turns Emacs into an IDE for Lisp development. Peter Seibel thinks this is important enough to dedicate the second chapter to it. He even repackaged Lisp + Emacs + Slime as Lispbox to help people get started faster. For an excellent book (so far), available for free, and Lispbox, thank you Mr.Seibel.
"
"After actually downloading, installing, and running Lispbox, I can see the advantages. Slime solves the problems you would have with any interactive REPL-type environment.
"
"Let’s take Ruby’s irb as an example more people are going to relate to:
"
"    you start irb
"    you start a text editor (vim, textmate, emacs, …)
"    you do a few tests in irb
"    you copy and paste to a text editor
"    you clean things up in the text editor
"    you copy and paste back to irb
"    you make a mistake
"    you fix things up in the text editor
"    you hesitate copying and pasting, because it’s painful now
"    you write some tests
"    you exit irb and run the tests to do your experiments
"
"Let me present the dilemma another way: irb is great to get answers quick but it is also temporary because you know nothing you do in irb will be saved. However, the moment you start living in a text editor, you give up a lot of the power of REPL. Or, at least, your REPL becomes 10 seconds instead of 1 second. That changes the way you work. And that explains why Slime exists.
"
"Slime creates a new interactive session with Lisp and you are able to copy and paste text from a text buffer to the session with one keyboard shortcut. That’s great! Now you can type, organize, pretty-print your code in a text editor, type C-c C-c to “refresh” the interactive session. This does not close and create a new session, the function definitions are reloaded into the current session. So, all your testing objects, those carefully crafted lists and hashes of objects (or whatnots) still exist—the world just changed around them.
"
"Yeah, Slime is great. I’m just not an Emacs fan.
"
"I did some research and Vim has no mode to support asynchronous sessions like Emacs. In essence, all that’s needed is a software that will spawn what you really want to run, say irb, control stdin/stdout/stderr, capture its own stdin/stdout/stderr and tunnel those to the child process. Also, it would be nice if it could open a port to receive external commands to be able to script stdin…
"
"That’s when I remembered an article I read about scripting gnu-screen. To make a long story short, screen does everything we want, and more.
"
"Here’s what we want to accomplish:
"
"    start a named screen
"    name the screen window
"    start irb
"    start another terminal
"    start vim
"    define a function/class/object
"    have it “transported” to irb
"
"Here are the instructions:
"
"    screen -S session01
"    C-a A—window01
"    irb
"
"    vim
"    (type code)
"    vip (select paragraph)
"    “ry (copy to register r)
"    :call system(“screen -S session01 -p window01 -X stuff ’” . @r . ”’”)
"
"And BLAM, you just did some magic!
"
"At this point, you are coming to 2 realizations:
"
"    this is WAY cool
"    you want this automated
"
"Thankfully, I can help with the automation. Get slime.vim and put it in ~/.vim/plugin/ .
"
"A few notes:
"
"    the magic key is C-c C-c (like Slime, surprise!)
"    the first time, you’ll be prompted for the “session name” and the “window name”
"    subsequent times will be automated
"    you can reprompt for “session name” and “window name” with C-c v
"    by default, C-c C-c will select the current paragraph and copy-paste it
"    but you can make your own selection first, and send it over with C-c C-c
"
"…
"
"As a final note, I’d like to drive the point that this can automate ANYTHING running in a screen:
"
"    bash
"    top
"    irb
"    python
"    any lisp/scheme REPL
"    mysql
"    …
"
"One thing is for sure, this will definitely change the way I work.
"
"(For extra points, write your own Textmate plugin … this hack is not limited to Vim!!)
