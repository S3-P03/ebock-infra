BEGIN;

CREATE SCHEMA dark_ebock;

set search_path = dark_ebock;

CREATE TABLE user_(
                      cip VARCHAR(8) ,
                      first_name VARCHAR(50)  NOT NULL,
                      last_name VARCHAR(50)  NOT NULL,
                      email VARCHAR(90)  NOT NULL,
                      is_admin BOOLEAN NOT NULL,
                      profile_picture_url VARCHAR(50) ,
                      enabled BOOLEAN NOT NULL,
                      created_at TIMESTAMP NOT NULL,
                      updated_at VARCHAR(50) ,
                      PRIMARY KEY(cip),
                      UNIQUE(email)
);

CREATE TABLE review(
                       reviewer_cip VARCHAR(8) ,
                       reviewed_cip VARCHAR(8) ,
                       timestamp_ TIMESTAMP,
                       content VARCHAR(360)  NOT NULL,
                       rating SMALLINT NOT NULL,
                       updated_at TIMESTAMP,
                       PRIMARY KEY(reviewer_cip, reviewed_cip, timestamp_),
                       FOREIGN KEY(reviewer_cip) REFERENCES user_(cip),
                       FOREIGN KEY(reviewed_cip) REFERENCES user_(cip)
);

CREATE TABLE delivery_option(
                                delivery_optn_id SERIAL,
                                name VARCHAR(50)  NOT NULL,
                                PRIMARY KEY(delivery_optn_id),
                                UNIQUE(name)
);

CREATE TABLE category(
                         category_id SERIAL,
                         name VARCHAR(50)  NOT NULL,
                         parent_category INTEGER,
                         PRIMARY KEY(category_id),
                         UNIQUE(name),
                         FOREIGN KEY(parent_category) REFERENCES category(category_id)
);

CREATE TABLE tag(
                    tag_id SERIAL,
                    name VARCHAR(50)  NOT NULL,
                    PRIMARY KEY(tag_id),
                    UNIQUE(name)
);

CREATE TABLE log_category(
                             log_category_name VARCHAR(50) ,
                             PRIMARY KEY(log_category_name)
);

CREATE TABLE wear(
                     wear_id SERIAL,
                     name VARCHAR(50)  NOT NULL,
                     PRIMARY KEY(wear_id),
                     UNIQUE(name)
);

CREATE TABLE item(
                     item_id SERIAL,
                     name VARCHAR(60)  NOT NULL,
                     description VARCHAR(350)  NOT NULL,
                     price MONEY NOT NULL,
                     added_at TIMESTAMP NOT NULL,
                     updated_at TIMESTAMP,
                     sold BOOLEAN NOT NULL,
                     quantity SMALLINT NOT NULL,
                     archived BOOLEAN NOT NULL,
                     category_id INTEGER NOT NULL,
                     wear_id INTEGER NOT NULL,
                     seller_cip VARCHAR(8)  NOT NULL,
                     PRIMARY KEY(item_id),
                     FOREIGN KEY(category_id) REFERENCES category(category_id),
                     FOREIGN KEY(seller_cip) REFERENCES user_(cip),
                     FOREIGN KEY(wear_id) REFERENCES wear(wear_id)
);

CREATE TABLE log_(
                     id SERIAL,
                     timestamp_ TIMESTAMP NOT NULL,
                     content_1 VARCHAR(350)  NOT NULL,
                     content_2 VARCHAR(350) ,
                     log_category_name VARCHAR(50)  NOT NULL,
                     PRIMARY KEY(id),
                     FOREIGN KEY(log_category_name) REFERENCES log_category(log_category_name)
);

CREATE TABLE image_(
                       image_url VARCHAR(50) ,
                       item_id INTEGER NOT NULL,
                       PRIMARY KEY(image_url),
                       FOREIGN KEY(item_id) REFERENCES item(item_id)
);

CREATE TABLE order_(
                       order_id SERIAL,
                       created_at TIMESTAMP NOT NULL,
                       updated_at VARCHAR(50) ,
                       quantity VARCHAR(50)  NOT NULL,
                       item_id INTEGER NOT NULL,
                       buyer_cip VARCHAR(8)  NOT NULL,
                       PRIMARY KEY(order_id),
                       FOREIGN KEY(item_id) REFERENCES item(item_id),
                       FOREIGN KEY(buyer_cip) REFERENCES user_(cip)
);

CREATE TABLE comment_(
                         comment_id SERIAL,
                         timestamp_ TIMESTAMP NOT NULL,
                         content VARCHAR(360)  NOT NULL,
                         updated_at TIMESTAMP,
                         comment_id_1 INTEGER NOT NULL,
                         item_id INTEGER NOT NULL,
                         sender_cip VARCHAR(8)  NOT NULL,
                         PRIMARY KEY(comment_id),
                         FOREIGN KEY(comment_id_1) REFERENCES comment_(comment_id),
                         FOREIGN KEY(item_id) REFERENCES item(item_id),
                         FOREIGN KEY(sender_cip) REFERENCES user_(cip)
);

