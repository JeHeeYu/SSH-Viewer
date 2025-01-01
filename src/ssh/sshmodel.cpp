#include "ssh/sshmodel.h"

SSHModel::SSHModel(QObject *parent) : QObject(parent)
{

}

void SSHModel::addSSHList(const QString &hostName, const QString &userName, const QString &password)
{
    SSHManager *newConnection = new SSHManager(hostName, userName, password, 22);
    if (newConnection->connect()) {
        sshList.append(newConnection);

        qDebug() << "SSH connection added successfully.";
    }
    else {
        delete newConnection;

        qDebug() << "Failed to add SSH connection.";
    }
}
