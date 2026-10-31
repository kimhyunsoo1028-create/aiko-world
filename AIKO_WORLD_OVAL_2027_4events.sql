-- AIKO WORLD · Four OVAL SISTEM events announced on 2026-10-31.
-- Venue and dates only; times and ticket details have not been announced.
-- Safe to re-run and preserves existing schedules; updates only site_content key=events.
WITH proposed AS (
  SELECT a.item
  FROM jsonb_array_elements($oval_schedule$
[
  {
    "id": "oval-2027-0122-waver",
    "date": "2027-01-22",
    "time": "",
    "until": "",
    "category": "live",
    "status": "confirmed",
    "flag": "🇯🇵",
    "title": {
      "ko": "OVAL SISTEM · 시모키타자와 WAVER",
      "ja": "OVAL SISTEM · 下北沢WAVER",
      "en": "OVAL SISTEM · Shimokitazawa WAVER"
    },
    "venue": "下北沢WAVER",
    "city": {
      "ko": "일본 · 도쿄 · 시모키타자와",
      "ja": "東京・下北沢",
      "en": "Shimokitazawa, Tokyo, Japan"
    },
    "desc": {
      "ko": "2026년 10월 31일 OVAL SISTEM 라이브 방송에서 발표된 일정. 날짜와 장소만 발표되었으며 공연 시작 시간, 티켓 및 세부사항은 추후 공지 예정입니다.",
      "ja": "2026年10月31日のOVAL SISTEMライブ配信で発表された日程です。開演時間、チケット、詳細は後日発表予定です。",
      "en": "Announced on the OVAL SISTEM livestream on 31 October 2026. Show times, tickets and further details are to be announced."
    },
    "source": "",
    "ticket": ""
  },
  {
    "id": "oval-2027-0202-rokudemonai-yoru",
    "date": "2027-02-02",
    "time": "",
    "until": "",
    "category": "live",
    "status": "confirmed",
    "flag": "🇯🇵",
    "title": {
      "ko": "OVAL SISTEM · 시모키타자와 로쿠데모나이 요루",
      "ja": "OVAL SISTEM · 下北沢ろくでもない夜",
      "en": "OVAL SISTEM · Shimokitazawa Rokudemonai Yoru"
    },
    "venue": "下北沢ろくでもない夜",
    "city": {
      "ko": "일본 · 도쿄 · 시모키타자와",
      "ja": "東京・下北沢",
      "en": "Shimokitazawa, Tokyo, Japan"
    },
    "desc": {
      "ko": "2026년 10월 31일 OVAL SISTEM 라이브 방송에서 발표된 일정. 날짜와 장소만 발표되었으며 공연 시작 시간, 티켓 및 세부사항은 추후 공지 예정입니다.",
      "ja": "2026年10月31日のOVAL SISTEMライブ配信で発表された日程です。開演時間、チケット、詳細は後日発表予定です。",
      "en": "Announced on the OVAL SISTEM livestream on 31 October 2026. Show times, tickets and further details are to be announced."
    },
    "source": "",
    "ticket": ""
  },
  {
    "id": "oval-2027-0220-daisybar",
    "date": "2027-02-20",
    "time": "",
    "until": "",
    "category": "live",
    "status": "confirmed",
    "flag": "🇯🇵",
    "title": {
      "ko": "OVAL SISTEM · 시모키타자와 DaisyBar",
      "ja": "OVAL SISTEM · 下北沢DaisyBar",
      "en": "OVAL SISTEM · Shimokitazawa DaisyBar"
    },
    "venue": "下北沢DaisyBar",
    "city": {
      "ko": "일본 · 도쿄 · 시모키타자와",
      "ja": "東京・下北沢",
      "en": "Shimokitazawa, Tokyo, Japan"
    },
    "desc": {
      "ko": "2026년 10월 31일 OVAL SISTEM 라이브 방송에서 발표된 일정. 날짜와 장소만 발표되었으며 공연 시작 시간, 티켓 및 세부사항은 추후 공지 예정입니다.",
      "ja": "2026年10月31日のOVAL SISTEMライブ配信で発表された日程です。開演時間、チケット、詳細は後日発表予定です。",
      "en": "Announced on the OVAL SISTEM livestream on 31 October 2026. Show times, tickets and further details are to be announced."
    },
    "source": "",
    "ticket": ""
  },
  {
    "id": "oval-2027-0227-holic",
    "date": "2027-02-27",
    "time": "",
    "until": "",
    "category": "live",
    "status": "confirmed",
    "flag": "🇯🇵",
    "title": {
      "ko": "OVAL SISTEM · 시모키타자와 HOLiC",
      "ja": "OVAL SISTEM · 下北沢HOLiC",
      "en": "OVAL SISTEM · Shimokitazawa HOLiC"
    },
    "venue": "下北沢HOLiC",
    "city": {
      "ko": "일본 · 도쿄 · 시모키타자와",
      "ja": "東京・下北沢",
      "en": "Shimokitazawa, Tokyo, Japan"
    },
    "desc": {
      "ko": "2026년 10월 31일 OVAL SISTEM 라이브 방송에서 발표된 일정. 날짜와 장소만 발표되었으며 공연 시작 시간, 티켓 및 세부사항은 추후 공지 예정입니다.",
      "ja": "2026年10月31日のOVAL SISTEMライブ配信で発表された日程です。開演時間、チケット、詳細は後日発表予定です。",
      "en": "Announced on the OVAL SISTEM livestream on 31 October 2026. Show times, tickets and further details are to be announced."
    },
    "source": "",
    "ticket": ""
  }
]
$oval_schedule$::jsonb) AS a(item)
), existing AS (
  SELECT payload FROM public.site_content
  WHERE key='events' AND jsonb_typeof(payload)='array'
), pending AS (
  SELECT proposed.item FROM proposed, existing
  WHERE NOT EXISTS (
    SELECT 1 FROM jsonb_array_elements(existing.payload) old
    WHERE old->>'id'=proposed.item->>'id'
       OR (old->>'date'=proposed.item->>'date'
       AND lower(btrim(old->>'venue'))=lower(btrim(proposed.item->>'venue')))
  )
), to_append AS (
  SELECT coalesce(jsonb_agg(item ORDER BY item->>'date'), '[]'::jsonb) AS payload FROM pending
)
UPDATE public.site_content sc
SET payload=sc.payload || to_append.payload,
    updated_at=now()
FROM to_append
WHERE sc.key='events'
  AND jsonb_typeof(sc.payload)='array'
  AND jsonb_array_length(to_append.payload)>0;

SELECT e->>'date' AS date,e->>'venue' AS venue,e->>'time' AS time,e->>'id' AS id
FROM public.site_content sc
CROSS JOIN LATERAL jsonb_array_elements(
  CASE WHEN jsonb_typeof(sc.payload)='array' THEN sc.payload ELSE '[]'::jsonb END
) AS e
WHERE sc.key='events' AND e->>'id' IN ('oval-2027-0122-waver','oval-2027-0202-rokudemonai-yoru','oval-2027-0220-daisybar','oval-2027-0227-holic')
ORDER BY date;
