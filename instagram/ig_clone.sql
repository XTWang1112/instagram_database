CREATE DATABASE ig_clone;
USE ig_clone;

CREATE TABLE  users(
  id INT AUTO_INCREMENT  PRIMARY KEY,
  username VARCHAR(255) UNIQUE NOT NULL,
  created_at TIMESTAMP DEFAULT NOW()
);

INSERT INTO users(username) VALUES('BlueTheCat'), ('Dawang'), ('Yuchen');

CREATE TABLE  photos(
  id INT AUTO_INCREMENT  PRIMARY KEY,
  image_url VARCHAR(255) NOT NULL,
  user_id INT NOT NULL,
  created_at TIMESTAMP DEFAULT NOW(),
  FOREIGN KEY(user_id)  REFERENCES users(id)
);

INSERt INTO photos(image_url, user_id) VALUES
('/hsbfkhbd',  1),
('/sfvw',  2),
('/febvbw',  2);

SELECT  image_url, photos.created_at,  users.username
FROM  photos
INNER  JOIN users  ON  photos.user_id  = users.id;

 CREATE TABLE comments(
  id INT AUTO_INCREMENT  PRIMARY KEY,
  comment_text VARCHAR(255) NOT NULL,
  user_id INT NOT NULL,
  photo_id INT NOT NULL,
  created_at TIMESTAMP DEFAULT NOW(),
  FOREIGN KEY(user_id)  REFERENCES users(id),
  FOREIGN KEY(photo_id)  REFERENCES photos(id)
 );

CREATE TABLE likes(
  user_id INTEGER NOT NULL,
  photo_id INTEGER NOT NULL,
  created_at TIMESTAMP DEFAULT NOW(),
  FOREIGN KEY(user_id) REFERENCES  users(id),
  FOREIGN KEY(photo_id) REFERENCES photos(id)
);

CREATE TABLE follows(
  follower_id INTEGER NOT NULL,
  followee_id INTEGER NOT NULL,
  created_at TIMESTAMP DEFAULT NOW(),
  FOREIGN KEY(follower_id) REFERENCES users(id),
  FOREIGN KEY(followee_id) REFERENCES users(id),
  PRIMARY KEY(follower_id, followee_id)
);

CREATE TABLE tags(
  id INTEGER AUTO_INCREMENT PRIMARY KEY,
  tag_name VARCHAR(255) UNIQUE,
  created_at TIMESTAMP DEFAULT NOW()
);

CREATE TABLE photo_tags(
  photo_id INTEGER NOT NULL,
  tag_id INTEGER NOT NULL,
  FOREIGN KEY(photo_id) REFERENCES photos(id),
  FOREIGN KEY(tag_id) REFERENCES tags(id),
  PRIMARY KEY(photo_id, tag_id)
);