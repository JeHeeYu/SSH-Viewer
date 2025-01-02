#include "databasemanager.h"

DatabaseManager::DatabaseManager(QObject *parent) : QObject(parent)
{
    if (QSqlDatabase::contains("ssh_list")) {
        db = QSqlDatabase::database("ssh_list");
    } else {
        db = QSqlDatabase::addDatabase("QSQLITE", "ssh_list");
        db.setDatabaseName("ssh_list.db");

        if (!db.open()) {
            qDebug() << "Failed to open database:" << db.lastError().text();
        } else {
            qDebug() << "Database opened successfully.";
        }
    }
}

DatabaseManager::~DatabaseManager()
{
    if (db.isOpen()) {
        db.close();
    }
}

bool DatabaseManager::init()
{
    if (!db.isOpen()) {
        qDebug() << "Database is not open.";
        return false;
    }

    QSqlQuery query(db);
    QString createTableQuery = R"(
        CREATE TABLE IF NOT EXISTS ssh_list (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            hostName TEXT NOT NULL,
            userName TEXT NOT NULL,
            port INTEGER NOT NULL
        )
    )";

    if (!query.exec(createTableQuery)) {
        qDebug() << "Failed to create table:" << query.lastError().text();
        return false;
    }

    qDebug() << "Database initialized successfully.";
    return true;
}

bool DatabaseManager::addEntry(const QVector<QString> &keys, const QVector<QVariant> &values)
{
    if (!db.isOpen()) {
        qDebug() << "Database is not open.";
        return false;
    }

    if (keys.size() != values.size()) {
        qDebug() << "Keys and values size mismatch.";
        return false;
    }

    QString queryStr = "INSERT INTO ssh_list (";
    queryStr += keys.join(", ");
    queryStr += ") VALUES (";
    QStringList placeholders;
    for (const auto &key : keys) {
        placeholders.append(":" + key);
    }
    queryStr += placeholders.join(", ");
    queryStr += ")";

    QSqlQuery query(db);
    query.prepare(queryStr);

    for (int i = 0; i < keys.size(); ++i) {
        query.bindValue(":" + keys[i], values[i]);
    }

    if (!query.exec()) {
        qDebug() << "Failed to insert SSH entry :" << query.lastError().text();
        qDebug() << "Query :" << queryStr;
        return false;
    }

    qDebug() << "SSH entry added to database with keys:" << keys << "and values:" << values;
    return true;
}


QList<QVariantList> DatabaseManager::getEntry()
{
    QList<QVariantList> entries;

    if (!db.isOpen()) {
        qDebug() << "Database is not open.";
        return entries;
    }

    QSqlQuery query(db);
    query.prepare("SELECT hostName, userName, port FROM ssh_list");

    if (!query.exec()) {
        qDebug() << "Failed to retrieve SSH entries:" << query.lastError().text();
        return entries;
    }

    while (query.next()) {
        QVariantList entry;
        entry << query.value(0).toString()
              << query.value(1).toString()
              << query.value(2).toInt();
        entries.append(entry);
    }

    qDebug() << "Retrieved SSH entries from database.";
    return entries;
}

bool DatabaseManager::clearEntry()
{
    if (!db.isOpen()) {
        qDebug() << "Database is not open.";
        return false;
    }

    QSqlQuery query(db);
    if (!query.exec("DELETE FROM ssh_list")) {
        qDebug() << "Failed to clear SSH entries:" << query.lastError().text();
        return false;
    }

    qDebug() << "All SSH entries have been deleted from the database.";
    return true;
}

