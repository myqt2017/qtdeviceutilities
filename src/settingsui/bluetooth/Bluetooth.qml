/****************************************************************************
**
** Copyright (C) 2016 The Qt Company Ltd.
** Contact: https://www.qt.io/licensing/
**
** This file is part of the Device Utilities module of the Qt Toolkit.
**
** $QT_BEGIN_LICENSE:GPL$
** Commercial License Usage
** Licensees holding valid commercial Qt licenses may use this file in
** accordance with the commercial license agreement provided with the
** Software or, alternatively, in accordance with the terms contained in
** a written agreement between you and The Qt Company. For licensing terms
** and conditions see https://www.qt.io/terms-conditions. For further
** information use the contact form at https://www.qt.io/contact-us.
**
** GNU General Public License Usage
** Alternatively, this file may be used under the terms of the GNU
** General Public License version 3 or (at your option) any later version
** approved by the KDE Free Qt Foundation. The licenses are as published by
** the Free Software Foundation and appearing in the file LICENSE.GPL3
** included in the packaging of this file. Please review the following
** information to ensure the GNU General Public License requirements will
** be met: https://www.gnu.org/licenses/gpl-3.0.html.
**
** $QT_END_LICENSE$
**
****************************************************************************/
import QtQuick 2.6
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.0
import QtDeviceUtilities.BluetoothSettings 1.0

Item {
    id: root
    property string title: qsTr("Bluetooth Settings")

    ColumnLayout {
        anchors.margins: 20
        anchors.fill: parent
        id: content
        spacing: 20

        GroupBox {
            id: groupBox
            width: parent.width
            title: qsTr("Bluetooth status")
            Layout.fillWidth: true
            Layout.alignment: Qt.AlignTop
            enabled: BtDevice.available

            RowLayout {
                spacing: 10
                Label {
                    id: off
                    text: qsTr("Off")
                }
                Switch {
                    checked: BtDevice.powered
                    onCheckedChanged: {
                        BtDevice.powered = checked
                    }
                }

                Connections {
                    target: BtDevice
                    onPoweredChanged: {
                        if (BtDevice.powered)
                            BtDevice.scanning = true
                    }
                }

                Label {
                    text: qsTr("On")
                }
            }
        }
        Discovery {
            id: discovery
            visible: BtDevice.powered
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }
}
