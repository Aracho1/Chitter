CREATE TABLE "public"."tag" ("id" serial,"message_id" INT,"user_id" INT, PRIMARY KEY ("id"));
ALTER TABLE "public"."tag" ADD FOREIGN KEY ("message_id") REFERENCES "public"."messages" ("id");
ALTER TABLE "public"."tag" ADD FOREIGN KEY ("user_id") REFERENCES "public"."users" ("id");