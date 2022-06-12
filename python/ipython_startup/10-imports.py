from __future__ import annotations  # importing __future__ must be at the top line.

# import standard libraries
from datetime import datetime, timezone
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

from logging import getLogger, DEBUG, INFO, WARN, WARNING
logger = getLogger('__main__')
logger.setLevel(INFO)

# typing
try:
    from typing_extensions import *
    from typing import *
except (ImportError, AttributeError, ModuleNotFoundError):
    pass

# import third-party libraries
try:
    import numpy as np
    from numpy import pi, sqrt, isclose
    np.set_printoptions(linewidth=175)
except (ImportError, AttributeError, ModuleNotFoundError):
    pass

try:
    # pip install nptyping
    from nptyping import *
except (ImportError, AttributeError, ModuleNotFoundError):
    pass

try:
    from scipy import constants
    from scipy.constants import physical_constants
    from scipy.optimize import curve_fit, minimize
    from scipy.fft import fft, fftfreq, fftshift
except (ImportError, AttributeError, ModuleNotFoundError):
    pass

try:
    import pandas as pd
except (ImportError, AttributeError, ModuleNotFoundError):
    pass

try:
    import matplotlib as mpl
    import matplotlib.pyplot as plt

    mpl.rcParams['figure.facecolor'] = 'w'
except (ImportError, AttributeError, ModuleNotFoundError):
    pass

try:
    # pip install tqdm
    from tqdm.auto import tqdm
except (ImportError, AttributeError, ModuleNotFoundError):
    pass

try:
    # pip install cloudpickle
    import cloudpickle
except (ImportError, AttributeError, ModuleNotFoundError):
    pass

try:
    # pip install esapy
    import esapy
    from esapy import esapy_fold
except (ImportError, AttributeError, ModuleNotFoundError):
    pass

try:
    # pip install better_exceptions
    import better_exceptions
    better_exceptions.MAX_LENGTH = None
except (ImportError, AttributeError, ModuleNotFoundError):
    pass

try:
    # pip install tkdialog-wrapper
    import tkdialog
except (ImportError, AttributeError, ModuleNotFoundError):
    pass

try:
    # pip install pytz
    import pytz
except (ImportError, AttributeError, ModuleNotFoundError):
    pass

