CREATE TABLE "public"."messages" (
    "id" int4 NOT NULL DEFAULT nextval('messages_id_seq'::regclass),
    "content" varchar(240),
    "created_at" timestamptz NOT NULL DEFAULT now(),
    "user_id" int4,
    CONSTRAINT "messages_user_id_fkey" FOREIGN KEY ("user_id") REFERENCES "public"."users"("id"),
    PRIMARY KEY ("id")
);