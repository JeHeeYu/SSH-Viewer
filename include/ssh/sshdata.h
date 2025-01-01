#ifndef SSHDATA_H
#define SSHDATA_H

#include <QObject>

class SSHData : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString hostName READ getHostName WRITE setHostName NOTIFY hostNameChanged)
    Q_PROPERTY(QString userName READ getUserName WRITE setUserName NOTIFY userNameChanged)
    Q_PROPERTY(int port READ getPort WRITE setPort NOTIFY portChanged)

public:
    explicit SSHData(const QString &hostName = "", const QString &userName = "", int port = 22, QObject *parent = nullptr);

    QString getHostName() const;
    QString getUserName() const;
    int getPort() const;

    void setHostName(const QString &hostName);
    void setUserName(const QString &userName);
    void setPort(int port);

signals:
    void hostNameChanged();
    void userNameChanged();
    void portChanged();

private:
    QString hostName;
    QString userName;
    int port;
};

#endif // SSHDATA_H
