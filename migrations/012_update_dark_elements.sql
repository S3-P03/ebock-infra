BEGIN;

set search_path = dark_ebock;

ALTER TABLE item
    ADD COLUMN deleted_at TIMESTAMPTZ DEFAULT NULL;

ALTER TABLE item DROP COLUMN archived;

ALTER TABLE order_
    ADD COLUMN archived_at TIMESTAMPTZ DEFAULT NULL;
	
COMMIT;