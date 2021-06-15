# import standard libraries
import datetime
import functools
from functools import partial
import gc
import importlib
import itertools
import os
from pathlib import Path
import pickle
from pprint import pprint
import re
import subprocess
import sys
import time

# import third-party libraries
try:
    import numpy as np
except ImportError:
    pass

try:
    from scipy import constants
    from scipy.constants import physical_constants

    from scipy.optimize import curve_fit
    from scipy.fft import fft, fftfreq, fftshift
except ImportError:
    pass

try:
    import matplotlib as mpl
    import matplotlib.pyplot as plt
except ImportError:
    pass

try:
    from IPython import embed
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
