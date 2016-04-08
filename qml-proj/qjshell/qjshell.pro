# qjshell.pro ---
#
# Author: Julien Wintz
# Created: lun. mars 24 15:58:22 2014 (+0100)
# Version:
# Last-Updated: mar. mars 25 00:39:30 2014 (+0100)
#           By: Julien Wintz
#     Update #: 103
#

# Change Log:
#
#

TEMPLATE = subdirs

SUBDIRS += src
SUBDIRS += app
SUBDIRS += tst

app.depends = src
tst.depends = src
