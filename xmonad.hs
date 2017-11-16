import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig
import System.IO
import XMonad.Actions.CycleWS

main = do
    xmproc <- spawnPipe "xmobar"

    xmonad $ defaultConfig
        { modMask = mod4Mask
        , manageHook = manageDocks <+> manageHook defaultConfig
        , layoutHook = avoidStruts $ layoutHook defaultConfig
        -- Keep Xmobar visible.
        , handleEventHook = handleEventHook defaultConfig <+> docksEventHook
        , logHook = dynamicLogWithPP xmobarPP
            { ppOutput = hPutStrLn xmproc
            , ppTitle = xmobarColor "green" "".shorten 50
            }
        } `additionalKeysP`
        [ ("<XF86AudioLowerVolume>", spawn "pulseaudio-ctl down 10")
        , ("<XF86AudioRaiseVolume>", spawn "pulseaudio-ctl up 10")
        , ("<XF86AudioMute>", spawn "pulseaudio-ctl mute")
        , ("<XF86AudioMicMute>", spawn "pulseaudio-ctl mute-input")
        -- These ones are from my Ubuntu set-up.
        --, ("<XF86AudioLowerVolume>", spawn "amixer -D pulse sset Master 5%-")
        --, ("<XF86AudioRaiseVolume>", spawn "amixer -D pulse sset Master 5%+")
        --, ("<XF86AudioMute>", spawn "amixer -D pulse set Master 1+ toggle")
        --, ("<XF86MonBrightnessDown>", spawn "xbacklight -dec 10")
        --, ("<XF86MonBrightnessUp>", spawn "xbacklight -inc 10")
        , ("M-<Tab>", moveTo Next NonEmptyWS)
        , ("M-S-<Tab>", moveTo Prev NonEmptyWS)
        ]
