import XMonad

main = do
  xmonad $ defaultConfig
    { terminal  = "urxvt"
    , borderWidth = 2
    , normalBorderColor   = "#000000"
    , focusedBorderColor  = "#00CC00"
    }