CREATE TABLE order_message(
                              timestamp_ TIMESTAMP,
                              content TEXT NOT NULL,
                              is_read BOOLEAN NOT NULL,
                              order_id INTEGER NOT NULL,
                              sender_cip VARCHAR(8)  NOT NULL,
                              PRIMARY KEY(timestamp_),
                              FOREIGN KEY(order_id) REFERENCES order_(order_id),
                              FOREIGN KEY(sender_cip) REFERENCES user_(cip)
);

CREATE TABLE item_del_option(
                                item_id INTEGER,
                                delivery_optn_id INTEGER,
                                PRIMARY KEY(item_id, delivery_optn_id),
                                FOREIGN KEY(item_id) REFERENCES item(item_id),
                                FOREIGN KEY(delivery_optn_id) REFERENCES delivery_option(delivery_optn_id)
);

CREATE TABLE tag_item(
                         item_id INTEGER,
                         tag_id INTEGER,
                         PRIMARY KEY(item_id, tag_id),
                         FOREIGN KEY(item_id) REFERENCES item(item_id),
                         FOREIGN KEY(tag_id) REFERENCES tag(tag_id)
);

CREATE TABLE favorite(
                         cip VARCHAR(8) ,
                         item_id INTEGER,
                         added_at TIMESTAMP NOT NULL,
                         PRIMARY KEY(cip, item_id),
                         FOREIGN KEY(cip) REFERENCES user_(cip),
                         FOREIGN KEY(item_id) REFERENCES item(item_id)
);

-- 001
ALTER TABLE user_
    ADD COLUMN address VARCHAR(150) DEFAULT '2500 Bd de lUniversité, Sherbrooke, QC J1N 3C6';

-- 002
CREATE TABLE payment_option(
                                     payment_optn_id SERIAL,
                                     name VARCHAR(50) NOT NULL,
                                     PRIMARY KEY(payment_optn_id),
                                     UNIQUE(name)
);

CREATE TABLE item_paym_option(
                                       item_id INTEGER,
                                       payment_optn_id INTEGER,
                                       PRIMARY KEY(item_id, payment_optn_id),
                                       FOREIGN KEY(item_id) REFERENCES item(item_id),
                                       FOREIGN KEY(payment_optn_id) REFERENCES payment_option(payment_optn_id)
);

-- 003
ALTER TABLE user_
DROP COLUMN IF EXISTS address;

CREATE TABLE province(
                               province_code VARCHAR(2),
                               province_name VARCHAR(30) NOT NULL,
                               PRIMARY KEY(province_code),
                               UNIQUE(province_name)
);

CREATE TABLE address(
                              address_id SERIAL,
                              civic_number INT NOT NULL,
                              appt_number INT,
                              street VARCHAR(60) NOT NULL,
                              postal_code VARCHAR(7) NOT NULL,
                              country VARCHAR(30) NOT NULL,
                              province_code VARCHAR(2) NOT NULL,
                              PRIMARY KEY(address_id),
                              FOREIGN KEY(province_code) REFERENCES province(province_code)
);

INSERT INTO province(province_name, province_code)
VALUES
    ('Alberta', 'AB'),
    ('Colombie-Britannique', 'BC'),
    ('Manitoba', 'MB'),
    ('Nouveau-Brunswick', 'NB'),
    ('Terre-Neuve-et-Labrador', 'NL'),
    ('Territoires du Nord-Ouest', 'NT'),
    ('Nouvelle-Écosse', 'NS'),
    ('Nunavut', 'NU'),
    ('Ontario', 'ON'),
    ('île-du-Prince-Édouard', 'PE'),
    ('Québec', 'QC'),
    ('Saskatchewan', 'SK'),
    ('Yukon', 'YT');

INSERT INTO address(civic_number, street, postal_code, country, province_code)
VALUES (2500, 'Bd de lUniversité', 'J1N 3C6', 'Canada', 'QC');

ALTER TABLE user_
    ADD COLUMN address_id INT NOT NULL DEFAULT 1;

ALTER TABLE user_
    ADD CONSTRAINT user_address
        FOREIGN KEY (address_id)
            REFERENCES address (address_id);

-- 004
DROP TABLE IF EXISTS image_;

CREATE TABLE image_(
                             guid varchar(50),
                             original_filename varchar(200) NOT NULL,
                             file_extension varchar(6),
                             created_at timestamp,
                             PRIMARY KEY(guid)
);

