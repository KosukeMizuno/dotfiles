# import standard libraries
import datetime
import functools
from functools import partial
import gc
import importlib
import itertools
from itertools import product
import json
import math
import os
from pathlib import Path
import pickle
from pprint import pprint
import re
import subprocess
import sys
import time
import tkinter as tk
import tkinter.filedialog

# typing
try:
    from typing import (
        Any, NoReturn, Union, Optional,
        Literal, Tuple, List, Dict, Set,  # Note: 3.9以降非推奨らしい
        Callable, Iterator, Generator, Sequence
    )
    from typing import overload  # >=3.9
except ImportError:
    pass

# import third-party libraries
try:
    import numpy as np
    from numpy import pi, sqrt, isclose
    np.set_printoptions(linewidth=175)

    from numpy.typing import ArrayLike, NDArray
except ImportError:
    pass

try:
    from scipy import constants
    from scipy.constants import physical_constants
    from scipy.optimize import curve_fit, minimize
    from scipy.fft import fft, fftfreq, fftshift
except ImportError:
    pass

try:
    import pandas as pd
except ImportError:
    pass

try:
    import matplotlib as mpl
    import matplotlib.pyplot as plt

    mpl.rcParams['figure.facecolor'] = 'w'
except ImportError:
    pass

try:
    from tqdm.auto import tqdm
except ImportError:
    pass

try:
    import cloudpickle
except ImportError:
    pass

try:
    import esapy
    from esapy import esapy_fold
except ImportError:
    pass

try:
    import better_exceptions
    better_exceptions.MAX_LENGTH = None
except ImportError:
    pass
