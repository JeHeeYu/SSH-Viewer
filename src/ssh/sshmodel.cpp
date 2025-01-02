#include "ssh/sshmodel.h"

SSHModel::SSHModel(QObject *parent) : QObject(parent)
{
    QVector<QString> keys = {"hostName", "userName", "port"};
    QVector<QVariant> values = {"example.com 1", "admin", 22};

    DATABASEMANAGER()->addEntry(keys, values);
}

void SSHModel::addSSHList(const QString &hostName, const QString &userName, const QString &password)
{
    SSHManager sshManager(hostName, userName, password, 22);

    if (sshManager.connect()) {
        SSHData *sshData = new SSHData(hostName, userName, 22, this);
        sshList.append(sshData);

        emit sshListChanged();
        qDebug() << "Added SSH: Host=" << hostName << ", User=" << userName;
    }
    else {
        qDebug() << "Failed to add SSH: Host=" << hostName << ", User=" << userName;
    }
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