CREATE TABLE item_image(
                                 item_id int,
                                 guid VARCHAR(50),
                                 displayOrder smallint,
                                 PRIMARY KEY(item_id, guid, displayOrder),
                                 FOREIGN KEY(item_id) REFERENCES item(item_id),
                                 FOREIGN KEY(guid) REFERENCES image_(guid)
);

ALTER TABLE user_
    RENAME COLUMN profile_picture_url TO profile_picture_guid;

ALTER TABLE user_
    ADD CONSTRAINT profile_picture
        FOREIGN KEY (profile_picture_guid)
            REFERENCES image_ (guid);

-- 006
ALTER TABLE category
    ADD COLUMN deleted_at DATE DEFAULT NULL;

ALTER TABLE delivery_option
    ADD COLUMN deleted_at DATE DEFAULT NULL;

ALTER TABLE payment_option
    ADD COLUMN deleted_at DATE DEFAULT NULL;

ALTER TABLE wear
    ADD COLUMN deleted_at DATE DEFAULT NULL;

ALTER TABLE tag
    ADD COLUMN deleted_at DATE DEFAULT NULL;

-- 007
ALTER TABLE address ADD COLUMN city VARCHAR(50) NOT NULL DEFAULT '';
ALTER TABLE address ALTER COLUMN city DROP DEFAULT;
ALTER TABLE user_ ALTER COLUMN address_id DROP DEFAULT;

ALTER TABLE user_
DROP COLUMN is_admin,
    DROP COLUMN enabled;

ALTER TABLE user_
    ALTER COLUMN address_id DROP NOT NULL;

ALTER TABLE payment_option
ALTER COLUMN deleted_at TYPE TIMESTAMPTZ USING deleted_at::TIMESTAMPTZ;

ALTER TABLE delivery_option
ALTER COLUMN deleted_at TYPE TIMESTAMPTZ USING deleted_at::TIMESTAMPTZ;

ALTER TABLE wear
ALTER COLUMN deleted_at TYPE TIMESTAMPTZ USING deleted_at::TIMESTAMPTZ;

ALTER TABLE category
ALTER COLUMN deleted_at TYPE TIMESTAMPTZ USING deleted_at::TIMESTAMPTZ;

ALTER TABLE tag
ALTER COLUMN deleted_at TYPE TIMESTAMPTZ USING deleted_at::TIMESTAMPTZ;

-- 008
ALTER TABLE comment_
    ALTER COLUMN comment_id_1 DROP NOT NULL;

-- 009
ALTER TABLE comment_
    ADD COLUMN deleted_at TIMESTAMPTZ DEFAULT NULL;

INSERT INTO user_ (cip, first_name, last_name, email, profile_picture_guid, created_at, updated_at)
VALUES
    ('bela3439', 'Alex', 'Bellefroid Lefkakis', 'bela3439@usherbrooke.ca', NULL, NOW(), NULL),
    ('boum7113', 'Milo', 'Boucher', 'boum7113@usherbrooke.ca', NULL, NOW(), NULL),
    ('dubw5596', 'William', 'Dubuc', 'dubw5596@usherbrooke.ca', NULL, NOW(), NULL),
    ('herl2700', 'Léanne', 'Héroux', 'herl2700@usherbrooke.ca', NULL, NOW(), NULL),
    ('larj4236', 'Jean-Félix', 'Larouche', 'larj4236@usherbrooke.ca', NULL, NOW(), NULL),
    ('pele3157', 'Éliane', 'Pelletier', 'pele3157@usherbrooke.ca', NULL, NOW(), NULL),
    ('test1234', 'Utiilisateur', 'Test', 'test1234@usherbrooke.ca', NULL, NOW(), NULL);

INSERT INTO delivery_option (name) VALUES ('Drop off location'), ('Transfert par courriel');

INSERT INTO category (name, parent_category) VALUES ('Devoir', NULL), ('Examen', NULL), ('Buck', NULL), ('Autre', NULL);

INSERT INTO tag (name) VALUES ('Neuf'), ('Cours'), ('Usager');

INSERT INTO log_category (log_category_name) VALUES ('User Actions'), ('Item Management'), ('Orders'), ('Comments'), ('System Events');

INSERT INTO wear (name) VALUES ('Factory New'), ('Minimal Wear'), ('Field-Tested'), ('Well-Worn'), ('Battle-Scarred');

