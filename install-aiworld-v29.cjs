/** AIKO WORLD v34: one-step homepage hero application via EXISTING Netlify build command.
 * Reuses prior installer hook. Keeps every actual photo, site link, admin and CMS record.
 */
'use strict';
const fs=require('node:fs');
const path=require('node:path');
const root=process.cwd(),page=path.join(root,'public','index.html');
const source=path.join(root,'hero-v34-reference.css');
const original=path.join(root,'public','images','hero-rent-maureen-bg.webp');
if(![page,source,original].every(p=>fs.existsSync(p)))throw Error('v34: homepage or original hero asset missing');
let html=fs.readFileSync(page,'utf8');
if(!html.includes('class="hero-visual"')||!html.includes('photo-five')||!html.includes('</head>'))throw Error('v34: expected five-card homepage not present; aborting');
const obsolete=/<link\b[^>]*href=["'][^"']*hero-v(?:28|29-rent-bg|30-match-mockup|31-exact-target|32-clean|33-reference|34-reference)\.css[^"']*["'][^>]*>\s*/gi;
html=html.replace(obsolete,'');
fs.copyFileSync(source,path.join(root,'public','hero-v34-reference.css'));
html=html.replace('</head>','<link rel="stylesheet" href="hero-v34-reference.css?v=34.0">\n</head>');
fs.writeFileSync(page,html,'utf8');
console.log('[AIKO WORLD v34] Original homepage text and five photos preserved; new single hero style applied.');
