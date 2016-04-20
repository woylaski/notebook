#include "database.h"

const int Database::ArtistRole = Qt::UserRole + 1;
const int Database::TitleRole = Qt::UserRole + 2;
const int Database::AlbumArtRole = Qt::UserRole + 3;
const int Database::AlbumRole = Qt::UserRole + 4;
const int Database::PathRole = Qt::UserRole + 5;
const int Database::IDRole = Qt::UserRole + 6;

Database::Database()
{

}

void Database::setDatabase(QString database){
    m_database = QSqlDatabase::addDatabase("QSQLITE");
    m_database.setDatabaseName(database);
    m_database.open();
}

QString Database::database() {
    return m_database.databaseName();
}

int Database::allItemsCount(QString query_) const {
    QSqlQuery query = executeQuery(query_);

    while(query.next()) {
        return query.value(0).toInt();
    }
    return 0;
}

QList<QHash<int, QString> > Database::allItems(QString query_,
                                               QString whereQuery,
                                               uint start,
                                               uint end) const {
    if (!whereQuery.isEmpty()) {
        query_ += " WHERE ";
        query_ += " " + whereQuery + " ";
    }

    query_ += " LIMIT " + QString::number(start) + ", " + QString::number(end) + ";";
    QSqlQuery query = executeQuery(query_);
    QList<QHash<int, QString> > list;

    while(query.next()) {
        QHash<int, QString> row;
        int numColumns = query.record().count();
        for (int i = 0; i < numColumns; i++) {
            QString field = query.record().fieldName(i);
            if (field == "title") {
                row.insert(TitleRole, query.value(i).toString());
            }
            else if(field == "id") {
                row.insert(IDRole, query.value(i).toString());
            }
            else if(field == "artist_name") {
                row.insert(ArtistRole, query.value(i).toString());
            }
            else if(field == "album_name") {
                row.insert(AlbumRole, query.value(i).toString());
            }
            else if(field == "album_art_url") {
                row.insert(AlbumArtRole, query.value(i).toString());
            }
            else if(field == "path") {
                row.insert(PathRole, query.value(i).toString());
            }
            else {
                qDebug() << "Unhandled column: " << query.record().fieldName(i);
            }
        }
        list << row;
    }

    return list;
}

QSqlQuery Database::executeQuery(QString queryStr) const {
    QSqlQuery query (m_database);
    query.exec(queryStr);

    qDebug() << "Executing: " << queryStr;
    if (query.lastError().type() != QSqlError::NoError) {
        qDebug() << query.lastError().text();
    }

    return query;
}

Database::~Database()
{

}
