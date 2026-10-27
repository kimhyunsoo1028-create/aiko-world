-- 愛子 WORLD v2.1 + v2.2 통합 Supabase SQL
-- 기존 site_content, 공연 일정, 방송 링크를 변경하지 않습니다.
-- 실행 전 SQL 내용을 확인하십시오.

-- [1/2] 이어지는 시간: 일반 사진·영상
-- 愛子 WORLD · 발자취 사진/영상 관리
-- 기존 site_content / 공연 / 방송 영상 / site_admins 테이블은 전혀 변경하지 않습니다.
-- SQL Editor에서 1회 실행. 여러 번 실행해도 중복 항목을 만들지 않습니다.
CREATE TABLE IF NOT EXISTS public.history_media (
  id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
  entry_date date NOT NULL,
  kind text NOT NULL CHECK (kind IN ('photo','video')),
  title_ko text NOT NULL DEFAULT '',
  title_ja text NOT NULL DEFAULT '',
  title_en text NOT NULL DEFAULT '',
  description_ko text NOT NULL DEFAULT '',
  description_ja text NOT NULL DEFAULT '',
  description_en text NOT NULL DEFAULT '',
  media_url text NOT NULL CHECK (media_url ~ '^https://'),
  credit text NOT NULL DEFAULT '',
  is_published boolean NOT NULL DEFAULT true,
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS idx_aiko_history_media_public ON public.history_media (is_published,entry_date DESC);
ALTER TABLE public.history_media ENABLE ROW LEVEL SECURITY;
REVOKE ALL ON public.history_media FROM anon, authenticated;
GRANT SELECT ON public.history_media TO anon, authenticated;
GRANT INSERT, UPDATE, DELETE ON public.history_media TO authenticated;

DO $$ BEGIN
 IF NOT EXISTS (SELECT 1 FROM pg_policies WHERE schemaname='public' AND tablename='history_media' AND policyname='history media visitor read') THEN
  CREATE POLICY "history media visitor read" ON public.history_media FOR SELECT TO anon, authenticated
   USING (is_published OR (SELECT public.is_site_admin()));
 END IF;
 IF NOT EXISTS (SELECT 1 FROM pg_policies WHERE schemaname='public' AND tablename='history_media' AND policyname='history media admin insert') THEN
  CREATE POLICY "history media admin insert" ON public.history_media FOR INSERT TO authenticated
   WITH CHECK ((SELECT public.is_site_admin()));
 END IF;
 IF NOT EXISTS (SELECT 1 FROM pg_policies WHERE schemaname='public' AND tablename='history_media' AND policyname='history media admin update') THEN
  CREATE POLICY "history media admin update" ON public.history_media FOR UPDATE TO authenticated
   USING ((SELECT public.is_site_admin())) WITH CHECK ((SELECT public.is_site_admin()));
 END IF;
 IF NOT EXISTS (SELECT 1 FROM pg_policies WHERE schemaname='public' AND tablename='history_media' AND policyname='history media admin delete') THEN
  CREATE POLICY "history media admin delete" ON public.history_media FOR DELETE TO authenticated
   USING ((SELECT public.is_site_admin()));
 END IF;
END $$;

-- 기존 storage 'site-media' 버킷과 업로드 권한은 그대로 사용합니다.
SELECT 'history_media ready' AS result, count(*) AS existing_entries FROM public.history_media;


-- [2/2] 이어지는 시간: 공연별 기록
-- 愛子 WORLD v2.2 | 이어지는 시간: 공연별 세트리스트 · 사진 · 영상
-- 기존 site_content, 공연 일정, 방송 영상 링크, history_media에는 변경 없음.
-- 먼저 프로젝트 기존 site_admins / public.is_site_admin() 관리자 설정이 되어 있어야 합니다.
CREATE TABLE IF NOT EXISTS public.concert_stories (
 id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
 source_performance_id text UNIQUE,
 show_date date NOT NULL,
 show_time text NOT NULL DEFAULT '',
 category text NOT NULL DEFAULT 'oval' CHECK(category IN ('yamanotation','oval','solo','rent','festival','other')),
 title_ko text NOT NULL DEFAULT '',
 title_ja text NOT NULL DEFAULT '',
 title_en text NOT NULL DEFAULT '',
 venue text NOT NULL DEFAULT '',
 description_ko text NOT NULL DEFAULT '',
 description_ja text NOT NULL DEFAULT '',
 description_en text NOT NULL DEFAULT '',
 source_url text NOT NULL DEFAULT '',
 setlist jsonb NOT NULL DEFAULT '[]'::jsonb CHECK(jsonb_typeof(setlist)='array'),
 setlist_status text NOT NULL DEFAULT 'pending' CHECK(setlist_status IN ('pending','fan','confirmed')),
 setlist_source text NOT NULL DEFAULT '',
 media jsonb NOT NULL DEFAULT '[]'::jsonb CHECK(jsonb_typeof(media)='array'),
 is_published boolean NOT NULL DEFAULT false,
 created_at timestamptz NOT NULL DEFAULT now(),
 updated_at timestamptz NOT NULL DEFAULT now()
);
CREATE INDEX IF NOT EXISTS idx_concert_stories_public ON public.concert_stories(is_published,show_date DESC);
ALTER TABLE public.concert_stories ENABLE ROW LEVEL SECURITY;
REVOKE ALL ON TABLE public.concert_stories FROM anon,authenticated;
GRANT SELECT ON public.concert_stories TO anon,authenticated;
GRANT INSERT,UPDATE,DELETE ON public.concert_stories TO authenticated;
DO $$ BEGIN
 IF NOT EXISTS(SELECT 1 FROM pg_policies WHERE schemaname='public' AND tablename='concert_stories' AND policyname='concert_stories_read') THEN
  CREATE POLICY concert_stories_read ON public.concert_stories FOR SELECT TO anon,authenticated
    USING(is_published OR (SELECT public.is_site_admin()));
 END IF;
 IF NOT EXISTS(SELECT 1 FROM pg_policies WHERE schemaname='public' AND tablename='concert_stories' AND policyname='concert_stories_insert') THEN
  CREATE POLICY concert_stories_insert ON public.concert_stories FOR INSERT TO authenticated
    WITH CHECK((SELECT public.is_site_admin()));
 END IF;
 IF NOT EXISTS(SELECT 1 FROM pg_policies WHERE schemaname='public' AND tablename='concert_stories' AND policyname='concert_stories_update') THEN
  CREATE POLICY concert_stories_update ON public.concert_stories FOR UPDATE TO authenticated
    USING((SELECT public.is_site_admin())) WITH CHECK((SELECT public.is_site_admin()));
 END IF;
 IF NOT EXISTS(SELECT 1 FROM pg_policies WHERE schemaname='public' AND tablename='concert_stories' AND policyname='concert_stories_delete') THEN
  CREATE POLICY concert_stories_delete ON public.concert_stories FOR DELETE TO authenticated
    USING((SELECT public.is_site_admin()));
 END IF;
END $$;
-- 사진은 기존 'site-media' Storage 버킷을 재사용하므로 버킷 및 권한은 변경하지 않습니다.
SELECT 'concert_stories ready' AS result,count(*) AS saved_records FROM public.concert_stories;


SELECT 'v21+v22 ready' AS status, (SELECT count(*) FROM public.history_media) AS history_media_records, (SELECT count(*) FROM public.concert_stories) AS concert_stories_records;
