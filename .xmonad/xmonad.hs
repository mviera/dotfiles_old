import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig(additionalKeys)
import System.IO

main = do
xmproc <- spawnPipe "/usr/local/bin/xmobar /home/mviera/.xmobarrc"
xmonad $ defaultConfig {
        manageHook = manageDocks <+> manageHook defaultConfig,
        layoutHook = avoidStruts  $  layoutHook defaultConfig, 
        logHook = dynamicLogWithPP $ xmobarPP
            {
            ppOutput = hPutStrLn xmproc,
            ppTitle = xmobarColor "green" "" . shorten 50
            },
        focusedBorderColor = "#339999",
        modMask = mod4Mask -- Rebind the Mod to the Windows key
        } `additionalKeys`
            [ ((mod4Mask .|. shiftMask, xK_z), spawn "xscreensaver-command -lock"),
            ((0, xK_Print), spawn "scrot")
            ]

