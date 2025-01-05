#include "ssh/sshmodel.h"

SSHModel::SSHModel(QObject *parent) : QObject(parent)
{
    QList<QVariantList> entries = DATABASEMANAGER()->getEntry();

    for (const QVariantList &entry : entries) {
        if (entry.size() == 3) {
            QString hostName = entry[0].toString();
            QString userName = entry[1].toString();
            int port = entry[2].toInt();

            SSHData *sshData = new SSHData(hostName, userName, port, this);
            sshList.append(sshData);
        }
    }

    if (!entries.isEmpty()) {
        emit sshListChanged();
    }
}

void SSHModel::addSSHList(const QString &hostName, const QString &userName, const QString &password)
{
    SSHManager sshManager(hostName, userName, password, 22);

    if (true) {
        SSHData *sshData = new SSHData(hostName, userName, 22, this);
        sshList.append(sshData);

        // 데이터베이스에 항목 추가
        QVector<QString> keys = { "hostName", "userName", "port" };
        QVector<QVariant> values = { hostName, userName, 22 };
        bool dbAdded = DATABASEMANAGER()->addEntry(keys, values);
        if (dbAdded) {
            qDebug() << "test Added SSH to database: Host=" << hostName << ", User=" << userName;
        } else {
            qDebug() << "Failed to add SSH to database: Host=" << hostName << ", User=" << userName;
            // 필요 시, in-memory 리스트에서도 제거할 수 있습니다.
            sshData->deleteLater();
            return;
        }

        emit sshListChanged();
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
            // 데이터베이스에서 해당 항목 제거
            QVector<QString> keys = { "hostName", "userName" };
            QVector<QVariant> values = { hostName, userName };
            bool dbRemoved = DATABASEMANAGER()->removeEntry(keys, values);
            if (dbRemoved) {
                qDebug() << "Removed SSH from database: Host=" << hostName << ", User=" << userName;
            } else {
                qDebug() << "Failed to remove SSH from database: Host=" << hostName << ", User=" << userName;
                // 필요 시, 사용자에게 알릴 수 있습니다.
                // 여기서는 계속해서 in-memory 리스트에서 제거합니다.
            }

            // sshList에서 해당 항목 제거
            sshList.removeAt(i);
            sshData->deleteLater();

            emit sshListChanged();
            qDebug() << "Removed SSH: Host=" << hostName << ", User=" << userName;
            return;
        }
    }

    // 지정된 호스트와 사용자가 목록에 없는 경우
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
