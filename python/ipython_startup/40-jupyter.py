# helpers for jupyter, ipython

# https://blog.amedama.jp/entry/detect-jupyter-env
def get_runtime_env():
    if 'get_ipython' not in globals():
        return 'python'

    env_name = get_ipython().__class__.__name__
    if env_name == 'TerminalInteractiveShell':
        return 'ipython'

    return 'jupyter'


def is_interactive_env():
    return get_runtime_env in ['ipython', 'jupyter']


def is_jupyter():
    return get_runtime_env == 'jupyter'


# load tqdm
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
