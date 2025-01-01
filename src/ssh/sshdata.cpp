#include "ssh/sshdata.h"

SSHData::SSHData(const QString &hostName, const QString &userName, int port, QObject *parent)
    : QObject(parent), hostName(hostName), userName(userName), port(port)
{
}

QString SSHData::getHostName() const
{
    return hostName;
}

QString SSHData::getUserName() const
{
    return userName;
}

int SSHData::getPort() const {
    return port;
}

void SSHData::setHostName(const QString &hostName)
{
    if (this->hostName != hostName) {
        this->hostName = hostName;

        emit hostNameChanged();
    }
}

void SSHData::setUserName(const QString &userName)
{
    if (this->userName != userName) {
        this->userName = userName;

        emit userNameChanged();
    }
}

void SSHData::setPort(int port)
{
    if (this->port != port) {
        this->port = port;

        emit portChanged();
    }
}
