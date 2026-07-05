BEGIN;

ALTER TABLE ebock.address ADD COLUMN city VARCHAR(50) NOT NULL DEFAULT '';
ALTER TABLE ebock.address ALTER COLUMN city DROP DEFAULT;

ALTER TABLE ebock.user_
    DROP COLUMN is_admin,
    DROP COLUMN enabled;

ALTER TABLE ebock.user_
    ALTER COLUMN address_id DROP NOT NULL;

ALTER TABLE ebock.payment_option
    ALTER COLUMN deleted_at TYPE TIMESTAMPTZ USING deleted_at::TIMESTAMPTZ;

ALTER TABLE ebock.delivery_option
    ALTER COLUMN deleted_at TYPE TIMESTAMPTZ USING deleted_at::TIMESTAMPTZ;

ALTER TABLE ebock.wear
    ALTER COLUMN deleted_at TYPE TIMESTAMPTZ USING deleted_at::TIMESTAMPTZ;

ALTER TABLE ebock.category
    ALTER COLUMN deleted_at TYPE TIMESTAMPTZ USING deleted_at::TIMESTAMPTZ;

ALTER TABLE ebock.tag
    ALTER COLUMN deleted_at TYPE TIMESTAMPTZ USING deleted_at::TIMESTAMPTZ;

COMMIT;