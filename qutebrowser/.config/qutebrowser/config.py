# import subprocess
"""Heiko's qutebrowser settings."""
import os

from qutebrowser.api import interceptor

c = c  # noqa: PLW0127, F821  # pyright: ignore[reportUndefinedVariable]
config = config  # noqa: PLW0127, F821  # pyright: ignore[reportUndefinedVariable]


def filter_yt(info: interceptor.Request):
    """Block the given request if necessary."""
    url = info.request_url
    if url.host() == 'www.youtube.com' and url.path() == '/get_video_info' and '&adformat=' in url.query():
        info.block()
    # if url.host() == 'www.youtube.com':
    #     info.block()


interceptor.register(filter_yt)

config.bind('<y><o>', 'yank inline [[{url}][{title}]]')
notecmd = (
    'yank inline [[{url}][{title}]];; spawn '
    + os.environ['TERMINAL']
    + ' -e '
    + os.environ['EDITOR']
    + ' -c \'call CreateCapture("e" , "qutebrowser")\''
)
config.bind('gn', notecmd)
config.bind('V', 'hint links spawn ' + os.environ['BROWSER'] + ' "{hint-url}"')
config.bind('v', 'hint links spawn funnel "{hint-url}"')
config.bind('\\', 'spawn dmenuhandler "{url}"')
config.bind(',v', 'spawn umpv {url}')
config.bind(',V', 'hint links spawn umpv {hint-url}')
config.bind(';V', 'hint links --rapid spawn umpv {hint-url}')
# Awesome way to open vim from qutebrowser
c.editor.command = [
    os.environ['TERMINAL'],
    '-e',
    os.environ['EDITOR'],
    '-f',
    '{file}',
    '-c',
    'normal {line}G{column0}1',
]
# config.bind("<Ctrl-h>", "fake-key <Backspace>", "insert")
# config.bind("<Ctrl-a>", "fake-key <Home>", "insert")
# config.bind("<Ctrl-e>", "fake-key <End>", "insert")
# config.bind("<Ctrl-b>", "fake-key <Left>", "insert")
# config.bind("<Mod1-b>", "fake-key <Ctrl-Left>", "insert")
# config.bind("<Ctrl-f>", "fake-key <Right>", "insert")
# config.bind("<Mod1-f>", "fake-key <Ctrl-Right>", "insert")
config.bind('<Ctrl-p>', 'fake-key <Up>', 'insert')
config.bind('<Ctrl-n>', 'fake-key <Down>', 'insert')
# config.bind("<Mod1-d>", "fake-key <Ctrl-Delete>", "insert")
# config.bind("<Ctrl-d>", "fake-key <Delete>", "insert")
# config.bind("<Ctrl-w>", "fake-key <Ctrl-Backspace>", "insert")
config.bind('<Ctrl-u>', 'fake-key <Shift-Home><Delete>', 'insert')
config.bind('<Ctrl-k>', 'fake-key <Shift-End><Delete>', 'insert')
config.bind('<Ctrl-x><Ctrl-e>', 'open-editor', 'insert')
config.bind('<Ctrl-+>', 'zoom-in')
config.bind('<Ctrl-->', 'zoom-out')
config.bind('<Ctrl-e>', 'edit-text', 'insert')

# user scripts
config.bind(';t', 'hint userscript link translate')
config.bind(';T', 'hint userscript all translate --text')
config.bind('<Ctrl+T>', 'spawn --userscript translate')
config.bind('<Ctrl+Shift+T>', 'spawn --userscript translate --text')
config.bind(',u', 'hint links spawn -u untrack-url -O {hint-url}')
config.bind(',U', 'spawn -u untrack-url -p {clipboard}')
config.bind('X', 'hint links userscript add-nextcloud-bookmarks')
config.bind('X', 'spawn --userscript add-nextcloud-bookmarks')

BASE00 = '#1d2021'
BASE01 = '#3c3836'
BASE02 = '#504945'
BASE03 = '#665c54'
BASE04 = '#bdae93'
BASE05 = '#d5c4a1'
BASE06 = '#ebdbb2'
BASE07 = '#fbf1c7'
BASE08 = '#fb4934'
BASE09 = '#fe8019'
BASE0A = '#fabd2f'
BASE0B = '#b8bb26'
BASE0C = '#8ec07c'
BASE0D = '#83a598'
BASE0E = '#d3869b'
BASE0F = '#d65d0e'

# set qutebrowser colors

# Text color of the completion widget. May be a single color to use for
# all columns or a list of three colors, one for each column.
c.colors.completion.fg = BASE05

