#include "ssh/sshmodel.h"

SSHModel::SSHModel(QObject *parent) : QObject(parent)
{
    QList<QVariantList> entries = DATABASEMANAGER()->getEntry();

    for (const QVariantList &entry : entries) {
        if (entry.size() == 4) {
            QString hostName = entry[0].toString();
            QString userName = entry[1].toString();
            QString password = entry[2].toString();
            int port = entry[3].toInt();

            SSHData *sshData = new SSHData(hostName, userName, password, port, this);
            sshList.append(sshData);
        }
    }

    if (!entries.isEmpty()) {
        emit sshListChanged();
    }

    checkConnections();

    QTimer *timer = new QTimer(this);
    connect(timer, &QTimer::timeout, this, &SSHModel::checkConnections);
    timer->start(1000 * 60);
}

void SSHModel::addSSHList(const QString &hostName, const QString &userName, const QString &password, const QString &port)
{
    SSHManager sshManager(hostName, userName, password, port.toInt());

    if (sshManager.connect()) {
        SSHData *sshData = new SSHData(hostName, userName, password, port.toInt(), this);
        sshList.append(sshData);

        QVector<QString> keys = { "hostName", "userName", "password", "port" };
        QVector<QVariant> values = { hostName, userName, password, port.toInt() };
        bool dbAdded = DATABASEMANAGER()->addEntry(keys, values);
        if (dbAdded) {
            qDebug() << "test Added SSH to database: Host=" << hostName << ", User=" << userName;
        } else {
            qDebug() << "Failed to add SSH to database: Host=" << hostName << ", User=" << userName << ", Password=" << password << ", port=" << port;
            sshData->deleteLater();
            return;
        }

        emit sshListChanged();
        checkConnections();
        qDebug() << "Added SSH: Host=" << hostName << ", User=" << userName;
    }
    else {
        qDebug() << "Failed to add SSH: Host=" << hostName << ", User=" << userName;
    }
}

void SSHModel::removeSSHList(const QString &hostName, const QString &userName)
{
    for (int i = 0; i < sshList.size(); ++i) {
        SSHData *sshData = sshList.at(i);

        if (sshData->getHostName() == hostName && sshData->getUserName() == userName) {
            QVector<QString> keys = { "hostName", "userName" };
            QVector<QVariant> values = { hostName, userName };
            bool dbRemoved = DATABASEMANAGER()->removeEntry(keys, values);
            if (dbRemoved) {
                qDebug() << "Removed SSH from database: Host=" << hostName << ", User=" << userName;
            } else {
                qDebug() << "Failed to remove SSH from database: Host=" << hostName << ", User=" << userName;
            }

            sshList.removeAt(i);
            sshData->deleteLater();

            emit sshListChanged();
            qDebug() << "Removed SSH: Host=" << hostName << ", User=" << userName;
            return;
        }
    }

    qDebug() << "SSH entry not found: Host=" << hostName << ", User=" << userName;
}

QList<QObject*> SSHModel::getSSHList() const
{
    QList<QObject*> objectList;

    for (auto *sshData : sshList)
    {
        objectList.append(sshData);
    }

    return objectList;
}

void SSHModel::checkConnections()
{
    for (SSHData *sshData : sshList) {
        qDebug() << sshData->getHostName() << "  "  << sshData->getUserName() << "  " << sshData->getPassword()  <<"  "  << sshData->getPort();
        SSHManager sshManager(sshData->getHostName(), sshData->getUserName(), sshData->getPassword(), sshData->getPort());

        bool connected = sshManager.connect();
        sshData->setIsConnected(connected);
        sshManager.disconnect();
    }
}
