#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickStyle>
#include <QQmlContext>
#include <QList>
#include "image.h"

int main(int argc, char *argv[])
{
#if QT_VERSION < QT_VERSION_CHECK(6, 0, 0)
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
#endif
    QGuiApplication app(argc, argv);

    QQuickStyle::setStyle("Material");

    QList<QObject*> m_images;
    m_images.append(new Image("Obrázek 1","qrc:/kote1.jfif"));
    m_images.append(new Image("Obrázek 2", "qrc:/kockabila.jpg"));
    m_images.append(new Image("Obrázek 3", "qrc:/catloaf.jpg"));


    QQmlApplicationEngine engine;
    engine.rootContext()->setContextProperty("imageModel", QVariant::fromValue(m_images));
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}