# Background color of the completion widget for odd rows.
c.colors.completion.odd.bg = BASE00

# Background color of the completion widget for even rows.
c.colors.completion.even.bg = BASE00

# Foreground color of completion widget category headers.
c.colors.completion.category.fg = BASE0D

# Background color of the completion widget category headers.
c.colors.completion.category.bg = BASE00

# Top border color of the completion widget category headers.
c.colors.completion.category.border.top = BASE00

# Bottom border color of the completion widget category headers.
c.colors.completion.category.border.bottom = BASE00

# Foreground color of the selected completion item.
c.colors.completion.item.selected.fg = BASE05

# Background color of the selected completion item.
c.colors.completion.item.selected.bg = BASE02

# Top border color of the selected completion item.
c.colors.completion.item.selected.border.top = BASE02

# Bottom border color of the selected completion item.
c.colors.completion.item.selected.border.bottom = BASE02

# Foreground color of the matched text in the selected completion item.
c.colors.completion.item.selected.match.fg = BASE05

# Foreground color of the matched text in the completion.
c.colors.completion.match.fg = BASE09

# Color of the scrollbar handle in the completion view.
c.colors.completion.scrollbar.fg = BASE05

# Color of the scrollbar in the completion view.
c.colors.completion.scrollbar.bg = BASE00

# Background color of disabled items in the context menu.
c.colors.contextmenu.disabled.bg = BASE01

# Foreground color of disabled items in the context menu.
c.colors.contextmenu.disabled.fg = BASE04

# Background color of the context menu. If set to null, the Qt default is used.
c.colors.contextmenu.menu.bg = BASE00

# Foreground color of the context menu. If set to null, the Qt default is used.
c.colors.contextmenu.menu.fg = BASE05

# Background color of the context menus selected item.
# If set to null, the Qt default is used.
c.colors.contextmenu.selected.bg = BASE02

# Foreground color of the context menus selected item.
# If set to null, the Qt default is used.
c.colors.contextmenu.selected.fg = BASE05

# Background color for the download bar.
c.colors.downloads.bar.bg = BASE00

# Color gradient start for download text.
c.colors.downloads.start.fg = BASE00

# Color gradient start for download backgrounds.
c.colors.downloads.start.bg = BASE0D

# Color gradient end for download text.
c.colors.downloads.stop.fg = BASE00

# Color gradient stop for download backgrounds.
c.colors.downloads.stop.bg = BASE0C

# Foreground color for downloads with errors.
c.colors.downloads.error.fg = BASE08

# Font color for hints.
c.colors.hints.fg = BASE00

# Background color for hints. Note that you can use a `rgba(...)` value
# for transparency.
c.colors.hints.bg = BASE0A

# Font color for the matched part of hints.
c.colors.hints.match.fg = BASE05

# Text color for the keyhint widget.
c.colors.keyhint.fg = BASE05

# Highlight color for keys to complete the current keychain.
c.colors.keyhint.suffix.fg = BASE05

# Background color of the keyhint widget.
c.colors.keyhint.bg = BASE00

# Foreground color of an error message.
c.colors.messages.error.fg = BASE00

# Background color of an error message.
c.colors.messages.error.bg = BASE08

# Border color of an error message.
c.colors.messages.error.border = BASE08

# Foreground color of a warning message.
c.colors.messages.warning.fg = BASE00

# Background color of a warning message.
c.colors.messages.warning.bg = BASE0E

# Border color of a warning message.
c.colors.messages.warning.border = BASE0E

# Foreground color of an info message.
c.colors.messages.info.fg = BASE05

# Background color of an info message.
c.colors.messages.info.bg = BASE00

# Border color of an info message.
c.colors.messages.info.border = BASE00

# Foreground color for prompts.
c.colors.prompts.fg = BASE05

# Border used around UI elements in prompts.
c.colors.prompts.border = BASE00

# Background color for prompts.
c.colors.prompts.bg = BASE00

# Background color for the selected item in filename prompts.
c.colors.prompts.selected.bg = BASE02

# Foreground color for the selected item in filename prompts.
c.colors.prompts.selected.fg = BASE05

# Foreground color of the statusbar.
c.colors.statusbar.normal.fg = BASE05

# Background color of the statusbar.
c.colors.statusbar.normal.bg = BASE00

# Foreground color of the statusbar in insert mode.
c.colors.statusbar.insert.fg = BASE0C

# Background color of the statusbar in insert mode.
c.colors.statusbar.insert.bg = BASE00

# Foreground color of the statusbar in passthrough mode.
c.colors.statusbar.passthrough.fg = BASE0A

# Background color of the statusbar in passthrough mode.
c.colors.statusbar.passthrough.bg = BASE00

