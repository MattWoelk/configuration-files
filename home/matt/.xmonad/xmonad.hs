import XMonad

main = do
  xmonad $ defaultConfig
    { terminal  = "urxvt -bg black -fg white +sb"
    , borderWidth = 2
    , normalBorderColor   = "#111111"
    , focusedBorderColor  = "#00CC00"
    }
