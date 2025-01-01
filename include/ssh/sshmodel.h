#ifndef SSHMODEL_H
#define SSHMODEL_H

#include <QObject>
#include <QList>
#include <QDebug>

#include "include/singleton.h"
#include "ssh/sshdata.h"
#include "ssh/sshmanager.h"

class SSHModel : public QObject, public Singleton<SSHModel>
{
    Q_OBJECT
    Q_PROPERTY(QList<QObject*> sshList READ getSSHList NOTIFY sshListChanged)

public:
    explicit SSHModel(QObject *parent = nullptr);

    Q_INVOKABLE void addSSHList(const QString &hostName, const QString &userName, const QString &password);

    QList<QObject*> getSSHList() const;

signals:
    void sshListChanged();

private:
    QList<SSHData*> sshList;
};

#endif // SSHMODEL_H