INSERT INTO item
(name, description, price, added_at, updated_at, sold, quantity, archived, category_id, wear_id, seller_cip)
VALUES ('Examen S3APP4', 'Examen complet de Domingo S3APP4', 25.12, now(),
        now(), false, 1, false, 1, 1, 'herl2700'),
       ('Tank BAJA', 'Beau tank avec une bonne transmission', 151000.00, now(),
        now(), false, 1, false, 3 , 3, 'boum7113'),
       ('Missile', 'Un beau missile avec un moteur de type H', 67000.00, now(),
        now(), false, 1, false, 3, 1, 'dubw5596'),
       ('Carte Cupidon Loup-Garou', 'Vrai carte du jeu Loup-Garou(fonctionne)', 7.50, now(),
        now(), false, 1, false, 3, 1, 'dubw5596'),
       ('Licence Windows 11', 'License très légit de Windows 11', 100.20, now(), now(), true, 1,
        false, 3, 1, 'larj4236'),
       ('Flag DCI Summer camp', 'Flag du DCI Summer camp(10 max)', 0.67, now(), now(),
        false, 10, false, 3, 1, 'pele3157'),
       ('One wish willow', 'Vous feriez quoi avec un voeux?', 4.55, now(), now(),
        false, 12, false, 3, 4, 'bela3439'),
       ('Pack de 24 Guru', '24 vrai et bonne guru', 21.00, now(), now(),
        true, 0, true, 3, 4, 'bela3439');

INSERT INTO comment_(timestamp_, content, updated_at, comment_id_1, item_id, sender_cip)
VALUES (NOW(), 'Il me faut l article asap', null, null, 4, 'bela3439');

INSERT INTO comment_(timestamp_, content, updated_at, comment_id_1, item_id, sender_cip)
VALUES (NOW(), 'Comment je cancel mon appart en rempli de raton laveur?', null, null, 7, 'dubw5596');

INSERT INTO comment_(timestamp_, content, updated_at, comment_id_1, item_id, sender_cip)
VALUES (NOW(), 'Est-ce que je peux mettre les coordonnées que je veux sur le missile?', null, null, 3, 'herl2700');

INSERT INTO comment_(timestamp_, content, updated_at, comment_id_1, item_id, sender_cip)
VALUES (NOW(), 'Accepte tu les drop-offs?', null, null, 8, 'boum7113');

INSERT INTO comment_(timestamp_, content, updated_at, comment_id_1, item_id, sender_cip)
VALUES (NOW(), 'Est-ce que je peux me parker à l université avec?', null, null, 2, 'pele3157');

INSERT INTO comment_(timestamp_, content, updated_at, comment_id_1, item_id, sender_cip)
VALUES (NOW(), 'Il y a un parking au studio pour celui-ci', null, 5, 2, 'boum7113');

INSERT INTO payment_option VALUES(DEFAULT,'Cash'),
                                       (DEFAULT,'Crypto'),
                                       (DEFAULT,'Jeton du 5@11');

INSERT INTO review VALUES ('larj4236', 'herl2700', '2026-05-21 09:39:59.000000', 'Mauvais service, mon examen était différent', 1, null),
                                ('herl2700', 'dubw5596', '2026-07-10 09:41:11.000000', 'Rien à dire', 5, null),
                                ('dubw5596', 'bela3439', '2026-07-11 09:42:57.000000', 'Manque de support technique', 2, null),
                                ('dubw5596', 'pele3157', '2026-07-01 09:42:57.000000', 'Service rapide', 2, null);

INSERT INTO favorite VALUES('pele3157', 2, '2026-06-23 21:26:00');

INSERT INTO item_del_option VALUES(1, 1),
                                        (1, 2),
                                        (3, 2),
                                        (4, 1),
                                        (4, 2);

INSERT INTO item_paym_option VALUES(1, 2),
                                         (2, 1),
                                         (5, 1),
                                         (5, 2),
                                         (4, 1),
                                         (4, 2);

INSERT INTO tag_item VALUES(1, 3),
                                 (3, 2),
                                 (5, 2),
                                 (5, 1);

INSERT INTO order_ (created_at, updated_at, quantity, item_id, buyer_cip) VALUES
                                                                                    ('2026-06-17 13:19:25.189001', '2026-06-17 13:19:25.189001-04', '1', 4, 'bela3439'),
                                                                                    ('2026-06-17 13:19:42.383485', '2026-06-17 13:19:42.383485-04', '1', 4, 'dubw5596'),
                                                                                    ('2026-06-17 13:20:30.012509', '2026-06-17 13:20:30.012509-04', '1', 4, 'herl2700'),
                                                                                    ('2026-06-17 13:21:42.914472', '2026-06-17 13:21:42.914472-04', '1', 4, 'pele3157'),
                                                                                    ('2026-06-17 13:51:21.237211', '2026-06-17 13:51:21.237211-04', '1', 4, 'boum7113'),
                                                                                    ('2026-06-17 13:55:15.742924', '2026-06-17 13:55:15.742924-04', '1', 5, 'larj4236');

COMMIT;
