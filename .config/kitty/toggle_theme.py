from typing import List
from kitty.boss import Boss
import os
from kittens.tui.handler import result_handler

DARK_THEME = os.path.expanduser('~/.config/kitty/rose-pine.conf')
# DARK_THEME = os.path.expanduser('~/.config/kitty/rose-pine-moon.conf')
LIGHT_THEME = os.path.expanduser('~/.config/kitty/rose-pine-dawn.conf')
# DARK_THEME = os.path.expanduser('~/.config/kitty/tokyonight-moon.conf')
# LIGHT_THEME = os.path.expanduser('~/.config/kitty/tokyonight-day.conf')
# LIGHT_THEME = os.path.expanduser('~/.config/kitty/gruvbox-material-light-medium.conf')

GLOBAL_THEME_FILE = os.path.expanduser('~/.current_theme')
CURRENT_THEME_CONF = os.path.expanduser('~/.config/kitty/current-theme.conf')

def read_current_theme() -> str:
    if os.path.isfile(GLOBAL_THEME_FILE):
        with open(GLOBAL_THEME_FILE, 'r') as f:
            return f.read().strip()
    return 'dark'

def write_theme(theme: str, theme_file: str) -> None:
    with open(GLOBAL_THEME_FILE, 'w') as f:
        f.write(theme)
    with open(CURRENT_THEME_CONF, 'w') as f:
        f.write(f'include {theme_file}\n')

@result_handler(no_ui=True)
def handle_result(args: List[str], answer: str, target_window_id: int, boss: Boss) -> None:
    current_theme = read_current_theme()
    new_theme, new_theme_file = ('light', LIGHT_THEME) if current_theme == 'dark' else ('dark', DARK_THEME)

    boss.call_remote_control(
        boss.active_window,
        ('set-colors', '-a', new_theme_file)
    )

    write_theme(new_theme, new_theme_file)

def main(args: List[str]) -> str:
    return "handle_result"
