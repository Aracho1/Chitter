CREATE TABLE "public"."users" (
    "id" int4 NOT NULL DEFAULT nextval('users_id_seq'::regclass),
    "username" varchar,
    "name" varchar,
    "email" varchar,
    "password" varchar,
    PRIMARY KEY ("id")
);