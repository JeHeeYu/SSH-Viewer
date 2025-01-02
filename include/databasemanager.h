#ifndef DATABASEMANAGER_H
#define DATABASEMANAGER_H

#include <QObject>
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QSqlError>
#include <QDebug>

#include "include/singleton.hpp"

#define DATABASEMANAGER() DatabaseManager::Instance()

class DatabaseManager : public QObject, public Singleton<DatabaseManager>
{
    Q_OBJECT

public:
    explicit DatabaseManager(QObject *parent = nullptr);
    ~DatabaseManager();

    bool init();
    bool addEntry(const QVector<QString> &keys, const QVector<QVariant> &values);
    QList<QVariantList> getEntry();
    bool clearEntry();

private:
    QSqlDatabase db;
};

#endif // DATABASEMANAGER_H
