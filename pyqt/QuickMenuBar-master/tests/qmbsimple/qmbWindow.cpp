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
// \file	qmbWindow.cpp
// \author	benoit@qanava.org
// \date	2014 11 19
//-----------------------------------------------------------------------------

// QT headers
#include <QApplication>

// Qanava headers
#include "./qmbWindow.h"

//-----------------------------------------------------------------------------
Window::Window( QWindow* parent ) :
    QQuickView( parent )
{
    setSource( QUrl( "qrc:/qmbsimple.qml" ) );
}

void    Window::testAction1( )
{
    qDebug( "Window::testAction1( ) triggered from QML" );
}
//-----------------------------------------------------------------------------

int	main( int argc, char** argv )
{
    QGuiApplication app( argc, argv );

    Window w;
    w.setResizeMode( QQuickView::SizeRootObjectToView );
    w.resize( 1024, 768 );
    w.show( );

    return app.exec( );
}

