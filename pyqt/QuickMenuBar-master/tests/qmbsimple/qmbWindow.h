/*
    This file is part of Quick Qanava library.

    Copyright (C) 2008-2015 Benoit AUTHEMAN

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

//-----------------------------------------------------------------------------
// This file is a part of the Quickmenubar software. copyright 2015 benoit autheman.
//
// \file	qmbWindow.h
// \author	benoit@qanava.org
// \date	2014 11 19
//-----------------------------------------------------------------------------

#ifndef qmbWindow_h
#define qmbWindow_h

// QT headers
#include <QQuickView>

class Window : public QQuickView
{
    Q_OBJECT

public:
    Window( QWindow* parent = 0 );
    virtual ~Window( ) { }
private:
    Q_DISABLE_COPY( Window );

protected slots:
    virtual void    testAction1( );
};

#endif // qmbWindow_h