# Foreground color of the statusbar in private browsing mode.
c.colors.statusbar.private.fg = BASE0E

# Background color of the statusbar in private browsing mode.
c.colors.statusbar.private.bg = BASE00

# Foreground color of the statusbar in command mode.
c.colors.statusbar.command.fg = BASE04

# Background color of the statusbar in command mode.
c.colors.statusbar.command.bg = BASE01

# Foreground color of the statusbar in private browsing + command mode.
c.colors.statusbar.command.private.fg = BASE0E

# Background color of the statusbar in private browsing + command mode.
c.colors.statusbar.command.private.bg = BASE01

# Foreground color of the statusbar in caret mode.
c.colors.statusbar.caret.fg = BASE0D

# Background color of the statusbar in caret mode.
c.colors.statusbar.caret.bg = BASE00

# Foreground color of the statusbar in caret mode with a selection.
c.colors.statusbar.caret.selection.fg = BASE0D

# Background color of the statusbar in caret mode with a selection.
c.colors.statusbar.caret.selection.bg = BASE00

# Background color of the progress bar.
c.colors.statusbar.progress.bg = BASE0D

# Default foreground color of the URL in the statusbar.
c.colors.statusbar.url.fg = BASE05

# Foreground color of the URL in the statusbar on error.
c.colors.statusbar.url.error.fg = BASE08

# Foreground color of the URL in the statusbar for hovered links.
c.colors.statusbar.url.hover.fg = BASE09

# Foreground color of the URL in the statusbar on successful load
# (http).
c.colors.statusbar.url.success.http.fg = BASE0B

# Foreground color of the URL in the statusbar on successful load
# (https).
c.colors.statusbar.url.success.https.fg = BASE0B

# Foreground color of the URL in the statusbar when there's a warning.
c.colors.statusbar.url.warn.fg = BASE0E

# Background color of the tab bar.
c.colors.tabs.bar.bg = BASE00

# Color gradient start for the tab indicator.
c.colors.tabs.indicator.start = BASE0D

# Color gradient end for the tab indicator.
c.colors.tabs.indicator.stop = BASE0C

# Color for the tab indicator on errors.
c.colors.tabs.indicator.error = BASE08

# Foreground color of unselected odd tabs.
c.colors.tabs.odd.fg = BASE05

# Background color of unselected odd tabs.
c.colors.tabs.odd.bg = BASE00

# Foreground color of unselected even tabs.
c.colors.tabs.even.fg = BASE05

# Background color of unselected even tabs.
c.colors.tabs.even.bg = BASE00

# Background color of pinned unselected even tabs.
c.colors.tabs.pinned.even.bg = BASE0B

# Foreground color of pinned unselected even tabs.
c.colors.tabs.pinned.even.fg = BASE00

# Background color of pinned unselected odd tabs.
c.colors.tabs.pinned.odd.bg = BASE0B

# Foreground color of pinned unselected odd tabs.
c.colors.tabs.pinned.odd.fg = BASE00

# Background color of pinned selected even tabs.
c.colors.tabs.pinned.selected.even.bg = BASE02

# Foreground color of pinned selected even tabs.
c.colors.tabs.pinned.selected.even.fg = BASE05

# Background color of pinned selected odd tabs.
c.colors.tabs.pinned.selected.odd.bg = BASE02

# Foreground color of pinned selected odd tabs.
c.colors.tabs.pinned.selected.odd.fg = BASE05

# Foreground color of selected odd tabs.
c.colors.tabs.selected.odd.fg = BASE05

# Background color of selected odd tabs.
c.colors.tabs.selected.odd.bg = BASE02

# Foreground color of selected even tabs.
c.colors.tabs.selected.even.fg = BASE05

# Background color of selected even tabs.
c.colors.tabs.selected.even.bg = BASE02

# Background color for webpages if unset (or empty to use the theme's
# color).
c.colors.webpage.bg = BASE00

c.content.autoplay = False
c.content.blocking.enabled = True
c.content.blocking.method = 'both'
c.content.default_encoding = 'utf-8'
c.content.geolocation = False
c.content.pdfjs = True
c.scrolling.bar = 'always'
c.zoom.default = '90%'
c.downloads.location.directory = '~/dl/'
c.downloads.position = 'bottom'
# c.content.host_blocking.lists.append(str(c.configdir) + "/blocked-hosts")

config.load_autoconfig()

# USERSCRIPTS
#
# personally I use
# - for password management
#   - qute-pass
# - for chrome casting I use
#   - cast
#   - I have been looking at using catt instead of castnow

# }}}
