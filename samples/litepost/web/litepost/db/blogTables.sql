/*
 * LightPost Tables descriptions
 * Created October 11, 2006
 * by Chris Scott, chris.scott.one@gmail.com
 */
 
/*
 * Drop tables if they exist
 */
DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS bookmarks;
DROP TABLE IF EXISTS comments;
DROP TABLE IF EXISTS entries;
DROP TABLE IF EXISTS categories;  
 
/*
 * Users Table
 */

CREATE TABLE users (
	userID INT NOT NULL AUTO_INCREMENT,
	fname VARCHAR(30) NOT NULL,
	lname VARCHAR(30) NOT NULL,
	email VARCHAR(100) NOT NULL,
	username VARCHAR(20) NOT NULL,
	password VARCHAR(20) NOT NULL,
	role varchar(50) NOT NULL,  
	CONSTRAINT users_userID_pk PRIMARY KEY (userID),
	INDEX users_login_IX (username, password)
	) TYPE=INNODB
;

INSERT INTO users (fname, lname, email, username, password, role) 
VALUES ('Chris','Scott','chris.scott.one@gmail.com','chris','admin','admin');

/*
 * Categories, Entries, Comments, Bookmark
 */

CREATE TABLE categories (
	categoryID INT NOT NULL AUTO_INCREMENT,
	category VARCHAR(255) NOT NULL,  
	CONSTRAINT categories_categoryID_pk PRIMARY KEY (categoryID)
	) TYPE=INNODB
;

CREATE TABLE entries (
	entryID INT NOT NULL AUTO_INCREMENT,
	userID INT NOT NULL, 
	categoryID INT NOT NULL,
	title VARCHAR(255) NULL,
	body TEXT NOT NULL,
	dateCreated DATETIME NOT NULL,
	dateLastUpdated DATETIME NOT NULL,
	CONSTRAINT entries_entryID_pk PRIMARY KEY (entryID),
	CONSTRAINT entries_userID_fk FOREIGN KEY (userID) REFERENCES users (userID), 
	INDEX entries_categoryID_ix (categoryID)
	) TYPE=INNODB
;

CREATE TABLE comments (
	commentID INT NOT NULL AUTO_INCREMENT,
	entryID INT NOT NULL,
	comment TEXT NOT NULL,
	name VARCHAR(80) NOT NULL,
	email VARCHAR(100) NULL,
	url VARCHAR(150) NULL,
	dateCreated DATETIME NOT NULL,
	CONSTRAINT comments_commentID_pk PRIMARY KEY (commentID),
	INDEX comments_entryID_ix (entryID),
	CONSTRAINT comments_entryD_pk FOREIGN KEY (entryID) REFERENCES entries (entryID)
	) TYPE=INNODB
;

CREATE TABLE bookmarks (
	bookmarkID INT NOT NULL AUTO_INCREMENT,
	name VARCHAR(80) NOT NULL,
	url VARCHAR(255) NOT NULL,
	CONSTRAINT bookmarks_bookmarkID_pk PRIMARY KEY (bookmarkID)
	) TYPE=INNODB
;
