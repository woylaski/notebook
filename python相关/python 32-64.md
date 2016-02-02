How to determine python shell is executing in 32bit or 64bit mode

>$ python-32 -c 'import sys;print("%x" % sys.maxsize, sys.maxsize > 2**32)'
('7fffffff', False)
$ python-64 -c 'import sys;print("%x" % sys.maxsize, sys.maxsize > 2**32)'
('7fffffffffffffff', True)  


>$ python-32 -c 'import struct;print( 8 * struct.calcsize("P"))'
32
$ python-64 -c 'import struct;print( 8 * struct.calcsize("P"))'
64