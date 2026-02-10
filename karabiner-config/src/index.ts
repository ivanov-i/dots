import { FromAndToKeyCode, map, rule, toInputSource, writeToProfile } from 'karabiner.ts'
import { HrmKeyboardLayout, hrm, holdTapLayer, qwertyLayout } from 'karabiner.ts-greg-mods'

const profileName = process.env.KARABINER_PROFILE ?? 'Default profile'

const hrmLayoutNoCaps = new HrmKeyboardLayout(
  qwertyLayout.leftHandKeys.filter((key) => key !== 'caps_lock'),
  qwertyLayout.rightHandKeys,
)

const homeRowMods = hrm(
  new Map([
    ['a', 'l⇧'],
    ['s', 'l⌥'],
    ['d', 'l⌃'],
    ['f', 'l⌘'],
    ['j', 'r⌘'],
    ['k', 'r⌃'],
    ['l', 'r⌥'],
    [';', 'r⇧'],
  ]),
  hrmLayoutNoCaps,
)
  .lazy(true)
  .holdTapStrategy('permissive-hold')
  .chordalHold(true)
  .simultaneousThreshold(90)
  .tappingTerm(120)
  .build()

const spaceLayerEchoKeys: FromAndToKeyCode[] = [
  '`',
  '1',
  '2',
  '3',
  '4',
  '5',
  '6',
  '7',
  '8',
  '9',
  '0',
  'hyphen',
  'equal_sign',
  'tab',
  'q',
  'w',
  'e',
  'r',
  't',
  'y',
  'i',
  'p',
  'open_bracket',
  'close_bracket',
  'backslash',
  'z',
  'semicolon',
  'quote',
  'period',
  'slash',
  'return_or_enter',
  'delete_or_backspace',
]

const spaceLayer = holdTapLayer('spacebar')
  .description('Space layer')
  .allowAnyModifiers()
  .tappingTerm(130)
  .holdOnOtherKeyPressManipulators([
    map('a').to('l⇧'),
    map('h', [], 'any').to('←'),
    map('j', [], 'any').to('↓'),
    map('k', [], 'any').to('↑'),
    map('l', [], 'any').to('→'),
  ])
  .permissiveHoldManipulators(
    map('s').to('s', 'l⌥'),
    map('d').to('⎋'),
    map('f').to('⏎'),
    map('g').to('⏎', '⇧'),
    map('u').to('u'),
    map('o').to('o'),
    map('x').to('open_bracket', '⇧'),
    map('c').to('open_bracket'),
    map('v').to('9', '⇧'),
    map('b').to('␣'),
    map('n').to('0', '⇧'),
    map('m').to('close_bracket'),
    map(',').to('close_bracket', '⇧'),
  )
  .echoKeys(...spaceLayerEchoKeys)
  .build()

const inputSourceOnCommandTap = rule('Input source on command tap').manipulators([
  map('l⌘')
    .to('l⌘')
    .toIfAlone([
      toInputSource({ input_source_id: 'com.apple.keylayout.ABC' }),
      toInputSource({ language: 'en' }),
    ]),
  map('r⌘')
    .to('r⌘')
    .toIfAlone([
      toInputSource({ input_source_id: 'com.apple.keylayout.Russian' }),
      toInputSource({ language: 'ru' }),
    ]),
])

writeToProfile(profileName, [
  inputSourceOnCommandTap,
  spaceLayer,
  { description: 'Home row mods', manipulators: homeRowMods },
])
