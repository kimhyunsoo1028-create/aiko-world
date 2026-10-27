/* Non-destructive installer. Run AFTER extracting base website into public/. */
'use strict';
const fs=require('node:fs');
for(const {file,style,script} of [
 {file:'public/index.html',style:'concert-stories.css',script:'concert-stories.js'},
 {file:'public/admin/index.html',style:'concert-stories-admin.css',script:'concert-stories-admin.mjs'}
]){
 if(!fs.existsSync(file))throw new Error('기존 홈페이지 파일을 찾지 못했습니다: '+file+' (배포 순서를 확인하세요)');
 let html=fs.readFileSync(file,'utf8');
 const head=`<link rel="stylesheet" href="${style}">`;
 const foot=file.startsWith('public/admin/')?`<script type="module" src="${script}"></script>`:`<script src="${script}" defer></script>`;
 if(!html.includes(head)) {if(!html.includes('</head>'))throw new Error('HTML head가 없음: '+file);html=html.replace('</head>',head+'\n</head>')}
 if(!html.includes(foot)) {if(!html.includes('</body>'))throw new Error('HTML body가 없음: '+file);html=html.replace('</body>',foot+'\n</body>')}
 fs.writeFileSync(file,html);console.log('[AIKO WORLD v2.2] installed',file);
}
