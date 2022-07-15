#!/usr/bin/env python3
import os
import numpy as np
path = np.get_include()
os.system('export CFLAGS=\"-I' + path + '\"')
