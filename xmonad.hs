import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig
import System.IO

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
        ]
