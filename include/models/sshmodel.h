#ifndef SSHMODEL_H
#define SSHMODEL_H

#include <QObject>
#include <QDebug>

#include "include/singleton.h"
#include "models/sshmanager.h"

class SSHModel : public QObject, public Singleton<SSHModel>
{
    Q_OBJECT

public:
    explicit SSHModel(QObject *parent = nullptr);

    Q_INVOKABLE void addSSHList(const QString &hostName, const QString &userName, const QString &password);

private:
    QList<SSHManager*> sshList;
};

#endif // SSHMODEL_H
