from typing import List

from kittens.tui.handler import result_handler
from kitty.boss import Boss


def main(args: List[str]) -> str:
    return ""


@result_handler(no_ui=True)
def handle_result(args: List[str], answer: str, target_window_id: int,
                  boss: Boss) -> None:
    import kitty.fast_data_types as f

    os_window_id = f.current_focused_os_window_id()
    current_opacity = f.background_opacity_of(os_window_id)
    target_window = boss.window_id_map.get(target_window_id)

    if target_window is not None:
        if current_opacity == 1.0:
            boss.call_remote_control(target_window,
                                     ('set-background-opacity', '0.75'))
        else:
            boss.call_remote_control(target_window,
                                     ('set-background-opacity', '1.0'))
