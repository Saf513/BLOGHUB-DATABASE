
create database blog-data 


--CREATION DE TABLE D'UTILISATEURS

CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    role ENUM('user', 'admin') DEFAULT 'user',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

--CREATION DE TABLE DES tags

CREATE TABLE tags (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,  
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP  
);

--CREATION DE TABLE DES COMMENTAIRES

CREATE TABLE articles (
    id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    content TEXT NOT NULL,
    image_url VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

--CREATION DE TABLEAU ASSOCIATIVE ENTRE  LE TABLEAU TAGS ET ARTICLES

CREATE TABLE article_tags (
    article_id INT NOT NULL,
    tag_id INT NOT NULL,
    PRIMARY KEY (article_id, tag_id),
    FOREIGN KEY (article_id) REFERENCES articles(id) ON DELETE CASCADE,
    FOREIGN KEY (tag_id) REFERENCES tags(id) ON DELETE CASCADE
);

--CREATION DE TABLEAU DES COMMENTAIRES

CREATE TABLE comments (
    id INT AUTO_INCREMENT PRIMARY KEY,
    article_id INT NOT NULL,
    user_id INT,
    content TEXT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (article_id) REFERENCES articles(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL
);

--CREATION DE TABLEAU DE VIEWS 

CREATE TABLE article_views (
    id INT AUTO_INCREMENT PRIMARY KEY,
    article_id INT NOT NULL,
    user_id INT,
    ip_address VARCHAR(45),
    viewed_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (article_id) REFERENCES articles(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL
);

--CREATION TABLEAU DES JADORS

CREATE TABLE article_likes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    article_id INT NOT NULL,
    user_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (article_id) REFERENCES articles(id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
);

--INSERTIONS DES USERS 

INSERT INTO users (username, email, password, role) 
VALUES 
('john_doe', 'john.doe@example.com', 'hashed_password_123', 'user'),
('jane_smith', 'jane.smith@example.com', 'hashed_password_456', 'admin'),
('alice_jones', 'alice.jones@example.com', 'hashed_password_789', 'user'),
('bob_martin', 'bob.martin@example.com', 'hashed_password_101', 'user'),
('charlie_brown', 'charlie.brown@example.com', 'hashed_password_112', 'admin');

--INSERTION DES TAGS 

INSERT INTO tags (name)
VALUES
('SQL'),
('JavaScript'),
('Web Development'),
('React'),
('Python'),
('Health'),
('Travel'),
('Business'),
('AI'),
('Photography');

--INSERTION DES ARTICLES

INSERT INTO articles (user_id, title, content, image_url) 
VALUES
(1, 'Introduction to SQL', 'This article introduces SQL, a powerful language for managing databases.', 'sql_intro_image.jpg'),
(2, 'Getting Started with React', 'Learn the basics of React and how to build dynamic web applications.', 'react_basics_image.jpg'),
(3, 'The Future of Artificial Intelligence', 'A deep dive into the future of AI and its impact on various industries.', 'ai_future_image.jpg'),
(4, 'Top 10 JavaScript Frameworks in 2024', 'An overview of the most popular JavaScript frameworks in 2024.', 'js_frameworks_2024_image.jpg'),
(5, 'Exploring Web Development Tools', 'A guide to the essential tools every web developer should know.', 'web_dev_tools_image.jpg');


--INSERTION DES COMMENTS 

INSERT INTO comments (article_id, user_id, content) 
VALUES
(1, 1, 'Great article! The introduction to SQL was very clear and informative.'),
(2, 2, 'I really enjoyed this article about React. Can\'t wait to try out the examples!'),
(3, 3, 'This is a fascinating read. The future of AI is definitely exciting, but also a bit scary.'),
(4, 4, 'I found this article very helpful. been trying to decide which JavaScript framework to use for my project.'),
(5, NULL, 'I\'m just a visitor, but I enjoyed reading this article about web development tools. Very useful tips!');


--INSERTION LES VIEWS

INSERT INTO article_views (article_id, user_id, ip_address) 
VALUES 
(1, 1, '192.168.1.1'),
(1, 2, '192.168.1.2'),
(2, 3, '192.168.1.3'),
(3, 4, '192.168.1.4'),
(4, 5, '192.168.1.5'),
(2, 3, '192.168.1.6'),
(5, 2, '192.168.1.7'),
(1, 4, '192.168.1.8'),
(3, 5, '192.168.1.9'),
(5, 1, '192.168.1.10');

--INSERTION DES JADORS

INSERT INTO article_likes (article_id, user_id) 
VALUES 
(1, 1),
(2, 3),
(3, 2),
(4, 4),
(5, 5),
(1, 2),
(2, 4),
(3, 5),
(4, 1),
(5, 3);

--INSERTION INTO LE TABLEAU artsicle_tag

INSERT INTO artsicle_tag (article_id, tag_id)
VALUES
(1, 1),  
(1, 2), 
(2, 3),  
(3, 4),  
(4, 5),  
(5, 6), 
(5, 7),  
(2, 8), 
(1, 9), 
(3, 10);

--SUPPRIMER LIGNE DE TABLE COMMENTS QUAND L ARTICLE ID EST 1

DELETE FROM comments
WHERE article_id = 1;

--UPDATE ARTICLE

UPDATE articles
SET title = 'Updated Title', content = 'Updated content for this article.'
WHERE id = 1;

--JOINTURES

SELECT articles.id AS article_id, articles.title, users.username
FROM articles
JOIN users ON articles.user_id = users.id;

