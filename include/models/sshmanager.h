#ifndef SSHMANAGER_H
#define SSHMANAGER_H

#include <libssh/libssh.h>
#include <QDebug>

class SSHManager
{
public:
    SSHManager(const QString &hostName, const QString &userName, const QString &password, int port = 22);
    ~SSHManager();

    bool connect();
    void disconnect();

private:
    QString hostName;
    QString userName;
    QString password;
    int port;
    ssh_session sshSession = nullptr;
};


#endif // SSHMANAGER_H
