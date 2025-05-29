#include "image.h"

Image::Image(QString newName, QString newUrl, QObject *parent)
    : QObject{parent}
{

}

void Image::setName(const QString &newName)
{
    if (m_name != newName){
        m_name = newName;
        emit nameChanged(newName);
    }
}

const QString &Image::name() const
{
    return m_name;
}

const QString &Image::url() const
{
    return m_url;
}

void Image::setUrl(const QString &newUrl)
{
    if (m_url != newUrl){
        m_url = newUrl;
        emit nameChanged(newUrl);
    }
}
