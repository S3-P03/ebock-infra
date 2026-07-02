BEGIN;

ALTER TABLE ebock.category
    ADD COLUMN deleted_at DATE DEFAULT NULL;

ALTER TABLE ebock.delivery_option
    ADD COLUMN deleted_at DATE DEFAULT NULL;

ALTER TABLE ebock.payment_option
    ADD COLUMN deleted_at DATE DEFAULT NULL;

ALTER TABLE ebock.wear
    ADD COLUMN deleted_at DATE DEFAULT NULL;

ALTER TABLE ebock.tag
    ADD COLUMN deleted_at DATE DEFAULT NULL;

COMMIT;
