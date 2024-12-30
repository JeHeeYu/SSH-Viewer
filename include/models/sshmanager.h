#ifndef SSHMANAGER_H
#define SSHMANAGER_H

#include <libssh/libssh.h>
#include <string>
#include <QDebug>

class SSHManager
{
public:
    SSHManager(const std::string &hostName, const std::string &userName, const std::string &password, int port = 22);
    ~SSHManager();

    bool connect();
    void disconnect();

private:
    std::string hostName;
    std::string userName;
    std::string password;
    int port;
    ssh_session sshSession = nullptr;
};

#endif // SSHMANAGER_H
