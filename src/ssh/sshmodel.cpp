#include "ssh/sshmodel.h"

SSHModel::SSHModel(QObject *parent) : QObject(parent)
{
    SSHData *sshData = new SSHData("Jehee123", "Jehee 2", 22, this);

    sshList.append(sshData);
}

void SSHModel::addSSHList(const QString &hostName, const QString &userName, const QString &password)
{
    SSHData *sshData = new SSHData(hostName, userName, 22, this);
    sshList.append(sshData);

    emit sshListChanged();
    qDebug() << "Added SSH: Host=" << hostName << ", User=" << userName;
}

QList<QObject*> SSHModel::getSshList() const
{
    QList<QObject*> objectList;
    for (auto *sshData : sshList)
    {
        objectList.append(sshData);
    }
    return objectList;
}
