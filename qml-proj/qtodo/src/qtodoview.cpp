/*
 *  Copyright 2013 Ruediger Gad
 *
 *  This file is part of Q To-Do.
 *
 *  Q To-Do is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation, either version 3 of the License, or
 *  (at your option) any later version.
 *
 *  Q To-Do is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with Q To-Do.  If not, see <http://www.gnu.org/licenses/>.
 */

#include "qtodoview.h"

QToDoView::QToDoView(QWidget *parent) :
    QDeclarativeView(parent),
    m_windowFocus(false)
{
}

void QToDoView::focusInEvent(QFocusEvent *event) {
    setWindowFocus(true);
    QDeclarativeView::focusInEvent(event);
}

void QToDoView::focusOutEvent(QFocusEvent *event) {
    setWindowFocus(false);
    QDeclarativeView::focusOutEvent(event);
}
