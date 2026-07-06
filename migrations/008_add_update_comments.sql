BEGIN;

ALTER TABLE ebock.comment_
    ALTER COLUMN comment_id_1 DROP NOT NULL;

INSERT INTO ebock.comment_(timestamp_, content, updated_at, comment_id_1, item_id, sender_cip) 
						   VALUES (NOW(), 'Cet article est-il toujours disponible ?', null, null, 5, 'larj4236'), 
							      (NOW(), 'Oui', null, 1, 5, 'pele3157'), 
								  (NOW(), 'Et si je vous offre 2$ pour ce produit ?', null, null, 5, 'herl2700'),
								  (NOW(), 'Je peux passer le chercher dans 6 ou 7 jours.', null, null, 5, 'bela3439'),
								  (NOW(), 'Je vous attendais et vous étiez pas là...', null, 4, 5, 'pele3157');

COMMIT;