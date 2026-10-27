/* Safely append add-on styles/scripts to the CURRENT generated site without replacing it. */
const fs=require('fs');
const changes=[
 {path:'public/index.html',head:'<link rel="stylesheet" href="history-media.css">',body:'<script src="history-media.js" defer></script>'},
 {path:'public/admin/index.html',head:'<link rel="stylesheet" href="history-media-admin.css">',body:'<script type="module" src="history-media-admin.mjs"></script>'}
];
for(const c of changes){
 if(!fs.existsSync(c.path))throw Error('사이트 HTML을 찾을 수 없습니다: '+c.path);
 let html=fs.readFileSync(c.path,'utf8');
 if(!html.includes(c.head)){
   if(!html.includes('</head>'))throw Error('head 태그가 없습니다: '+c.path);
   html=html.replace('</head>',c.head+'\n</head>');
 }
 if(!html.includes(c.body)){
   if(!html.includes('</body>'))throw Error('body 태그가 없습니다: '+c.path);
   html=html.replace('</body>',c.body+'\n</body>');
 }
 fs.writeFileSync(c.path,html);
 console.log('[AIKO WORLD] history media enabled: '+c.path);
}
