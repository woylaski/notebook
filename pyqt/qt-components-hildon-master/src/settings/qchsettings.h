/****************************************************************************
**
** Copyright (C) 2013 Digia Plc and/or its subsidiary(-ies).
** Contact: http://www.qt-project.org/legal
**
** This file is part of the examples of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:LGPL$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and Digia.  For licensing terms and
** conditions see http://qt.digia.com/licensing.  For further information
** use the contact form at http://qt.digia.com/contact-us.
**
** GNU Lesser General Public License Usage
** Alternatively, this file may be used under the terms of the GNU Lesser
** General Public License version 2.1 as published by the Free Software
** Foundation and appearing in the file LICENSE.LGPL included in the
** packaging of this file.  Please review the following information to
** ensure the GNU Lesser General Public License version 2.1 requirements
** will be met: http://www.gnu.org/licenses/old-licenses/lgpl-2.1.html.
**
** In addition, as a special exception, Digia gives you certain additional
** rights.  These rights are described in the Digia Qt LGPL Exception
** version 1.1, included in the file LGPL_EXCEPTION.txt in this package.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU
** General Public License version 3.0 as published by the Free Software
** Foundation and appearing in the file LICENSE.GPL included in the
** packaging of this file.  Please review the following information to
** ensure the GNU General Public License version 3.0 requirements will be
** met: http://www.gnu.org/copyleft/gpl.html.
**
**
** $QT_END_LICENSE$
**
****************************************************************************/

#ifndef QCHSETTINGS_H
#define QCHSETTINGS_H

#include <QObject>
#include <QDeclarativeParserStatus>
#include <qdeclarative.h>

class QchSettingsPrivate;

class QchSettings : public QObject, public QDeclarativeParserStatus
{
    Q_OBJECT
    Q_INTERFACES(QDeclarativeParserStatus)
    Q_PROPERTY(QString fileName READ fileName WRITE setFileName FINAL)
    Q_PROPERTY(QString category READ category WRITE setCategory FINAL)

public:
    explicit QchSettings(QObject *parent = 0);
    ~QchSettings();
    
    QString fileName() const;
    void setFileName(const QString &fileName);

    QString category() const;
    void setCategory(const QString &category);

protected:
    virtual void timerEvent(QTimerEvent *event);

    virtual void classBegin();
    virtual void componentComplete();

private:
    QScopedPointer<QchSettingsPrivate> d_ptr;

    Q_DISABLE_COPY(QchSettings)
    Q_DECLARE_PRIVATE(QchSettings)

    Q_PRIVATE_SLOT(d_func(), void _q_propertyChanged())
};

QML_DECLARE_TYPE(QchSettings)

#endif // QCHSETTINGS_H
