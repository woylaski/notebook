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

#ifndef SETTINGSADAPTER_H
#define SETTINGSADAPTER_H

#include <QObject>

class SettingsAdapter : public QObject
{
    Q_OBJECT
public:
    explicit SettingsAdapter(QObject *parent = 0);

    Q_INVOKABLE bool readBoolean(const QString &key, const bool &defaultValue);
    Q_INVOKABLE void setBoolean(const QString &key, const bool &value);

    Q_INVOKABLE int readInt(const QString &key, const int &defaultValue);
    Q_INVOKABLE void setInt(const QString &key, const int &value);

    Q_INVOKABLE QString readString(const QString &key, const QString &defaultValue);
    Q_INVOKABLE void setString(const QString &key, const QString &value);

signals:

public slots:

};

#endif // SETTINGSADAPTER_H
