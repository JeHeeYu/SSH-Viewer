#include "ssh/sshdata.h"

SSHData::SSHData(const QString &hostName, const QString &userName, const QString &password, const int &port, QObject *parent)
    : QObject(parent), hostName(hostName), userName(userName), password(password), port(port), isConnected(false)
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

QString SSHData::getPassword() const
{
    return password;
}


int SSHData::getPort() const
{
    return port;
}

bool SSHData::getIsConnected() const
{
    return isConnected;
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

void SSHData::setPassword(const QString &password)
{
    if (this->password != password) {
        this->password = password;

        emit passwordChanged();
    }
}


void SSHData::setPort(const int &port)
{
    if (this->port != port) {
        this->port = port;

        emit portChanged();
    }
}

void SSHData::setIsConnected(const bool &connected)
{
    if (this->isConnected != connected) {
        this->isConnected = connected;

        emit isConnectedChanged();
    }
}
