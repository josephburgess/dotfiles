import re

from kitty.clipboard import set_clipboard_string


def mark(text, args, Mark, extra_cli_args, *a):
    # file paths
    file_path_pattern = r"\b(?:/[\w.-]+)+\b"
    # SHAs
    sha_pattern = r"\b[0-9a-f]{7,40}\b"
    # numbers with 4+ digits
    number_pattern = r"\b\d{4,}\b"
    # hex numbers
    hex_pattern = r"\b0x[0-9a-fA-F]+\b"
    # IP addresses
    ip_pattern = r"\b(?:\d{1,3}\.){3}\d{1,3}\b"
    # k8s resources
    kubernetes_pattern = r"\b(?:pods?|deployments?|services?|replicasets?|namespaces?|nodes?|configmaps?|secrets?)\b"
    # UUIDs
    uuid_pattern = r"\b[0-9a-fA-F]{8}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{4}-[0-9a-fA-F]{12}\b"
    # git status/diff output (simplified example)
    git_pattern = r"\b(?:modified|added|deleted|renamed):\s+\S+\b"
    # URLs
    url_pattern = r"https?://[^\s]+"

    combined_pattern = f"({file_path_pattern})|({sha_pattern})|({number_pattern})|({hex_pattern})|({ip_pattern})|({kubernetes_pattern})|({uuid_pattern})|({git_pattern})|({url_pattern})"

    for idx, m in enumerate(re.finditer(combined_pattern, text)):
        start, end = m.span()
        mark_text = text[start:end].replace("\n", "").replace("\0", "")
        yield Mark(idx, start, end, mark_text, {})


def handle_result(args, data, target_window_id, boss, extra_cli_args, *a):
    matches = [m for m in data["match"] if m]
    if matches:
        clipboard_content = "\n".join(matches)
        set_clipboard_string(clipboard_content)
