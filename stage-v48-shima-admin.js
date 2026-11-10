/* AIKO WORLD v48: repair Shima Fes visibility in the unified performance admin.
 * Leaves all Supabase rows unchanged. Adds a missing legacy catalog reference and
 * reloads the unified list on tab activation so new records do not remain hidden.
 */
(function () {
  'use strict';
  const SHOW_ID = 'shima-fes-2026-05-02';
  const reference = {
    id: SHOW_ID,
    date: '2026-05-02',
    time: '20:15',
    title: 'OVAL SISTEM · シマフェス',
    series: 'festival',
    venue: 'unravel tokyo (六本木), 도쿄',
    city: '東京・六本木',
    source: 'https://financie.jp/communities/25/activity_log?page=5',
    description: '2026년 5월 2일 OVAL SISTEM 시마페스 게스트 출연. 17:00 개장, 17:30 개연, OVAL SISTEM 20:15~21:05.',
    status: 'confirmed',
    setlist: [],
    setsrc: '',
    media: [],
    solo: false
  };
  function install() {
    const catalog = window.AIKO_PERFORMANCES;
    if (Array.isArray(catalog) && !catalog.some(x => x && (x.id === SHOW_ID ||
         (x.date === reference.date && /시마페스|シマフェス|Shima Fes/i.test(String(x.title || '')))))) {
      catalog.push(reference);
    }
    const tab = document.querySelector('#tabs [data-tab="stagehub"]');
    const reload = document.getElementById('s27-refresh');
    if (tab && reload && !tab.dataset.aikoV48Refresh) {
      tab.dataset.aikoV48Refresh = 'installed';
      tab.addEventListener('click', () => {
        window.setTimeout(() => document.getElementById('s27-refresh')?.click(), 300);
      });
    }
    return Array.isArray(catalog) && !!tab && !!reload;
  }
  let attempts = 0;
  const poll = window.setInterval(() => {
    if (install() || ++attempts >= 80) window.clearInterval(poll);
  }, 250);
  install();
})();
