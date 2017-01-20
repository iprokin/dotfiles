import XMonad
import XMonad.Config.Desktop
import XMonad.Hooks.DynamicLog
import XMonad.Layout.Tabbed
import XMonad.Layout.ThreeColumns
import XMonad.Layout.Grid
import XMonad.Hooks.ManageDocks
import XMonad.Util.EZConfig
import XMonad.Actions.CycleRecentWS
import XMonad.Util.Themes
import XMonad.Layout.MultiToggle
import XMonad.Layout.MultiToggle.Instances
import XMonad.Layout.NoBorders

{-
import XMonad.Hooks.EwmhDesktops (ewmh)
import XMonad.Hooks.ManageDocks
import System.Taffybar.Hooks.PagerHints (pagerHints)
-}
--import XMonad.Layout.Groups
--import XMonad.Layout.Groups.Examples

--import XMonad.Hooks.DynamicLog
--import XMonad.Hooks.ManageDocks
--import DBus.Client
--import System.Taffybar.XMonadLog ( dbusLog )

baseConfig = desktopConfig

main = do
    statusBar myBar myPP toggleStrutsKey myConfig >>= xmonad
    --xmonad $ ewmh $ pagerHints $ myConfig
    --xmonad $ myConfig

myTerminal    = "/usr/bin/st"
myModMask     = mod4Mask -- Win key or Super_L
myModSym      = xK_Super_L  -- Win key or Super_L
myBorderWidth = 3

-- Command to launch the bar.
myBar = "xmobar"

-- Custom PP, configure it as you like. It determines what is being written to the bar.
myPP = xmobarPP { ppCurrent = xmobarColor "#429942" "" . wrap "<" ">" }

-- The available layouts.  Note that each layout is separated by |||,
-- which denotes layout choice.
myLayout = smartBorders $ avoidStruts $ mkToggle (single FULL) $
        tabbed shrinkText (theme smallClean)
    ||| tiled
    ||| Mirror tiled
    ||| Full
    ||| GridRatio (4/3)
    ||| threeCol
--    ||| spiral (4/3)
    where
         -- default tiling algorithm partitions the screen into two panes
         tiled   = Tall nmaster delta ratio
         threeCol = ThreeCol nmaster delta ratio
         -- The default number of windows in the master pane
         nmaster = 1
         -- Default proportion of screen occupied by master pane
         ratio   = 1/2
         -- Percent of screen to increment by when resizing panes
         delta   = 2/100

-- Key binding to toggle the gap for the bar.
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

-- Main configuration, override the defaults to your liking.
myConfig = baseConfig
    { terminal    = myTerminal
    , modMask     = myModMask
    , borderWidth = myBorderWidth
    , layoutHook  = myLayout
    --, manageHook  = manageDocks
    } `additionalKeysP` myAdditionalKeys

myAdditionalKeys = 
    [ ("M-f", sendMessage $ Toggle FULL)
    , ("M-p", spawn "j4-dmenu-desktop")
    , ("M-S-p", spawn "dmenu_run")
    , ("M-q", kill)
    , ("M-o", cycleRecentWS [myModSym] xK_o xK_i)
    , ("M-/", spawn "rofi -show window")
    , ("M-<F1>", spawn "~/scripts/xbright.py scr 100")
    , ("M-<F2>", spawn "~/scripts/xbright.py scr 300")
    , ("<XF86KbdBrightnessDown>", spawn "~/scripts/xbright.py kbd -10")
    , ("<XF86KbdBrightnessUp>", spawn "~/scripts/xbright.py kbd +10")
    , ("<XF86MonBrightnessDown>", spawn "~/scripts/xbright.py scr -10")
    , ("<XF86MonBrightnessUp>", spawn "~/scripts/xbright.py scr +10")
    , ("S-<XF86MonBrightnessDown>", spawn "~/scripts/xbright.py scr -100")
    , ("S-<XF86MonBrightnessUp>", spawn "~/scripts/xbright.py scr +100")
    , ("<XF86AudioRaiseVolume>", spawn "amixer sset Master 3%+")
    , ("<XF86AudioLowerVolume>", spawn "amixer sset Master 3%-")
    , ("<XF86AudioMute>",        spawn "amixer sset Master toggle")
    , ("<XF86LaunchB>", spawn "notify-send \"$(pstate-frequency -G -r)\"")
    , ("M1-<XF86LaunchB>", spawn "notify-send \"$(pstate-frequency -G -r)\"")
    , ("M-<XF86LaunchB>", spawn "notify-send \"$(sudo pstate-frequency -S -p powersave)\"")
    , ("M-M1-<XF86LaunchB>", spawn "notify-send \"$(sudo pstate-frequency -S -p balanced)\"")
    , ("M-M1-C-<XF86LaunchB>", spawn "notify-send \"$(sudo pstate-frequency -S -p performance)\"")
    ]
