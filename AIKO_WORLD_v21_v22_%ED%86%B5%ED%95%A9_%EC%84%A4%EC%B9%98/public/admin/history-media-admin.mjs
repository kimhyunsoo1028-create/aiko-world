/* 愛子 WORLD · Timeline Media Admin. Isolated from events, gallery and broadcast links. */
await (window.AIKO_CMS_READY || Promise.resolve());
const root=document.getElementById('dashboard');
const nav=document.getElementById('tabs');
const cfg=window.AIKO_CMS_CONFIG||{};
if(root && nav && !document.querySelector('[data-pane="historymedia"]')){
  const tab=document.createElement('button');tab.type='button';tab.dataset.tab='historymedia';tab.textContent='🎞️ 발자취 사진·영상';nav.append(tab);
  const section=document.createElement('section');section.className='panel pane';section.dataset.pane='historymedia';section.hidden=true;
  section.innerHTML=`<div class="section-head"><div><h2>🎞️ 이어지는 시간, 쌓이는 노래 · 미디어</h2><p>사진을 업로드하거나 유튜브·영상 주소를 등록하면 발자취 섹션에 카드가 표시됩니다. 다른 방송 영상 링크와 공연 일정에는 영향을 주지 않습니다.</p></div><a href="../#history-media-archive" target="_blank" rel="noopener noreferrer">홈페이지에서 보기 ↗</a></div>
<div class="layout"><aside><div class="actions"><button type="button" class="primary" id="hm-new">+ 사진·영상 추가</button><button type="button" id="hm-reload">새로고침</button></div><p class="muted" id="hm-count"></p><ul class="pick-list" id="hm-list"></ul></aside>
<form id="hm-form"><input type="hidden" name="id"><div class="two"><label>기록 날짜<input type="date" name="entry_date" required></label><label>자료 종류<select name="kind"><option value="photo">📷 사진</option><option value="video">▶ 영상 링크</option></select></label>
<label>제목 · 한국어<input name="title_ko" required maxlength="160"></label><label>제목 · 日本語<input name="title_ja" maxlength="160"></label><label>제목 · English<input name="title_en" maxlength="160"></label><label>사진·영상 출처 / 촬영자<input name="credit" maxlength="200" placeholder="예: 직접 촬영 / 공식 YouTube"></label></div>
<label>설명 · 한국어<textarea name="description_ko" rows="2" maxlength="1000"></textarea></label><label>설명 · 日本語<textarea name="description_ja" rows="2" maxlength="1000"></textarea></label><label>설명 · English<textarea name="description_en" rows="2" maxlength="1000"></textarea></label>
<label id="hm-url-label">사진 이미지 주소 (https://) / 영상 주소 (YouTube 등)<input name="media_url" type="url" placeholder="https://..." required></label>
<label id="hm-upload-label">사진 파일 업로드 (JPG / PNG / WebP, 최대 5MB)<input id="hm-upload" type="file" accept="image/jpeg,image/png,image/webp"></label>
<div class="hm-preview" id="hm-preview" aria-live="polite"></div>
<label class="hm-publish"><input name="is_published" type="checkbox" checked> 방문자에게 공개</label>
<div class="actions"><button type="submit" class="primary" id="hm-save">저장 · 발자취에 반영</button><button type="button" class="danger" id="hm-delete">선택 기록 삭제</button></div>
<p class="video-tip">동영상 파일은 직접 업로드하지 않고 YouTube 등 HTTPS 링크를 연결합니다. 사진은 관리자용 Supabase Storage를 사용합니다. 저작권 또는 촬영 허락이 있는 자료만 게시하세요.</p><p id="hm-status" role="status" aria-live="polite" class="status"></p></form></div>`;
  const globalStatus=document.getElementById('status');globalStatus?.before(section);
  const $=id=>document.getElementById(id);
  const form=$('hm-form');
  const field=k=>form.elements.namedItem(k);
  const get=k=>String(field(k)?.value||'').trim();
  const status=(message,error=false)=>{$('hm-status').textContent=message;$('hm-status').className=error?'status error':'status'};
  let client=null,records=[],editing=null;
  async function sessionClient(){
    if(!/^https:\/\/[a-z0-9-]+\.supabase\.co\/?$/i.test(cfg.url||'')||!cfg.publishableKey)throw new Error('Supabase 공개 설정이 없습니다. 사이트 관리자 로그인을 확인하세요.');
    if(!client){const {createClient}=await import('https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2/+esm');client=createClient(cfg.url,cfg.publishableKey,{auth:{persistSession:true,autoRefreshToken:true}})}
    const {data:{user},error}=await client.auth.getUser();if(error||!user)throw new Error('먼저 관리자 로그인을 해주세요.');
    const {data, error:memberError}=await client.from('site_admins').select('user_id').eq('user_id',user.id).maybeSingle();if(memberError||!data)throw new Error('이 계정에는 관리자 권한이 없습니다.');
    return client;
  }
  function safeUrl(v){try{const u=new URL(String(v));return u.protocol==='https:'&&!u.username&&!u.password?u.href:null}catch{return null}}
  function showPreview(){const box=$('hm-preview');box.replaceChildren();const url=safeUrl(get('media_url'));if(!url)return;
    if(get('kind')==='photo'){const img=document.createElement('img');img.src=url;img.alt='업로드 사진 미리보기';box.append(img)}
    else{const a=document.createElement('a');a.href=url;a.target='_blank';a.rel='noopener noreferrer';a.textContent='등록할 영상 링크 미리 열기 ↗';box.append(a)}
  }
  function toggleKind(){const photo=get('kind')==='photo';$('hm-upload-label').hidden=!photo;$('hm-url-label').firstChild.textContent=photo?'사진 주소 (https://)':'영상 주소 (YouTube·Vimeo·공식 동영상 페이지 https://)';showPreview()}
  function fill(row){editing=row?.id||null;form.reset();for(const k of ['id','entry_date','kind','title_ko','title_ja','title_en','description_ko','description_ja','description_en','credit','media_url']){
    if(field(k))field(k).value=row?.[k]|| (k==='kind'?'photo':'')}
    field('is_published').checked=row?!!row.is_published:true;toggleKind();
    $('hm-delete').disabled=!editing;
    [...$('hm-list').querySelectorAll('button')].forEach(b=>b.classList.toggle('active',b.dataset.id===editing));
  }
  function list(){const ul=$('hm-list');ul.replaceChildren();$('hm-count').textContent=`${records.length}개의 기록`;
    for(const row of records){const li=document.createElement('li');const btn=document.createElement('button');btn.type='button';btn.dataset.id=row.id;btn.textContent=`${row.kind==='photo'?'📷':'🎬'} ${row.title_ko||row.title_ja||'제목 없음'}`;const small=document.createElement('small');small.textContent=`${row.entry_date} · ${row.is_published?'공개':'비공개'}`;btn.append(small);btn.addEventListener('click',()=>fill(row));li.append(btn);ul.append(li)}
    if(editing){fill(records.find(x=>x.id===editing)||null)}else if(records.length)fill(records[0]);else fill(null);
  }
  async function refresh(){try{await sessionClient();status('발자취 미디어 불러오는 중…');const {data,error}=await client.from('history_media').select('*').order('entry_date',{ascending:false}).order('created_at',{ascending:false}).limit(500);if(error)throw error;records=data||[];list();status('✅ 연결 완료. 기존 공연 일정·방송 영상 링크는 변경되지 않습니다.')}catch(e){status('불러오기 오류: '+e.message,true)}}
  $('hm-new').addEventListener('click',()=>{fill(null);status('새 자료를 입력하세요. 사진은 먼저 업로드 후 저장합니다.')});
  $('hm-reload').addEventListener('click',refresh);
  field('kind').addEventListener('change',toggleKind);
  field('media_url').addEventListener('input',showPreview);
  $('hm-upload').addEventListener('change',async(e)=>{const file=e.target.files?.[0];if(!file)return;
    try{await sessionClient();if(file.size>5*1024*1024)throw new Error('파일 크기가 5 MB를 초과합니다.');const ext={'image/jpeg':'jpg','image/png':'png','image/webp':'webp'}[file.type];if(!ext)throw new Error('JPG, PNG, WebP만 업로드할 수 있습니다.');
      $('hm-upload').disabled=true;status('이미지 업로드 중…');const path=`history/${crypto.randomUUID()}.${ext}`;
      const {error}=await client.storage.from('site-media').upload(path,file,{contentType:file.type,upsert:false});if(error)throw error;
      const {data}=client.storage.from('site-media').getPublicUrl(path);field('media_url').value=data.publicUrl;showPreview();status('✅ 사진 업로드 완료. 아래의 저장 버튼을 눌러 발자취에 공개하세요.');
    }catch(e){status('사진 업로드 오류: '+e.message,true)}finally{$('hm-upload').disabled=false}
  });
  form.addEventListener('submit',async(e)=>{e.preventDefault();const btn=$('hm-save');try{await sessionClient();const url=safeUrl(get('media_url'));if(!url)throw new Error('HTTPS 형식의 사진 또는 영상 주소를 입력하세요.');
    const date=get('entry_date');if(!/^\d{4}-\d{2}-\d{2}$/.test(date)||Number.isNaN(Date.parse(date+'T12:00:00Z')))throw new Error('기록 날짜를 확인하세요.');
    if(!get('title_ko'))throw new Error('한국어 제목을 입력하세요.');
    const row={entry_date:date,kind:get('kind'),title_ko:get('title_ko'),title_ja:get('title_ja'),title_en:get('title_en'),description_ko:get('description_ko'),description_ja:get('description_ja'),description_en:get('description_en'),credit:get('credit'),media_url:url,is_published:field('is_published').checked,updated_at:new Date().toISOString()};
    if(editing)row.id=editing;btn.disabled=true;status('저장 중…');const {data,error}=await client.from('history_media').upsert(row).select('id').single();if(error)throw error;editing=data.id;await refresh();status(`✅ ${row.is_published?'저장 및 공개 완료!':'비공개로 저장했습니다.'} 일반 홈페이지를 새로고침하면 확인할 수 있습니다.`);
    }catch(e){status('저장 실패: '+e.message,true)}finally{btn.disabled=false}
  });
  $('hm-delete').addEventListener('click',async()=>{if(!editing)return;if(!confirm('선택한 발자취 사진·영상 기록을 삭제하시겠습니까? 기존 사진 파일 자체는 삭제되지 않습니다.'))return;try{await sessionClient();const {error}=await client.from('history_media').delete().eq('id',editing);if(error)throw error;editing=null;await refresh();status('✅ 기록 삭제 완료.')}catch(e){status('삭제 실패: '+e.message,true)}});
  tab.addEventListener('click',refresh);
}
