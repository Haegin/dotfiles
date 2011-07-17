import XMonad

import XMonad.Actions.WindowGo

--import XMonad.Config.Gnome

import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks

import XMonad.Layout
import XMonad.Layout.Grid
import XMonad.Layout.IM
import XMonad.Layout.LayoutHints
import XMonad.Layout.NoBorders
import XMonad.Layout.PerWorkspace
import XMonad.Layout.Reflect
import XMonad.Layout.Tabbed

import XMonad.Operations

import XMonad.Prompt
import XMonad.Prompt.Shell

import XMonad.Util.Run
import XMonad.Util.Scratchpad

import Data.Bits ((.|.))
import Data.Ratio
import Graphics.X11
import System.Exit
import System.IO

import qualified XMonad.StackSet as W
import qualified Data.Map as M

main = xmonad $ myBaseConfig
	{ terminal		= "urxvt256ccd"
	, workspaces	= ["1:main", "2:web", "3:im"] ++ map show [4..9]
	, modMask		= mod4Mask
	, logHook		= ewmhDesktopsLogHook
	, layoutHook	= ewmhDesktopsLayout $ avoidStruts myLayoutHook
	, keys			= myKeys
	, manageHook	= manageDocks <+> myManageHook
	}

-- the config we are extending
--myBaseConfig = gnomeConfig
myBaseConfig = defaultConfig

-- layouts
myLayoutHook =	smartBorders $ onWorkspace "2:web" simpleTabbed $ onWorkspace "3:im" (gridIM (1%7) empathyRoster) $
				layoutHints ( tiled ) ||| layoutHints ( Mirror tiled ) ||| layoutHints ( Grid ) ||| Full
					where
						tiled = Tall nmaster delta ratio
						-- default number of windows in master pane
						nmaster = 1
						-- default proportion of screen for master pane
						ratio	= toRational (2/(1+sqrt(5)::Double)) -- golden ratio
						-- percentage of screen to increment by when resizing
						delta	= 2/100
						-- IM buddy list windows
						rosters         = [skypeRoster, pidginRoster]
						pidginRoster	= And (ClassName "Pidgin") (Role "buddy_list")
						empathyRoster	= (Role "contact_list")
						skypeRoster     = (ClassName "Skype") `And` (Not (Title "Options")) `And` (Not (Role "Chats")) `And` (Not (Role "CallWindowForm"))

-- Window rules:
-- xprop | grep WM_CLASS
-- Use the second item in the list (usually capitalised)
myManageHook = composeAll
    [ className =? "MPlayer"        --> doFloat
    , className =? "Gimp"           --> doFloat
	, className =? "Do"				--> doFloat
	, className =? "Pidgin"			--> moveToIM
	, className =? "Skype"			--> moveToIM
	, className =? "Uzbl"			--> moveToWeb
	, className =? "Wine"			--> doFloat
	, title		=? "Neverwiner Nights Client" --> doFloat
    , resource  =? "desktop_window" --> doIgnore
    , resource  =? "kdesktop"       --> doIgnore ] where
		moveToIM	= doF $ W.shift "3:im"
		moveToWeb = doF $ W.shift "2:web"


-- keybindings
myKeys conf@(XConfig {XMonad.modMask = modm}) = M.fromList $
    -- launch a terminal
    [ ((modm .|. shiftMask, xK_Return), spawn $ XMonad.terminal conf)
    -- launch the shell prompt
    , ((modm,               xK_l     ), shellPrompt defaultXPConfig)
    -- launch dmenu
    , ((modm .|. shiftMask, xK_l     ), spawn "gnome-do")
	-- open a website
	, ((modm,				xK_slash ), spawn "uzbl --uri `sh $XDG_DATA_HOME/uzbl/scripts/list-history.sh | dmenu -nb '#006363' -nf '#00CC00' -sb '#A60000' -sf '#FF7400' -p ':>'`")
	-- scratchpad terminal
	, ((modm,				xK_u	 ), raiseMaybe (runInTerm "-title scratchpad" "screen") (title =? "scratchpad"))
    -- close focused window
    , ((modm .|. shiftMask, xK_j     ), kill)
     -- Rotate through the available layout algorithms
    , ((modm,               xK_space ), sendMessage NextLayout)
    --  Reset the layouts on the current workspace to default
    , ((modm .|. shiftMask, xK_space ), setLayout $ XMonad.layoutHook conf)
    -- Resize viewed windows to the correct size
    , ((modm,               xK_b     ), refresh)
    -- Move focus to the next window
    , ((modm,               xK_Tab   ), windows W.focusDown)
    -- Move focus to the next window
    , ((modm,               xK_n     ), windows W.focusDown)
    -- Move focus to the previous window
    , ((modm,               xK_t     ), windows W.focusUp  )
    -- Move focus to the master window
    , ((modm,               xK_m     ), windows W.focusMaster  )
    -- Swap the focused window and the master window
    , ((modm,               xK_Return), windows W.swapMaster)
    -- Swap the focused window with the next window
    , ((modm .|. shiftMask, xK_n     ), windows W.swapDown  )
    -- Swap the focused window with the previous window
    , ((modm .|. shiftMask, xK_t     ), windows W.swapUp    )
    -- Shrink the master area
    , ((modm,               xK_h     ), sendMessage Shrink)
    -- Expand the master area
    , ((modm,               xK_s     ), sendMessage Expand)
    -- Push window back into tiling
    , ((modm,               xK_y     ), withFocused $ windows . W.sink)
    -- Increment the number of windows in the master area
    , ((modm              , xK_w ), sendMessage (IncMasterN 1))
    -- Deincrement the number of windows in the master area
    , ((modm              , xK_v), sendMessage (IncMasterN (-1)))
    -- toggle the status bar gap
    -- TODO, update this binding with avoidStruts , ((modm , xK_b ), sendMessage ToggleStruts)
    -- Quit xmonad
    , ((modm .|. shiftMask, xK_apostrophe     ), io (exitWith ExitSuccess))
    -- Restart xmonad
    , ((modm              , xK_apostrophe     ), restart "xmonad" True)
    ]
    ++
    --
    -- mod-[1..9], Switch to workspace N
    -- mod-shift-[1..9], Move client to workspace N
    --
    [((m .|. modm, k), windows $ f i)
        | (i, k) <- zip (XMonad.workspaces conf) [xK_1 .. xK_9]
        , (f, m) <- [(W.greedyView, 0), (W.shift, shiftMask)]]
    ++
    --
    -- mod-{w,e,r}, Switch to physical/Xinerama screens 1, 2, or 3
    -- mod-shift-{w,e,r}, Move client to screen 1, 2, or 3
    --
    [((m .|. modm, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_comma, xK_period, xK_p] [0..]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]