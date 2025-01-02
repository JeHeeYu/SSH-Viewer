#ifndef SINGLETON_H
#define SINGLETON_H

#include <QMutex>
#include <QMutexLocker>

template <typename T>
class Singleton
{
public:
    static T* Instance() {
        static QMutex mutex;
        QMutexLocker lock(&mutex);

        if (instance == nullptr) {
            instance = new T();
        }

        return instance;
    }

    virtual ~Singleton() {
        static QMutex mutex;
        QMutexLocker lock(&mutex);

        if (instance != nullptr) {
            delete instance;
            instance = nullptr;
        }
    }

private:
    static T* instance;
};

template <typename T>
T* Singleton<T>::instance = nullptr;


#endif // SINGLETON_H
