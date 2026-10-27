/* 愛子 WORLD | 「이어지는 시간, 쌓이는 노래」 사진·영상 미디어 (public/read-only) */
(() => {
  'use strict';
  const root = document.getElementById('history');
  if (!root || document.getElementById('history-media-archive')) return;
  const shell = document.createElement('section');
  shell.id = 'history-media-archive';
  shell.className = 'aiko-history-media';
  shell.setAttribute('aria-label', '발자취 사진·영상 기록');
  shell.innerHTML = `<div class="ahm-heading"><div><span class="ahm-eyebrow">PHOTO & VIDEO DIARY</span><h3 id="ahm-heading">사진과 영상으로 남긴 순간</h3><p id="ahm-intro">시간 속에 담긴 노래와 무대의 기록</p></div><span class="ahm-counter" id="ahm-counter"></span></div><div class="ahm-grid" id="ahm-grid"></div><p class="ahm-message" id="ahm-message" hidden></p>`;
  const anchor = root.querySelector('#era-intro');
  if(anchor) anchor.before(shell);
  else root.querySelector('.section-head')?.after(shell);
  const dialog = document.createElement('dialog');
  dialog.className = 'ahm-dialog';
  dialog.setAttribute('aria-label', '사진·영상 보기');
  dialog.innerHTML = `<div class="ahm-dialog-top"><strong id="ahm-dialog-title"></strong><button type="button" class="ahm-close" aria-label="닫기">✕</button></div><div id="ahm-dialog-content"></div><p id="ahm-dialog-caption"></p>`;
  document.body.appendChild(dialog);
  const grid=document.getElementById('ahm-grid');
  const msg=document.getElementById('ahm-message');
  const cfg=window.AIKO_CMS_CONFIG||{};
  let rows=[];
  let ready=false;
  const labels={
    ko:{title:'사진과 영상으로 남긴 순간',intro:'시간 속에 담긴 노래와 무대의 기록',photo:'사진',video:'영상',watch:'영상 보기',open:'관련 영상 열기',empty:'등록된 사진과 영상이 없습니다.',error:'미디어를 불러오지 못했습니다. 잠시 후 다시 확인해 주세요.',count:'개의 기록'},
    ja:{title:'写真と映像で残す瞬間',intro:'歌とステージの思い出を記録する場所',photo:'写真',video:'映像',watch:'映像を見る',open:'リンクを開く',empty:'写真・動画はまだ登録されていません。',error:'データを読み込めませんでした。',count:'件の記録'},
    en:{title:'Moments in photos and videos',intro:'A visual diary of songs, stages and memories',photo:'Photo',video:'Video',watch:'Watch video',open:'Open link',empty:'No photos or videos have been added yet.',error:'Media could not be loaded right now.',count:' memories'}
  };
  const lang=()=>['ko','ja','en'].includes(document.documentElement.lang)?document.documentElement.lang:'ko';
  const tx=x=>String(x??'');
  const safe=(url)=>{try{const u=new URL(tx(url));return u.protocol==='https:' && !u.username && !u.password && !/\s/.test(tx(url))?u.href:null}catch{return null}};
  const videoId=url=>{try{const u=new URL(url);let id='';if(u.hostname==='youtu.be')id=u.pathname.slice(1).split('/')[0];else if(['www.youtube.com','youtube.com','m.youtube.com','www.youtube-nocookie.com'].includes(u.hostname)){
    if(u.pathname==='/watch')id=u.searchParams.get('v')||'';
    else if(/^\/(shorts|live|embed)\//.test(u.pathname))id=u.pathname.split('/')[2]||'';
  }return /^[a-zA-Z0-9_-]{11}$/.test(id)?id:null}catch{return null}};
  const local=(row,k)=>tx(row[k+'_'+lang()]||row[k+'_ko']||row[k+'_ja']||row[k+'_en']);
  function render(){
    const l=labels[lang()];
    document.getElementById('ahm-heading').textContent=l.title;
    document.getElementById('ahm-intro').textContent=l.intro;
    document.getElementById('ahm-counter').textContent=ready&&rows.length?`${rows.length}${l.count}`:'';
    grid.replaceChildren();
    for(const item of rows){
      const url=safe(item.media_url);
      if(!url)continue;
      const card=document.createElement('article');card.className='ahm-card';
      const preview=document.createElement('button');preview.type='button';preview.className='ahm-preview';
      const thumbnail= document.createElement('img');
      const yt=videoId(url);
      const photo=item.kind==='photo';
      thumbnail.src=photo?url:yt?`https://i.ytimg.com/vi/${yt}/hqdefault.jpg`:'';
      thumbnail.alt=local(item,'title')|| (photo?l.photo:l.video);
      thumbnail.loading='lazy';
      if(photo||yt)preview.append(thumbnail);else{const fallback=document.createElement('span');fallback.className='ahm-no-thumb';fallback.textContent='▶ VIDEO';preview.append(fallback)}
      const mark=document.createElement('span');mark.className='ahm-type';mark.textContent=photo?'▣ '+l.photo:'▶ '+l.video;preview.append(mark);
      const info=document.createElement('div');info.className='ahm-info';
      const date=document.createElement('time');date.textContent=tx(item.entry_date||'').replaceAll('-','.');info.append(date);
      const title=document.createElement('h4');title.textContent=local(item,'title')||l.title;info.append(title);
      const caption=local(item,'description');if(caption){const p=document.createElement('p');p.textContent=caption;info.append(p)}
      const credit=tx(item.credit);if(credit){const small=document.createElement('small');small.textContent=credit;info.append(small)}
      const open=()=>{
        dialog.querySelector('#ahm-dialog-title').textContent=local(item,'title')||l.title;
        const holder=dialog.querySelector('#ahm-dialog-content');holder.replaceChildren();
        if(photo){const img=document.createElement('img');img.src=url;img.alt=local(item,'title');holder.append(img)}
        else if(yt){const iframe=document.createElement('iframe');iframe.src=`https://www.youtube-nocookie.com/embed/${yt}`;iframe.allow='accelerometer; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share';iframe.allowFullscreen=true;iframe.referrerPolicy='strict-origin-when-cross-origin';iframe.title=local(item,'title');holder.append(iframe)}
        else{const a=document.createElement('a');a.href=url;a.target='_blank';a.rel='noopener noreferrer';a.textContent=l.open;holder.append(a)}
        dialog.querySelector('#ahm-dialog-caption').textContent=caption;
        if(typeof dialog.showModal==='function')dialog.showModal();else window.open(url,'_blank','noopener,noreferrer');
      };
      preview.addEventListener('click',open);
      card.append(preview,info);grid.append(card);
    }
    if(ready&&!rows.length){msg.hidden=false;msg.textContent=l.empty}
    else if(rows.length){msg.hidden=true;msg.textContent=''}
  }
  dialog.querySelector('.ahm-close').addEventListener('click',()=>dialog.close());
  dialog.addEventListener('click',e=>{if(e.target===dialog)dialog.close()});
  dialog.addEventListener('close',()=>dialog.querySelector('#ahm-dialog-content').replaceChildren());
  (new MutationObserver(()=>render())).observe(document.documentElement,{attributes:true,attributeFilter:['lang']});
  (async()=>{
    await(window.AIKO_CMS_READY||Promise.resolve());
    const c=window.AIKO_CMS_CONFIG||cfg;
    if(!/^https:\/\/[a-z0-9-]+\.supabase\.co\/?$/i.test(c.url||'')||!c.publishableKey){ready=true;render();return}
    try{
      const ctrl=new AbortController();const timeout=setTimeout(()=>ctrl.abort(),7500);
      let response;
      try{response=await fetch(`${c.url.replace(/\/$/,'')}/rest/v1/history_media?select=*&is_published=eq.true&order=entry_date.desc,created_at.desc&limit=200`,{headers:{apikey:c.publishableKey,...(c.publishableKey.startsWith('eyJ')?{Authorization:'Bearer '+c.publishableKey}:{})},cache:'no-store',signal:ctrl.signal})}
      finally{clearTimeout(timeout)}
      if(!response.ok)throw new Error('HTTP '+response.status);
      const data=await response.json();rows=Array.isArray(data)?data:[];ready=true;render();
    }catch(err){ready=true;render();msg.hidden=false;msg.textContent=labels[lang()].error;console.warn('History media loading failed',err)}
  })();
})();
