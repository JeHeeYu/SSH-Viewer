#include "ssh/sshmanager.h"

SSHManager::SSHManager(const QString &hostName, const QString &userName, const QString &password, int port)
    : hostName(hostName), userName(userName), password(password), port(port) {}

SSHManager::~SSHManager()
{
    disconnect();
}

bool SSHManager::connect()
{
    sshSession = ssh_new();
    if (sshSession == nullptr) {
        qDebug() << "Failed to create SSH session.";
        return false;
    }

    ssh_options_set(sshSession, SSH_OPTIONS_HOST, hostName.toStdString().c_str());
    ssh_options_set(sshSession, SSH_OPTIONS_PORT, &port);
    ssh_options_set(sshSession, SSH_OPTIONS_USER, userName.toStdString().c_str());

    if (ssh_connect(sshSession) != SSH_OK) {
        qDebug() << "Failed to connect:" << ssh_get_error(sshSession);
        ssh_free(sshSession);
        return false;
    }

    if (ssh_userauth_password(sshSession, nullptr, password.toStdString().c_str()) != SSH_AUTH_SUCCESS) {
        qDebug() << "Authentication failed:" << ssh_get_error(sshSession);
        ssh_disconnect(sshSession);
        ssh_free(sshSession);
        return false;
    }

    qDebug() << "SSH connection established on host" << hostName << "and port" << port;
    return true;
}

void SSHManager::disconnect()
{
    if (sshSession != nullptr) {
        ssh_disconnect(sshSession);
        ssh_free(sshSession);
        sshSession = nullptr;
        qDebug() << "SSH connection closed.";
    }
}
