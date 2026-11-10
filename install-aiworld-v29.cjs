/** AIKO WORLD v44 — single Netlify hook, homepage hero only.
 * Keeps site database, admin, event data and all five original card image references intact. */
'use strict';
const fs=require('node:fs'),path=require('node:path');
const root=process.cwd(),pub=path.join(root,'public');
const htmlPath=path.join(pub,'index.html');
const sourceCss=path.join(root,'hero-v44-reference.css');
const sourcePhoto=path.join(root,'images','maureen-rent-full-feather-v43.webp');
for(const file of [htmlPath,sourceCss,sourcePhoto]){
 if(!fs.existsSync(file))throw new Error('[AIKO v44] Required file missing: '+file);
}
let html=fs.readFileSync(htmlPath,'utf8');
if(!html.includes('hero-visual')||!html.includes('photo-five')||!html.includes('</head>')){
 throw new Error('[AIKO v44] Expected 5-photo home is missing; aborting');
}
const obsolete=/<link\b[^>]*href=["'][^"']*hero-v(?:28|29-rent-bg|30-match-mockup|31-exact-target|32-clean|33-reference|34-reference|35-adjustments|36-reference|37-reference|38-reference|39-reference|40-reference|41-reference|42-clean|43-original|44-original|44-reference)\.css(?:\?[^"']*)?["'][^>]*>\s*/gi;
html=html.replace(obsolete,'');
fs.mkdirSync(path.join(pub,'images'),{recursive:true});
fs.copyFileSync(sourceCss,path.join(pub,'hero-v44-reference.css'));
fs.copyFileSync(sourcePhoto,path.join(pub,'images','maureen-rent-full-feather-v43.webp'));
html=html.replace('</head>','<link rel="stylesheet" href="hero-v44-reference.css?v=44.0">\n</head>');
fs.writeFileSync(htmlPath,html,'utf8');
console.log('[AIKO WORLD v44] Hero CSS & background installed, other sections unchanged.');

/* AIKO WORLD v48: install the unified-manager refresh/reference overlay.
 * Does not alter homepage files, databases, or existing performance records. */
const shimSrc=path.join(root,'stage-v48-shima-admin.js');
const shimDir=path.join(pub,'admin');
const shimDest=path.join(shimDir,'stage-v48-shima-admin.js');
const adminIndex=path.join(shimDir,'index.html');
if(fs.existsSync(shimSrc)&&fs.existsSync(adminIndex)){
  fs.copyFileSync(shimSrc,shimDest);
  let adminHtml=fs.readFileSync(adminIndex,'utf8');
  if(!adminHtml.includes('stage-v48-shima-admin.js') && /<\/body>/i.test(adminHtml)){
    adminHtml=adminHtml.replace(/<\/body>/i,'<script defer src="./stage-v48-shima-admin.js?v=48"></script>\n</body>');
    fs.writeFileSync(adminIndex,adminHtml,'utf8');
  }
  console.log('[AIKO WORLD v48] Shima Fes admin reference and refresh overlay installed.');
}
