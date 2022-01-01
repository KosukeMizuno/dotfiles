#### helpers for jupyter, ipython
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
    return _get_runtime_env == 'ipython'

def is_jupyter():
    return _get_runtime_env == 'jupyter'


#### load tqdm
if is_jupyter():
    try:
        from tqdm import tqdm_notebook as tqdm
    except ImportError:
        try:
            from tqdm import tqdm
        except ImportError:
            pass
else:
    try:
        from tqdm import tqdm
    except ImportError:
        pass

#### load widgets
from ipywidgets import clear_output, display

