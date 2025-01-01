#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include "ssh/sshmodel.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    SSHModel sshModel;

    QQmlApplicationEngine engine;

    engine.rootContext()->setContextProperty("sshModel", &sshModel);

    const QUrl url(QStringLiteral("qrc:/qml/Main.qml"));
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreated,
        &app,
        [url](QObject *obj, const QUrl &objUrl) {
            if (!obj && url == objUrl)
                QCoreApplication::exit(-1);
        },
        Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
