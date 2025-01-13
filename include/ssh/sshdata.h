#ifndef SSHDATA_H
#define SSHDATA_H

#include <QObject>
#include <QDebug>

class SSHData : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString hostName READ getHostName    WRITE setHostName    NOTIFY hostNameChanged)
    Q_PROPERTY(QString userName READ getUserName    WRITE setUserName    NOTIFY userNameChanged)
    Q_PROPERTY(QString password READ getPassword    WRITE setPassword    NOTIFY passwordChanged)
    Q_PROPERTY(int port         READ getPort        WRITE setPort        NOTIFY portChanged)
    Q_PROPERTY(bool isConnected READ getIsConnected WRITE setIsConnected NOTIFY isConnectedChanged)

public:
    explicit SSHData(const QString &hostName = "", const QString &userName = "", const QString &password = "", const int &port = 0, QObject *parent = nullptr);

    QString getHostName() const;
    QString getUserName() const;
    QString getPassword() const;
    int getPort() const;
    bool getIsConnected() const;

    void setHostName(const QString &hostName);
    void setUserName(const QString &userName);
    void setPassword(const QString &password);
    void setPort(const int &port);
    void setIsConnected(const bool &connected);

signals:
    void hostNameChanged();
    void userNameChanged();
    void passwordChanged();
    void portChanged();
    void isConnectedChanged();

private:
    QString hostName;
    QString userName;
    QString password;
    int port;
    bool isConnected;
};

#endif // SSHDATA_H
