from typing import List
from kitty.boss import Boss
import os

def main(args: List[str]) -> str:
    return ""

from kittens.tui.handler import result_handler
@result_handler(no_ui=True)
def handle_result(args: List[str], answer: str, target_window_id: int, boss: Boss) -> None:
    dark_theme = os.path.expanduser('~/.config/kitty/rose-pine.conf')
    light_theme = os.path.expanduser('~/.config/kitty/rose-pine-dawn.conf')

    theme_file = os.path.expanduser('~/.current_theme')
    current_theme_conf = os.path.expanduser('~/.config/kitty/current-theme.conf')

    if os.path.isfile(theme_file):
        with open(theme_file, 'r') as f:
            current_theme = f.read().strip()
    else:
        current_theme = 'dark'

    if current_theme == 'dark':
        new_theme = 'light'
        new_theme_file = light_theme
    else:
        new_theme = 'dark'
        new_theme_file = dark_theme

    boss.call_remote_control(
        boss.active_window,
        ('set-colors', '-a', new_theme_file)
    )

    with open(theme_file, 'w') as f:
        f.write(new_theme)

    with open(current_theme_conf, 'w') as f:
        if new_theme == 'dark':
            f.write(f'include {dark_theme}\n')
        else:
            f.write(f'include {light_theme}\n')
