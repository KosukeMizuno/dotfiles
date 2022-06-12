# helpers for jupyter, ipython


def _get_runtime_env():
    """今の環境を文字列で取得する
    https://blog.amedama.jp/entry/detect-jupyter-env
    """
    if 'get_ipython' not in globals():
        return 'python'

    env_name = get_ipython().__class__.__name__
    if env_name == 'TerminalInteractiveShell':
        return 'ipython'

    return 'jupyter'


def is_ipython():
    return _get_runtime_env() == 'ipython'


def is_jupyter():
    return _get_runtime_env() == 'jupyter'


# load widgets
try:
    from ipywidgets import clear_output, display
except ImportError:
    pass

