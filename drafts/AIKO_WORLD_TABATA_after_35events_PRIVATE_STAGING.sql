-- AIKO WORLD · TABATA 2.0 이후 공연 일정 비공개 초안 35건
-- GitHub 초안 브랜치에서 생성. 이 스크립트는 홈페이지/Netlify/기존 site_content를 수정하지 않습니다.
-- Supabase SQL Editor에서 1회 실행. 관리자 달력에는 바로 나타나지 않습니다.
-- 초안 보관을 위한 내부 전용 스키마/테이블을 만들며 공개 권한을 부여하지 않습니다.
-- 반드시 실제 Supabase 프로젝트에 맞게 선택하고 실행하세요.

BEGIN;
CREATE SCHEMA IF NOT EXISTS aiko_internal;
REVOKE ALL ON SCHEMA aiko_internal FROM PUBLIC, anon, authenticated;
CREATE TABLE IF NOT EXISTS aiko_internal.oval_calendar_drafts (
  entry_id text PRIMARY KEY,
  event_date date NOT NULL,
  event_time text NOT NULL DEFAULT '',
  event_payload jsonb NOT NULL,
  evidence_status text NOT NULL DEFAULT 'review',
  created_at timestamptz NOT NULL DEFAULT now(),
  CHECK (event_payload->>'id' = entry_id),
  CHECK (jsonb_typeof(event_payload) = 'object')
);
ALTER TABLE aiko_internal.oval_calendar_drafts ENABLE ROW LEVEL SECURITY;
REVOKE ALL ON aiko_internal.oval_calendar_drafts FROM PUBLIC, anon, authenticated;
CREATE INDEX IF NOT EXISTS oval_calendar_drafts_by_date ON aiko_internal.oval_calendar_drafts(event_date, event_time);

