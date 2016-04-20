#ifndef DATABASE_H
#define DATABASE_H

#include <QtSql/QtSql>

class Database
{
public:
    static const int TitleRole;
    static const int ArtistRole;
    static const int AlbumArtRole;
    static const int AlbumRole;
    static const int PathRole;
    static const int IDRole;

    Database();
    ~Database();

    /*!
     * \brief Set the SQLite database file created by LMS
     * \param db absolute path to the LMS database file
     */
    void setDatabase(QString db);

    /*!
     * \brief Number of tracks available
     * \return Number of tracks available
     */
    int allTracksCount() const;

    /*!
     * \brief Execute an arbitraty SQL query
     * \param queryStr
     * \return Query result
     */
    QSqlQuery executeQuery(QString queryStr) const;

    /*!
     * \brief Count the number of items, given a SQL query
     * \param query SQL COUNT() query to qount items for
     * \return number of items returned by COUNT()
     */
    int allItemsCount(QString query) const;

    /*!
     * \brief Return a list of media items
     * \param query SQL query of items to select
     * \param whereQuery WHERE part of the query, excluding 'WHERE', for example: "artist_id == 1"
     * \param start first index to include
     * \param end last index to include
     * \return list of items matching query
     */
    QList<QHash<int, QString> > allItems(QString query, QString whereQuery, uint start, uint end) const;

    /*!
     * \brief Get the current database file
     * \return Path to current database file
     */
    QString database();


private:
    QSqlDatabase m_database;
};

#endif // DATABASE_H

