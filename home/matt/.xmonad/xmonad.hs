import XMonad
import XMonad.Hooks.ManageDocks
import XMonad.Layout.NoBorders
import XMonad.Layout.Accordion

mylayoutHook = (avoidStruts $ Tall 1 (3/100) (488/792)) ||| noBorders (Full)

main = do
  xmonad $ defaultConfig
    { terminal  = "urxvt -bg black -fg white +sb"
    , borderWidth = 2
    , normalBorderColor   = "#080808"
    , focusedBorderColor  = "#00CC00"
--    , layoutHook=avoidStruts $ mylayoutHook
    , layoutHook=mylayoutHook
    , manageHook=manageDocks <+> manageHook defaultConfig
    }