-- 기존 자료가 있으면 그대로 두고, 새로운 초안 ID만 추가합니다.
WITH incoming AS (
 SELECT entry FROM jsonb_array_elements($aiko_drafts$
[
  {
    "id": "oval-tour-2026-2-1",
    "date": "2026-01-08",
    "time": "19:00",
    "until": "",
    "category": "live",
    "status": "draft",
    "flag": "🇯🇵",
    "title": {
      "ko": "OVAL SISTEM · Prologue Tour O · KOMAGOME 2.1",
      "ja": "OVAL SISTEM Prologue Tour O ～KOMAGOME 2.1～",
      "en": "OVAL SISTEM Prologue Tour O · KOMAGOME 2.1"
    },
    "venue": "六本木CLUB EDGE",
    "city": {
      "ko": "일본",
      "ja": "日本",
      "en": "Japan"
    },
    "desc": {
      "ko": "공연 날짜와 세부 정보는 출처에서 확인하세요. 등록 전 확인 필요.",
      "ja": "公開前の確認用データです。",
      "en": "Draft entry pending review."
    },
    "source": "https://premier.twitcasting.tv/oval_sistem/shopcart/411701",
    "ticket": "",
    "_internal": {
      "series": "tour",
      "evidence": "confirmed",
      "created_from": "GitHub draft/oval-schedule-post-tabata-2026",
      "is_published": false
    }
  },
  {
    "id": "oval-tour-2026-2-2",
    "date": "2026-01-13",
    "time": "19:00",
    "until": "",
    "category": "live",
    "status": "draft",
    "flag": "🇯🇵",
    "title": {
      "ko": "OVAL SISTEM · Prologue Tour O · SUGAMO 2.2",
      "ja": "OVAL SISTEM Prologue Tour O ～SUGAMO 2.2～",
      "en": "OVAL SISTEM Prologue Tour O · SUGAMO 2.2"
    },
    "venue": "Live House 獅子王",
    "city": {
      "ko": "일본",
      "ja": "日本",
      "en": "Japan"
    },
    "desc": {
      "ko": "공연 날짜와 세부 정보는 출처에서 확인하세요. 등록 전 확인 필요.",
      "ja": "公開前の確認用データです。",
      "en": "Draft entry pending review."
    },
    "source": "https://ovalsistem.work/event/20260113/",
    "ticket": "",
    "_internal": {
      "series": "tour",
      "evidence": "confirmed",
      "created_from": "GitHub draft/oval-schedule-post-tabata-2026",
      "is_published": false
    }
  },
  {
    "id": "oval-tour-2026-2-3",
    "date": "2026-01-15",
    "time": "19:00",
    "until": "",
    "category": "live",
    "status": "draft",
    "flag": "🇯🇵",
    "title": {
      "ko": "OVAL SISTEM · Prologue Tour O · OTSUKA 2.3",
      "ja": "OVAL SISTEM Prologue Tour O ～OTSUKA 2.3～",
      "en": "OVAL SISTEM Prologue Tour O · OTSUKA 2.3"
    },
    "venue": "大塚MEETS",
    "city": {
      "ko": "일본",
      "ja": "日本",
      "en": "Japan"
    },
    "desc": {
      "ko": "공연 날짜와 세부 정보는 출처에서 확인하세요. 등록 전 확인 필요.",
      "ja": "公開前の確認用データです。",
      "en": "Draft entry pending review."
    },
    "source": "https://meets.rinky.info/events/34962",
    "ticket": "",
    "_internal": {
      "series": "tour",
      "evidence": "confirmed",
      "created_from": "GitHub draft/oval-schedule-post-tabata-2026",
      "is_published": false
    }
  },
  {
    "id": "oval-tour-2026-2-4",
    "date": "2026-01-23",
    "time": "19:00",
    "until": "",
    "category": "live",
    "status": "draft",
    "flag": "🇯🇵",
    "title": {
      "ko": "OVAL SISTEM · Prologue Tour O · IKEBUKURO 2.4",
      "ja": "OVAL SISTEM Prologue Tour O ～IKEBUKURO 2.4～",
      "en": "OVAL SISTEM Prologue Tour O · IKEBUKURO 2.4"
    },
    "venue": "池袋 LiveHouse mono",
    "city": {
      "ko": "일본",
      "ja": "日本",
      "en": "Japan"
    },
    "desc": {
      "ko": "공연 날짜와 세부 정보는 출처에서 확인하세요. 등록 전 확인 필요.",
      "ja": "公開前の確認用データです。",
      "en": "Draft entry pending review."
    },
    "source": "https://en.twitcasting.tv/oval_sistem/shopcart/416059",
    "ticket": "",
    "_internal": {
      "series": "tour",
      "evidence": "confirmed",
      "created_from": "GitHub draft/oval-schedule-post-tabata-2026",
      "is_published": false
    }
  },
  {
    "id": "oval-tour-2026-2-5",
    "date": "2026-01-29",
    "time": "",
    "until": "",
    "category": "live",
    "status": "draft",
    "flag": "🇯🇵",
    "title": {
      "ko": "OVAL SISTEM · Prologue Tour O · MEJIRO 2.5",
      "ja": "OVAL SISTEM Prologue Tour O ～MEJIRO 2.5～",
      "en": "OVAL SISTEM Prologue Tour O · MEJIRO 2.5"
    },
    "venue": "",
    "city": {
      "ko": "일본",
      "ja": "日本",
      "en": "Japan"
    },
    "desc": {
      "ko": "공연장 및 개연 시간 추가 확인 필요",
      "ja": "公開前の確認用データです。",
      "en": "Draft entry pending review."
    },
    "source": "https://financie.jp/communities/25/activity_log?page=8",
    "ticket": "",
    "_internal": {
      "series": "tour",
      "evidence": "date-confirmed",
      "created_from": "GitHub draft/oval-schedule-post-tabata-2026",
      "is_published": false
    }
  },
  {
    "id": "oval-seoul-20260131-1",
    "date": "2026-01-31",
    "time": "13:30",
    "until": "",
    "category": "live",
    "status": "draft",
    "flag": "🇰🇷",
    "title": {
      "ko": "OVAL SISTEM · orbit CLUB in SEOUL · 1부",
      "ja": "OVAL SISTEM orbit CLUB in SEOUL 第1部",
      "en": "OVAL SISTEM orbit CLUB in Seoul · Part 1"
    },
    "venue": "아지토 라이브홀 (AZITO LIVEHALL), 서울",
    "city": {
      "ko": "한국 · 서울",
      "ja": "韓国・ソウル",
      "en": "Seoul, Korea"
    },
    "desc": {
      "ko": "첫 한국 단독 공연 1부",
      "ja": "公開前の確認用データです。",
      "en": "Draft entry pending review."
    },
    "source": "https://www.ticketlink.co.kr/help/notice/63579",
    "ticket": "",
    "_internal": {
      "series": "orbit",
      "evidence": "confirmed",
      "created_from": "GitHub draft/oval-schedule-post-tabata-2026",
      "is_published": false
    }
  },
  {
    "id": "oval-seoul-20260131-2",
    "date": "2026-01-31",
    "time": "17:30",
    "until": "",
    "category": "live",
    "status": "draft",
    "flag": "🇰🇷",
    "title": {
      "ko": "OVAL SISTEM · orbit CLUB in SEOUL · 2부",
      "ja": "OVAL SISTEM orbit CLUB in SEOUL 第2部",
      "en": "OVAL SISTEM orbit CLUB in Seoul · Part 2"
    },
    "venue": "아지토 라이브홀 (AZITO LIVEHALL), 서울",
    "city": {
      "ko": "한국 · 서울",
      "ja": "韓国・ソウル",
      "en": "Seoul, Korea"
    },
    "desc": {
      "ko": "1부와 다른 구성의 2부",
      "ja": "公開前の確認用データです。",
      "en": "Draft entry pending review."
    },
    "source": "https://www.ticketlink.co.kr/help/notice/63579",
    "ticket": "",
    "_internal": {
      "series": "orbit",
      "evidence": "confirmed",
      "created_from": "GitHub draft/oval-schedule-post-tabata-2026",
      "is_published": false
    }
  },
  {
    "id": "oval-tour-2026-2-6",
    "date": "2026-02-02",
    "time": "19:00",
    "until": "",
    "category": "live",
    "status": "draft",
    "flag": "🇯🇵",
    "title": {
      "ko": "OVAL SISTEM · Prologue Tour O · TAKADANOBABA 2.6",
      "ja": "OVAL SISTEM Prologue Tour O ～TAKADANOBABA 2.6～",
      "en": "OVAL SISTEM Prologue Tour O · TAKADANOBABA 2.6"
    },
    "venue": "新大久保CLUB Voice",
    "city": {
      "ko": "일본",
      "ja": "日本",
      "en": "Japan"
    },
    "desc": {
      "ko": "공연 날짜와 세부 정보는 출처에서 확인하세요. 등록 전 확인 필요.",
      "ja": "公開前の確認用データです。",
      "en": "Draft entry pending review."
    },
    "source": "https://en.twitcasting.tv/oval_sistem/shopcart/416061",
    "ticket": "",
    "_internal": {
      "series": "tour",
      "evidence": "confirmed",
      "created_from": "GitHub draft/oval-schedule-post-tabata-2026",
      "is_published": false
    }
  },
  {
    "id": "oval-wuwa-together-2026-1",
    "date": "2026-02-07",
    "time": "",
    "until": "",
    "category": "festival",
    "status": "draft",
    "flag": "🇯🇵",
    "title": {
      "ko": "OVAL SISTEM · 명조 WUWA TOGETHER · 1일차",
      "ja": "OVAL SISTEM · 鳴潮スペシャルライブ WUWA TOGETHER · DAY 1",
      "en": "OVAL SISTEM · WUWA TOGETHER · Day 1"
    },
    "venue": "",
    "city": {
      "ko": "일본",
      "ja": "日本",
      "en": "Japan"
    },
    "desc": {
      "ko": "공식 X에서 1일차 출연 및 두 곡 공연 확인. 장소 확인 중.",
      "ja": "公開前の確認用データです。",
      "en": "Draft entry pending review."
    },
    "source": "https://teapawt.net/OVAL_SISTEM?filter=highlights",
    "ticket": "",
    "_internal": {
      "series": "festival",
      "evidence": "date-confirmed",
      "created_from": "GitHub draft/oval-schedule-post-tabata-2026",
      "is_published": false
    }
  },
  {
    "id": "oval-wuwa-together-2026-2",
    "date": "2026-02-08",
    "time": "",
    "until": "",
    "category": "festival",
    "status": "draft",
    "flag": "🇯🇵",
    "title": {
      "ko": "OVAL SISTEM · 명조 WUWA TOGETHER · 2일차",
      "ja": "OVAL SISTEM · 鳴潮スペシャルライブ WUWA TOGETHER · DAY 2",
      "en": "OVAL SISTEM · WUWA TOGETHER · Day 2"
    },
    "venue": "",
    "city": {
      "ko": "일본",
      "ja": "日本",
      "en": "Japan"
    },
    "desc": {
      "ko": "2일차 공연 예정 시간 11:24·15:24 경이라는 공식 SNS 사전 공지. 장소는 확인 중.",
      "ja": "公開前の確認用データです。",
      "en": "Draft entry pending review."
    },
    "source": "https://teapawt.net/OVAL_SISTEM?filter=highlights",
    "ticket": "",
    "_internal": {
      "series": "festival",
      "evidence": "date-confirmed",
      "created_from": "GitHub draft/oval-schedule-post-tabata-2026",
      "is_published": false
    }
  },
  {
    "id": "oval-tour-2026-2-7",
    "date": "2026-02-11",
    "time": "",
    "until": "",
    "category": "live",
    "status": "draft",
    "flag": "🇯🇵",
    "title": {
      "ko": "OVAL SISTEM · Prologue Tour O · SHINOOKUBO 2.7",
      "ja": "OVAL SISTEM Prologue Tour O ～SHINOOKUBO 2.7～",
      "en": "OVAL SISTEM Prologue Tour O · SHINOOKUBO 2.7"
    },
    "venue": "",
    "city": {
      "ko": "일본",
      "ja": "日本",
      "en": "Japan"
    },
    "desc": {
      "ko": "공연장 및 개연 시간 추가 확인 필요",
      "ja": "公開前の確認用データです。",
      "en": "Draft entry pending review."
    },
    "source": "https://www.automatworld.inabout.moi.st/shop.php?date=20260211&hl=zh",
    "ticket": "",
    "_internal": {
      "series": "tour",
      "evidence": "date-confirmed",
      "created_from": "GitHub draft/oval-schedule-post-tabata-2026",
      "is_published": false
    }
  },
  {
    "id": "oval-tour-2026-2-8",
    "date": "2026-02-17",
    "time": "19:00",
    "until": "",
    "category": "live",
    "status": "draft",
    "flag": "🇯🇵",
    "title": {
      "ko": "OVAL SISTEM · Prologue Tour O · SHINJUKU 2.8",
      "ja": "OVAL SISTEM Prologue Tour O ～SHINJUKU 2.8～",
      "en": "OVAL SISTEM Prologue Tour O · SHINJUKU 2.8"
    },
    "venue": "LIVE labo YOYOGI",
    "city": {
      "ko": "일본",
      "ja": "日本",
      "en": "Japan"
    },
    "desc": {
      "ko": "공연 날짜와 세부 정보는 출처에서 확인하세요. 등록 전 확인 필요.",
      "ja": "公開前の確認用データです。",
      "en": "Draft entry pending review."
    },
    "source": "https://ovalsistem.work/event/20260217/",
    "ticket": "",
    "_internal": {
      "series": "tour",
      "evidence": "confirmed",
      "created_from": "GitHub draft/oval-schedule-post-tabata-2026",
      "is_published": false
    }
  },
  {
    "id": "oval-tour-2026-2-9",
    "date": "2026-02-26",
    "time": "19:00",
    "until": "",
    "category": "live",
    "status": "draft",
    "flag": "🇯🇵",
    "title": {
      "ko": "OVAL SISTEM · Prologue Tour O · YOYOGI 2.9",
      "ja": "OVAL SISTEM Prologue Tour O ～YOYOGI 2.9～",
      "en": "OVAL SISTEM Prologue Tour O · YOYOGI 2.9"
    },
    "venue": "LIVE labo YOYOGI",
    "city": {
      "ko": "일본",
      "ja": "日本",
      "en": "Japan"
    },
    "desc": {
      "ko": "공연 날짜와 세부 정보는 출처에서 확인하세요. 등록 전 확인 필요.",
      "ja": "公開前の確認用データです。",
      "en": "Draft entry pending review."
    },
    "source": "https://ovalsistem.work/event/20260226/",
    "ticket": "",
    "_internal": {
      "series": "tour",
      "evidence": "confirmed",
      "created_from": "GitHub draft/oval-schedule-post-tabata-2026",
      "is_published": false
    }
  },
  {
    "id": "oval-tour-2026-3-0",
    "date": "2026-03-06",
    "time": "19:00",
    "until": "",
    "category": "live",
    "status": "draft",
    "flag": "🇯🇵",
    "title": {
      "ko": "OVAL SISTEM · Prologue Tour O · HARAJUKU 3.0",
      "ja": "OVAL SISTEM Prologue Tour O ～HARAJUKU 3.0～",
      "en": "OVAL SISTEM Prologue Tour O · HARAJUKU 3.0"
    },
    "venue": "原宿ストロボカフェ",
    "city": {
      "ko": "일본",
      "ja": "日本",
      "en": "Japan"
    },
    "desc": {
      "ko": "공연 날짜와 세부 정보는 출처에서 확인하세요. 등록 전 확인 필요.",
      "ja": "公開前の確認用データです。",
      "en": "Draft entry pending review."
    },
    "source": "https://www.strobe-cafe.com/schedule/2026/03/3857.html",
    "ticket": "",
    "_internal": {
      "series": "tour",
      "evidence": "confirmed",
      "created_from": "GitHub draft/oval-schedule-post-tabata-2026",
      "is_published": false
    }
  },
  {
    "id": "oval-tour-2026-3-1",
    "date": "2026-03-25",
    "time": "19:30",
    "until": "",
    "category": "live",
    "status": "draft",
    "flag": "🇯🇵",
    "title": {
      "ko": "OVAL SISTEM · Prologue Tour O · SHIBUYA 3.1 FINAL",
      "ja": "OVAL SISTEM Prologue Tour O ～SHIBUYA 3.1～ FINAL",
      "en": "OVAL SISTEM Prologue Tour O · SHIBUYA 3.1"
    },
    "venue": "TOKIO TOKYO",
    "city": {
      "ko": "일본",
      "ja": "日本",
      "en": "Japan"
    },
    "desc": {
      "ko": "첫 투어 최종 공연",
      "ja": "公開前の確認用データです。",
      "en": "Draft entry pending review."
    },
    "source": "https://ovalsistem.work/event/20260325/",
    "ticket": "",
    "_internal": {
      "series": "tour",
      "evidence": "confirmed",
      "created_from": "GitHub draft/oval-schedule-post-tabata-2026",
      "is_published": false
    }
  },
  {
    "id": "oval-osaka-20260328",
    "date": "2026-03-28",
    "time": "17:30",
    "until": "",
    "category": "live",
    "status": "draft",
    "flag": "🇯🇵",
    "title": {
      "ko": "OVAL SISTEM · orbit CLUB in OSAKA Vol.2",
      "ja": "OVAL SISTEM orbit CLUB in OSAKA Vol.2",
      "en": "OVAL SISTEM orbit CLUB in Osaka Vol.2"
    },
    "venue": "難波Mele, 오사카",
    "city": {
      "ko": "일본",
      "ja": "日本",
      "en": "Japan"
    },
    "desc": {
      "ko": "공연 날짜와 세부 정보는 출처에서 확인하세요. 등록 전 확인 필요.",
      "ja": "公開前の確認用データです。",
      "en": "Draft entry pending review."
    },
    "source": "https://ovalsistem.work/event/20260328-osaka/",
    "ticket": "",
    "_internal": {
      "series": "orbit",
      "evidence": "confirmed",
      "created_from": "GitHub draft/oval-schedule-post-tabata-2026",
      "is_published": false
    }
  },
  {
    "id": "oval-nagoya-20260329",
    "date": "2026-03-29",
    "time": "12:00",
    "until": "",
    "category": "live",
    "status": "draft",
    "flag": "🇯🇵",
    "title": {
      "ko": "OVAL SISTEM · orbit CLUB in NAGOYA Vol.2",
      "ja": "OVAL SISTEM orbit CLUB in NAGOYA Vol.2",
      "en": "OVAL SISTEM orbit CLUB in Nagoya Vol.2"
    },
    "venue": "RAD NINE, 나고야",
    "city": {
      "ko": "일본",
      "ja": "日本",
      "en": "Japan"
    },
    "desc": {
      "ko": "공연 날짜와 세부 정보는 출처에서 확인하세요. 등록 전 확인 필요.",
      "ja": "公開前の確認用データです。",
      "en": "Draft entry pending review."
    },
    "source": "https://ovalsistem.work/event/20260329-nagoya/",
    "ticket": "",
    "_internal": {
      "series": "orbit",
      "evidence": "confirmed",
      "created_from": "GitHub draft/oval-schedule-post-tabata-2026",
      "is_published": false
    }
  },
  {
    "id": "oval-kichijoji-2026-1",
    "date": "2026-04-11",
    "time": "12:00",
    "until": "",
    "category": "live",
    "status": "draft",
    "flag": "🇯🇵",
    "title": {
      "ko": "OVAL SISTEM · 당신과 나의 키치조지 Vol.1",
      "ja": "OVAL SISTEM 吉祥寺シリーズ「あなたと私の吉祥寺」Vol.1",
      "en": "OVAL SISTEM · Anata to Watashi no Kichijoji Vol.1"
    },
    "venue": "KICHIJOJI SHUFFLE, 도쿄",
    "city": {
      "ko": "일본",
      "ja": "日本",
      "en": "Japan"
    },
    "desc": {
      "ko": "공연 날짜와 세부 정보는 출처에서 확인하세요. 등록 전 확인 필요.",
      "ja": "公開前の確認用データです。",
      "en": "Draft entry pending review."
    },
    "source": "https://teapawt.net/OVAL_SISTEM?filter=highlights",
    "ticket": "",
    "_internal": {
      "series": "kichijoji",
      "evidence": "confirmed",
      "created_from": "GitHub draft/oval-schedule-post-tabata-2026",
      "is_published": false
    }
  },
  {
    "id": "oval-jigorock-20260425",
    "date": "2026-04-25",
    "time": "16:30",
    "until": "",
    "category": "festival",
    "status": "draft",
    "flag": "🇯🇵",
    "title": {
      "ko": "OVAL SISTEM · 지고록 2026",
      "ja": "OVAL SISTEM · ジゴロック2026",
      "en": "OVAL SISTEM · JIGOROCK 2026"
    },
    "venue": "大分スポーツ公園, 오이타",
    "city": {
      "ko": "일본",
      "ja": "日本",
      "en": "Japan"
    },
    "desc": {
      "ko": "페스티벌은 4/25–26 개최지만 OVAL의 확인된 출연일은 4/25",
      "ja": "公開前の確認用データです。",
      "en": "Draft entry pending review."
    },
    "source": "https://teapawt.net/OVAL_SISTEM?filter=highlights",
    "ticket": "",
    "_internal": {
      "series": "festival",
      "evidence": "confirmed",
      "created_from": "GitHub draft/oval-schedule-post-tabata-2026",
      "is_published": false
    }
  },
  {
    "id": "oval-kichijoji-2026-2",
    "date": "2026-05-03",
    "time": "18:30",
    "until": "",
    "category": "live",
    "status": "draft",
    "flag": "🇯🇵",
    "title": {
      "ko": "OVAL SISTEM · 당신과 나의 키치조지 Vol.2",
      "ja": "OVAL SISTEM 吉祥寺シリーズ「あなたと私の吉祥寺」Vol.2",
      "en": "OVAL SISTEM · Anata to Watashi no Kichijoji Vol.2"
    },
    "venue": "KICHIJOJI SHUFFLE, 도쿄",
    "city": {
      "ko": "일본",
      "ja": "日本",
      "en": "Japan"
    },
    "desc": {
      "ko": "공연 날짜와 세부 정보는 출처에서 확인하세요. 등록 전 확인 필요.",
      "ja": "公開前の確認用データです。",
      "en": "Draft entry pending review."
    },
    "source": "https://teapawt.net/OVAL_SISTEM?filter=highlights",
    "ticket": "",
    "_internal": {
      "series": "kichijoji",
      "evidence": "confirmed",
      "created_from": "GitHub draft/oval-schedule-post-tabata-2026",
      "is_published": false
    }
  },
  {
    "id": "oval-kichijoji-2026-3",
    "date": "2026-05-17",
    "time": "18:30",
    "until": "",
    "category": "live",
    "status": "draft",
    "flag": "🇯🇵",
    "title": {
      "ko": "OVAL SISTEM · 당신과 나의 키치조지 Vol.3",
      "ja": "OVAL SISTEM 吉祥寺シリーズ「あなたと私の吉祥寺」Vol.3",
      "en": "OVAL SISTEM · Anata to Watashi no Kichijoji Vol.3"
    },
    "venue": "KICHIJOJI SHUFFLE, 도쿄",
    "city": {
      "ko": "일본",
      "ja": "日本",
      "en": "Japan"
    },
    "desc": {
      "ko": "공연 날짜와 세부 정보는 출처에서 확인하세요. 등록 전 확인 필요.",
      "ja": "公開前の確認用データです。",
      "en": "Draft entry pending review."
    },
    "source": "https://teapawt.net/OVAL_SISTEM?filter=highlights",
    "ticket": "",
    "_internal": {
      "series": "kichijoji",
      "evidence": "confirmed",
      "created_from": "GitHub draft/oval-schedule-post-tabata-2026",
      "is_published": false
    }
  },
  {
    "id": "oval-wuwa-may-2026-1",
    "date": "2026-05-30",
    "time": "",
    "until": "",
    "category": "festival",
    "status": "draft",
    "flag": "🇯🇵",
    "title": {
      "ko": "OVAL SISTEM · 명조 2주년 페스티벌 · 1일차",
      "ja": "OVAL SISTEM · 鳴潮2nd Anniversary Fes. · DAY 1",
      "en": "OVAL SISTEM · Wuthering Waves 2nd Anniversary Fes. · Day 1"
    },
    "venue": "幕張メッセ 国際展示場9ホール, 치바",
    "city": {
      "ko": "일본",
      "ja": "日本",
      "en": "Japan"
    },
    "desc": {
      "ko": "정확한 무대 출연 시각 미확인",
      "ja": "公開前の確認用データです。",
      "en": "Draft entry pending review."
    },
    "source": "https://ovalsistem.work/news/",
    "ticket": "",
    "_internal": {
      "series": "festival",
      "evidence": "date-confirmed",
      "created_from": "GitHub draft/oval-schedule-post-tabata-2026",
      "is_published": false
    }
  },
  {
    "id": "oval-wuwa-may-2026-2",
    "date": "2026-05-31",
    "time": "",
    "until": "",
    "category": "festival",
    "status": "draft",
    "flag": "🇯🇵",
    "title": {
      "ko": "OVAL SISTEM · 명조 2주년 페스티벌 · 2일차",
      "ja": "OVAL SISTEM · 鳴潮2nd Anniversary Fes. · DAY 2",
      "en": "OVAL SISTEM · Wuthering Waves 2nd Anniversary Fes. · Day 2"
    },
    "venue": "幕張メッセ 国際展示場9ホール, 치바",
    "city": {
      "ko": "일본",
      "ja": "日本",
      "en": "Japan"
    },
    "desc": {
      "ko": "정확한 무대 출연 시각 미확인",
      "ja": "公開前の確認用データです。",
      "en": "Draft entry pending review."
    },
    "source": "https://ovalsistem.work/news/",
    "ticket": "",
    "_internal": {
      "series": "festival",
      "evidence": "date-confirmed",
      "created_from": "GitHub draft/oval-schedule-post-tabata-2026",
      "is_published": false
    }
  },
  {
    "id": "oval-kichijoji-2026-4",
    "date": "2026-06-07",
    "time": "18:30",
    "until": "",
    "category": "live",
    "status": "draft",
    "flag": "🇯🇵",
    "title": {
      "ko": "OVAL SISTEM · 당신과 나의 키치조지 Vol.4",
      "ja": "OVAL SISTEM 吉祥寺シリーズ「あなたと私の吉祥寺」Vol.4",
      "en": "OVAL SISTEM · Anata to Watashi no Kichijoji Vol.4"
    },
    "venue": "KICHIJOJI SHUFFLE, 도쿄",
    "city": {
      "ko": "일본",
      "ja": "日本",
      "en": "Japan"
    },
    "desc": {
      "ko": "공연 날짜와 세부 정보는 출처에서 확인하세요. 등록 전 확인 필요.",
      "ja": "公開前の確認用データです。",
      "en": "Draft entry pending review."
    },
    "source": "https://teapawt.net/OVAL_SISTEM?filter=highlights",
    "ticket": "",
    "_internal": {
      "series": "kichijoji",
      "evidence": "confirmed",
      "created_from": "GitHub draft/oval-schedule-post-tabata-2026",
      "is_published": false
    }
  },
  {
    "id": "oval-kichijoji-2026-5",
    "date": "2026-07-11",
    "time": "18:30",
    "until": "",
    "category": "live",
    "status": "draft",
    "flag": "🇯🇵",
    "title": {
      "ko": "OVAL SISTEM · 당신과 나의 키치조지 Vol.5",
      "ja": "OVAL SISTEM 吉祥寺シリーズ「あなたと私の吉祥寺」Vol.5",
      "en": "OVAL SISTEM · Anata to Watashi no Kichijoji Vol.5"
    },
    "venue": "KICHIJOJI SHUFFLE, 도쿄",
    "city": {
      "ko": "일본",
      "ja": "日本",
      "en": "Japan"
    },
    "desc": {
      "ko": "공연 날짜와 세부 정보는 출처에서 확인하세요. 등록 전 확인 필요.",
      "ja": "公開前の確認用データです。",
      "en": "Draft entry pending review."
    },
    "source": "https://teapawt.net/OVAL_SISTEM?filter=highlights",
    "ticket": "",
    "_internal": {
      "series": "kichijoji",
      "evidence": "confirmed",
      "created_from": "GitHub draft/oval-schedule-post-tabata-2026",
      "is_published": false
    }
  },
  {
    "id": "oval-kichijoji-2026-6",
    "date": "2026-07-18",
    "time": "18:30",
    "until": "",
    "category": "live",
    "status": "draft",
    "flag": "🇯🇵",
    "title": {
      "ko": "OVAL SISTEM · 당신과 나의 키치조지 Vol.6",
      "ja": "OVAL SISTEM 吉祥寺シリーズ「あなたと私の吉祥寺」Vol.6",
      "en": "OVAL SISTEM · Anata to Watashi no Kichijoji Vol.6"
    },
    "venue": "KICHIJOJI SHUFFLE, 도쿄",
    "city": {
      "ko": "일본",
      "ja": "日本",
      "en": "Japan"
    },
    "desc": {
      "ko": "공연 날짜와 세부 정보는 출처에서 확인하세요. 등록 전 확인 필요.",
      "ja": "公開前の確認用データです。",
      "en": "Draft entry pending review."
    },
    "source": "https://teapawt.net/OVAL_SISTEM?filter=highlights",
    "ticket": "",
    "_internal": {
      "series": "kichijoji",
      "evidence": "confirmed",
      "created_from": "GitHub draft/oval-schedule-post-tabata-2026",
      "is_published": false
    }
  },
  {
    "id": "oval-seoul-20260726-1",
    "date": "2026-07-26",
    "time": "12:20",
    "until": "",
    "category": "live",
    "status": "draft",
    "flag": "🇰🇷",
    "title": {
      "ko": "스미다 아이코 × 모치즈키 루카 · 서울 조인트 콘서트 · 1부",
      "ja": "住田愛子 × 望月琉叶 Special Joint Concert in SEOUL 第1部",
      "en": "Sumida Aiko × Mochizuki Ruka · Joint Concert in Seoul · Part 1"
    },
    "venue": "퍼플노이즈 라이브홀, 서울",
    "city": {
      "ko": "한국 · 서울",
      "ja": "韓国・ソウル",
      "en": "Seoul, Korea"
    },
    "desc": {
      "ko": "OVAL SISTEM 단체 무대가 아니라 두 보컬의 조인트 콘서트 1부",
      "ja": "公開前の確認用データです。",
      "en": "Draft entry pending review."
    },
    "source": "https://www.ticketlink.co.kr/help/notice/64926",
    "ticket": "",
    "_internal": {
      "series": "seoul",
      "evidence": "confirmed",
      "created_from": "GitHub draft/oval-schedule-post-tabata-2026",
      "is_published": false
    }
  },
  {
    "id": "oval-seoul-20260726-2",
    "date": "2026-07-26",
    "time": "17:00",
    "until": "",
    "category": "live",
    "status": "draft",
    "flag": "🇰🇷",
    "title": {
      "ko": "OVAL SISTEM · LIVE IN SEOUL 2026 · 2부",
      "ja": "OVAL SISTEM LIVE IN SEOUL 2026 第2部",
      "en": "OVAL SISTEM LIVE IN SEOUL 2026 · Part 2"
    },
    "venue": "퍼플노이즈 라이브홀, 서울",
    "city": {
      "ko": "한국 · 서울",
      "ja": "韓国・ソウル",
      "en": "Seoul, Korea"
    },
    "desc": {
      "ko": "2부는 OVAL SISTEM 라이브",
      "ja": "公開前の確認用データです。",
      "en": "Draft entry pending review."
    },
    "source": "https://www.ticketlink.co.kr/help/notice/64926",
    "ticket": "",
    "_internal": {
      "series": "seoul",
      "evidence": "confirmed",
      "created_from": "GitHub draft/oval-schedule-post-tabata-2026",
      "is_published": false
    }
  },
  {
    "id": "oval-kichijoji-2026-7",
    "date": "2026-08-02",
    "time": "18:30",
    "until": "",
    "category": "live",
    "status": "draft",
    "flag": "🇯🇵",
    "title": {
      "ko": "OVAL SISTEM · 당신과 나의 키치조지 Vol.7",
      "ja": "OVAL SISTEM 吉祥寺シリーズ「あなたと私の吉祥寺」Vol.7",
      "en": "OVAL SISTEM · Anata to Watashi no Kichijoji Vol.7"
    },
    "venue": "KICHIJOJI SHUFFLE, 도쿄",
    "city": {
      "ko": "일본",
      "ja": "日本",
      "en": "Japan"
    },
    "desc": {
      "ko": "공연 날짜와 세부 정보는 출처에서 확인하세요. 등록 전 확인 필요.",
      "ja": "公開前の確認用データです。",
      "en": "Draft entry pending review."
    },
    "source": "https://teapawt.net/OVAL_SISTEM?filter=highlights",
    "ticket": "",
    "_internal": {
      "series": "kichijoji",
      "evidence": "confirmed",
      "created_from": "GitHub draft/oval-schedule-post-tabata-2026",
      "is_published": false
    }
  },
  {
    "id": "oval-kichijoji-2026-8",
    "date": "2026-08-16",
    "time": "18:30",
    "until": "",
    "category": "live",
    "status": "draft",
    "flag": "🇯🇵",
    "title": {
      "ko": "OVAL SISTEM · 당신과 나의 키치조지 Vol.8",
      "ja": "OVAL SISTEM 吉祥寺シリーズ「あなたと私の吉祥寺」Vol.8",
      "en": "OVAL SISTEM · Anata to Watashi no Kichijoji Vol.8"
    },
    "venue": "KICHIJOJI SHUFFLE, 도쿄",
    "city": {
      "ko": "일본",
      "ja": "日本",
      "en": "Japan"
    },
    "desc": {
      "ko": "공연 날짜와 세부 정보는 출처에서 확인하세요. 등록 전 확인 필요.",
      "ja": "公開前の確認用データです。",
      "en": "Draft entry pending review."
    },
    "source": "https://teapawt.net/OVAL_SISTEM?filter=highlights",
    "ticket": "",
    "_internal": {
      "series": "kichijoji",
      "evidence": "confirmed",
      "created_from": "GitHub draft/oval-schedule-post-tabata-2026",
      "is_published": false
    }
  },
  {
    "id": "oval-kichijoji-2026-9",
    "date": "2026-09-06",
    "time": "12:00",
    "until": "",
    "category": "live",
    "status": "draft",
    "flag": "🇯🇵",
    "title": {
      "ko": "OVAL SISTEM · 당신과 나의 키치조지 Vol.9",
      "ja": "OVAL SISTEM 吉祥寺シリーズ「あなたと私の吉祥寺」Vol.9",
      "en": "OVAL SISTEM · Anata to Watashi no Kichijoji Vol.9"
    },
    "venue": "KICHIJOJI SHUFFLE, 도쿄",
    "city": {
      "ko": "일본",
      "ja": "日本",
      "en": "Japan"
    },
    "desc": {
      "ko": "공연 날짜와 세부 정보는 출처에서 확인하세요. 등록 전 확인 필요.",
      "ja": "公開前の確認用データです。",
      "en": "Draft entry pending review."
    },
    "source": "https://teapawt.net/OVAL_SISTEM?filter=highlights",
    "ticket": "",
    "_internal": {
      "series": "kichijoji",
      "evidence": "confirmed",
      "created_from": "GitHub draft/oval-schedule-post-tabata-2026",
      "is_published": false
    }
  },
  {
    "id": "oval-kichijoji-2026-10",
    "date": "2026-10-03",
    "time": "12:00",
    "until": "",
    "category": "live",
    "status": "draft",
    "flag": "🇯🇵",
    "title": {
      "ko": "OVAL SISTEM · 당신과 나의 키치조지 Vol.10",
      "ja": "OVAL SISTEM 吉祥寺シリーズ「あなたと私の吉祥寺」Vol.10",
      "en": "OVAL SISTEM · Anata to Watashi no Kichijoji Vol.10"
    },
    "venue": "KICHIJOJI SHUFFLE, 도쿄",
    "city": {
      "ko": "일본",
      "ja": "日本",
      "en": "Japan"
    },
    "desc": {
      "ko": "공연 날짜와 세부 정보는 출처에서 확인하세요. 등록 전 확인 필요.",
      "ja": "公開前の確認用データです。",
      "en": "Draft entry pending review."
    },
    "source": "https://teapawt.net/OVAL_SISTEM?filter=highlights",
    "ticket": "",
    "_internal": {
      "series": "kichijoji",
      "evidence": "confirmed",
      "created_from": "GitHub draft/oval-schedule-post-tabata-2026",
      "is_published": false
    }
  },
  {
    "id": "oval-kichijoji-2026-11",
    "date": "2026-10-31",
    "time": "18:30",
    "until": "",
    "category": "live",
    "status": "draft",
    "flag": "🇯🇵",
    "title": {
      "ko": "OVAL SISTEM · 당신과 나의 키치조지 Vol.11",
      "ja": "OVAL SISTEM 吉祥寺シリーズ「あなたと私の吉祥寺」Vol.11",
      "en": "OVAL SISTEM · Anata to Watashi no Kichijoji Vol.11"
    },
    "venue": "KICHIJOJI SHUFFLE, 도쿄",
    "city": {
      "ko": "일본",
      "ja": "日本",
      "en": "Japan"
    },
    "desc": {
      "ko": "시리즈 최종 공연",
      "ja": "公開前の確認用データです。",
      "en": "Draft entry pending review."
    },
    "source": "https://teapawt.net/OVAL_SISTEM?filter=highlights",
    "ticket": "",
    "_internal": {
      "series": "kichijoji",
      "evidence": "confirmed",
      "created_from": "GitHub draft/oval-schedule-post-tabata-2026",
      "is_published": false
    }
  },
  {
    "id": "oval-tokorofes-20261114",
    "date": "2026-11-14",
    "time": "16:00",
    "until": "",
    "category": "festival",
    "status": "draft",
    "flag": "🇯🇵",
    "title": {
      "ko": "OVAL SISTEM · 도코로 씨의 페스",
      "ja": "OVAL SISTEM · 所さんのフェス～用事ないなら、みんな来てよLIVE～",
      "en": "OVAL SISTEM · Tokoro-san Festival"
    },
    "venue": "大田区民ホール・アプリコ 大ホール, 도쿄",
    "city": {
      "ko": "일본",
      "ja": "日本",
      "en": "Japan"
    },
    "desc": {
      "ko": "공연 날짜와 세부 정보는 출처에서 확인하세요. 등록 전 확인 필요.",
      "ja": "公開前の確認用データです。",
      "en": "Draft entry pending review."
    },
    "source": "https://ovalsistem.work/schedule/",
    "ticket": "",
    "_internal": {
      "series": "festival",
      "evidence": "confirmed",
      "created_from": "GitHub draft/oval-schedule-post-tabata-2026",
      "is_published": false
    }
  },
  {
    "id": "oval-hppfes-20261227",
    "date": "2026-12-27",
    "time": "13:30",
    "until": "",
    "category": "festival",
    "status": "draft",
    "flag": "🇯🇵",
    "title": {
      "ko": "OVAL SISTEM · HPP FES 2026 1st EDITION",
      "ja": "OVAL SISTEM · HPP FES 2026 1st EDITION",
      "en": "OVAL SISTEM · HPP FES 2026 1st EDITION"
    },
    "venue": "ESP Groove Lounge Tokyo",
    "city": {
      "ko": "일본",
      "ja": "日本",
      "en": "Japan"
    },
    "desc": {
      "ko": "공연 전체 개연 시간이며 OVAL SISTEM 단독 출연 시간 아님",
      "ja": "公開前の確認用データです。",
      "en": "Draft entry pending review."
    },
    "source": "https://ovalsistem.work/schedule/",
    "ticket": "",
    "_internal": {
      "series": "festival",
      "evidence": "confirmed",
      "created_from": "GitHub draft/oval-schedule-post-tabata-2026",
      "is_published": false
    }
  }
]
$aiko_drafts$::jsonb) AS entries(entry)
)
INSERT INTO aiko_internal.oval_calendar_drafts(entry_id,event_date,event_time,event_payload,evidence_status)
SELECT entry->>'id',(entry->>'date')::date,COALESCE(entry->>'time',''),entry,
       COALESCE(entry #>> '{_internal,evidence}', 'review')
FROM incoming
ON CONFLICT(entry_id) DO NOTHING;
COMMIT;

-- 실행 결과 확인용 (사이트 노출 없음)
SELECT COUNT(*) AS stored_draft_count,
       MIN(event_date) AS first_show,
       MAX(event_date) AS last_show
FROM aiko_internal.oval_calendar_drafts;
