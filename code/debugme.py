def buggyfunc(x):
    y = x
    for i in range(x):
        y = y-1
        if y == 0:
            breakpoint()
        # import pdb; pdb.set_trace()
        z = x/y
    return z

buggyfunc(20)

def buggyfunc(x):
    y = x
    for i in range(x):
        try:
            y = y-1
            z = x/y
        except:
            print(f"This didn't work; {x = }; {y = }")
    return z
buggyfunc(20)

def buggyfunc(x):
    y = x
    for i in range(x):
        try:
            y = y-1
            z = x/y
        except ZeroDivisionError:
            print(f"The result of dividing a number by zero is undefined")
        except:
            print(f"This didn't work; {x = }; {y = }")
        else:
            print(f"OK; {x = }; {y = }, {z = };")
    return z

buggyfunc(20)

import math
print(math.isfinite(float("3.5")))
print(math.isfinite(float("inf")))
print(math.isfinite(float("nan")))

from math import cos, radians
theta = 30
print(f"{theta = }{cos(radians(theta)) = :.3f}")

import sys
from pathlib import Path
print(sys. executable)
print(sys.prefix)
print(Path.cwd())
print((Path.cwd()/"code").is_dir())