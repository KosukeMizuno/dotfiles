# helpers for jupyter, ipython
from pathlib import Path
import pickle
import tkinter.filedialog
import tkinter as tk


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

# load widgets
try:
    from ipywidgets import clear_output, display
except ImportError:
    pass


def open_dialog(**opt):
    """examples of option:
    - filetypes=[(label, ext), ...]
        - label: str
        - ext: str, semicolon separated extentions
    - initialdir: str, default Path.cwd()
    - multiple: bool, default False
    """
    root = tk.Tk('sss', 'bbb')
    root.withdraw()
    root.wm_attributes("-topmost", True)

    opt_default = dict(initialdir=Path.cwd())
    _opt = dict(opt_default, **opt)

    return tk.filedialog.askopenfilename(**_opt)


def saveas_dialog(**opt):
    """examples of option:
    - filetypes=[(label, ext), ...]
        - label: str
        - ext: str, semicolon separated extentions
    - initialdir: str, default Path.cwd()
    - initialfile: str, default isn't set
    """
    root = tk.Tk('sss', 'bbb')
    root.withdraw()
    root.wm_attributes("-topmost", True)

    opt_default = dict(initialdir=Path.cwd())
    _opt = dict(opt_default, **opt)

    return tk.filedialog.asksaveasfilename(**_opt)


def load_with_dialog(mode='rb', **opt):
    p = Path(open_dialog(**opt))

    if not p.exists():
        return None

    with p.open(mode) as f:
        data = pickle.load(f)
    return data


def dump_with_dialog(obj, mode='wb', **opt):
    p = Path(saveas_dialog(**opt))
    # note: 上書き確認はtkinterがやってくれるのでここではチェックしない

    with p.open(mode) as f:
        pickle.dump(obj, f)
