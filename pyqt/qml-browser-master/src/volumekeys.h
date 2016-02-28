/*
 * Copyright (C) 2015 Stuart Howarth <showarth@marxoft.co.uk>
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 3 as
 * published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#ifndef VOLUMEKEYS_H
#define VOLUMEKEYS_H

#include <QObject>
#include <QWidget>

class VolumeKeys : public QObject
{
    Q_OBJECT

public:
    explicit VolumeKeys(QObject *parent = 0);
    ~VolumeKeys();

public slots:
    static bool grab(QObject *window);
    static bool release(QObject *window);
    
private:
    static bool grabVolumeKeys(WId windowId, bool grab);

    Q_DISABLE_COPY(VolumeKeys)
};

#endif // VOLUMEKEYS_H
