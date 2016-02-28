TEMPLATE    =   subdirs
CONFIG      += ordered      # Well I know, but no choice...

quickmenubar.file         = src/quickmenubar.pro

test-qmbsimple.subdir   = tests/qmbsimple
test-qmbsimple.depends  = quickmenubar

SUBDIRS     +=  test-qmbsimple quickmenubar



