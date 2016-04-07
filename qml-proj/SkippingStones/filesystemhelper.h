/*
 * Copyright 2014 Ruediger Gad
 *
 * This file is part of SkippingStones.
 *
 * SkippingStones is largely based on libpebble by Liam McLoughlin
 * https://github.com/Hexxeh/libpebble
 *
 * SkippingStones is published under the same license as libpebble (as of 10-02-2014):
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this software
 * and associated documentation files (the "Software"), to deal in the Software without restriction,
 * including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so,
 * subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all copies or
 * substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
 * INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
 * PARTICULAR PURPOSE AND NONINFRINGEMENT.
 * IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM,
 * DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
 * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 */

#ifndef FILESYSTEMHELPER_H
#define FILESYSTEMHELPER_H

#include <QObject>
#include <QStringList>

class FileSystemHelper : public QObject
{
    Q_OBJECT

    Q_ENUMS(VolumeEnums)

public:
    enum VolumeEnums {
        VolumeUp = 1,
        VolumeDown = 2
    };

    explicit FileSystemHelper(QObject *parent = 0);

    Q_INVOKABLE void changeVolume(int direction);

    Q_INVOKABLE int getBatteryChargeLevel();
    Q_INVOKABLE QStringList getFiles(QString dir, QString filter);
    Q_INVOKABLE QString getHomePath();
    Q_INVOKABLE int getVolume();

    Q_INVOKABLE QString readHex(const QString &fileName);

    Q_INVOKABLE void unzip(QString source, QString destination);

signals:

public slots:

};

#endif // FILESYSTEMHELPER_H
