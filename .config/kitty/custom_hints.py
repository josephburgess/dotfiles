import re

from kitty.clipboard import set_clipboard_string


def mark(text, args, Mark, extra_cli_args, *a):
    # This function is responsible for finding all matching text.
    # Pattern for numbers
    number_pattern = r"\b\d+\b"
    # Pattern for URLs
    url_pattern = r"https?://[^\s]+"

    # Combine both patterns
    combined_pattern = f"({number_pattern})|({url_pattern})"

    for idx, m in enumerate(re.finditer(combined_pattern, text)):
        start, end = m.span()
        mark_text = text[start:end].replace("\n", "").replace("\0", "")
        yield Mark(idx, start, end, mark_text, {})


def handle_result(args, data, target_window_id, boss, extra_cli_args, *a):
    # This function is responsible for performing some action on the selected text.
    matches = [m for m in data["match"] if m]
    if matches:
        clipboard_content = "\n".join(matches)
        set_clipboard_string(clipboard_content)
