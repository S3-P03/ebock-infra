BEGIN;

INSERT INTO ebock.review VALUES ('larj4236', 'pele3157', '2026-05-24 09:39:59.000000', 'Mauvais service, elle ne veut pas me vendre sa charge.', 1, null),
                                ('herl2700', 'pele3157', '2026-06-24 09:41:11.000000', 'Rien à dire', 5, null),
                                ('dubw5596', 'pele3157', '2026-06-24 09:42:57.000000', '67777777777777', 4, null);

INSERT INTO ebock.favorite VALUES('pele3157', 1, '2026-06-23 21:26:00');

INSERT INTO ebock.item_del_option VALUES(1, 1),
                                        (1, 2),
                                        (3, 2),
                                        (4, 1),
                                        (4, 2);

INSERT INTO ebock.payment_option VALUES(DEFAULT,'Interac'),
                                       (DEFAULT,'Cash');

INSERT INTO ebock.item_paym_option VALUES(1, 2),
                                         (2, 1),
                                         (5, 1),
                                         (5, 2),
                                         (4, 1),
                                         (4, 2);

INSERT INTO ebock.tag_item VALUES(1, 3),
                                 (3, 2),
                                 (5, 2),
                                 (5, 1);

INSERT INTO ebock.order_ (created_at, updated_at, quantity, item_id, buyer_cip) VALUES
                                                                                              ('2026-06-17 13:19:25.189001', '2026-06-17 13:19:25.189001-04', '1', 4, 'bela3439'),
                                                                                              ('2026-06-17 13:19:42.383485', '2026-06-17 13:19:42.383485-04', '1', 4, 'dubw5596'),
                                                                                              ('2026-06-17 13:20:30.012509', '2026-06-17 13:20:30.012509-04', '1', 4, 'herl2700'),
                                                                                              ('2026-06-17 13:21:42.914472', '2026-06-17 13:21:42.914472-04', '1', 4, 'pele3157'),
                                                                                              ('2026-06-17 13:51:21.237211', '2026-06-17 13:51:21.237211-04', '1', 4, 'boum7113'),
                                                                                              ('2026-06-17 13:55:15.742924', '2026-06-17 13:55:15.742924-04', '1', 5, 'larj4236');
INSERT INTO ebock.order_message (timestamp_, content, is_read, order_id, sender_cip) VALUES
                                                                                       ('2026-06-17 13:59:05.849555', 'Salut !', false, 6, 'larj4236'),
                                                                                       ('2026-06-17 14:02:17.389151', 'Bonjour à vous!', false, 6, 'pele3157'),
                                                                                       ('2026-06-17 14:02:53.56755', 'J''aimerais acheter cet article, mon ordinateur est à 67% actuellement, je suis cooked', false, 6, 'larj4236'),
                                                                                       ('2026-06-17 14:07:20.450053', 'Bin je sais pas trop j''ai encore besoin de ma charge...', false, 6, 'pele3157'),
                                                                                       ('2026-06-17 14:16:20.309614', 'What??', false, 6, 'larj4236'),
                                                                                       ('2026-06-17 14:18:23.760393', '3000$ ?', false, 6, 'larj4236'),
                                                                                       ('2026-06-17 14:18:49.337813', 'J''ai un exam tantôt', false, 6, 'larj4236'),
                                                                                       ('2026-06-17 22:44:08.908649', 'Je commence a stresser', false, 6, 'larj4236'),
                                                                                       ('2026-06-17 22:47:21.257778', 'Doooonc???', false, 6, 'larj4236'),
                                                                                       ('2026-06-17 22:48:00.514321', 'goddam calm down', false, 6, 'pele3157'),
                                                                                       ('2026-06-17 22:50:09.855163', 'Je ne souhaite pas te le vendre', false, 6, 'pele3157'),
                                                                                       ('2026-06-17 22:52:18.835812', 'Je ne souhaite pas te le vendre', false, 6, 'pele3157'),
                                                                                       ('2026-06-17 22:52:27.43083', 'Je ne souhaite pas te le vendre', false, 6, 'pele3157'),
                                                                                       ('2026-06-17 22:53:42.469945', 'C''est bon j''ai compris', false, 6, 'larj4236'),
                                                                                       ('2026-06-18 09:12:34.132228', 'Non t''as pas compris', false, 6, 'pele3157'),
                                                                                       ('2026-06-18 09:54:44.600569', 'Bon matin !', false, 6, 'larj4236'),
                                                                                       ('2026-06-18 09:55:03.857547', 'shut up', false, 6, 'pele3157');

COMMIT;
