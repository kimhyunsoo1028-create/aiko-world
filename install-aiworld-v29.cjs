/** AIKO WORLD v32 — rebuild ONLY the homepage banner from the approved reference.
 * Existing Netlify build command continues to call this installer after v28.
 * Consolidates the old four overlapping hero CSS versions into one clean style.
 * Does not modify site text, content database, events, photos, Supabase or admin.
 */
'use strict';
const fs=require('node:fs');
const path=require('node:path');
const root=process.cwd();
const home=path.join(root,'public','index.html');
const src=path.join(root,'hero-v32-clean.css');
const dst=path.join(root,'public','hero-v32-clean.css');
const bg=path.join(root,'public','images','hero-rent-maureen-bg.webp');
if(![home,src,bg].every(p=>fs.existsSync(p))) {
  throw new Error('AIKO WORLD v32: missing homepage, new stylesheet, or original RENT background');
}
let html=fs.readFileSync(home,'utf8');
if(!html.includes('class="hero-visual"')||!html.includes('photo-five')) {
  throw new Error('AIKO WORLD v32: v28 five-photo homepage is required; nothing changed');
}
if(!html.includes('</head>'))throw new Error('AIKO WORLD v32: HTML head was not found');
// Delete superseded *links only*: prevents legacy v28-v31 rules stacking up.
// Original element structure, page content and interactive controls remain intact.
html=html.replace(/<link\b[^>]*href=["'][^"']*hero-v(?:28|29-rent-bg|30-match-mockup|31-exact-target|32-clean)\.css[^"']*["'][^>]*>\s*/gi,'');
fs.copyFileSync(src,dst);
const tag='<link rel="stylesheet" href="hero-v32-clean.css?v=32.1">';
html=html.replace('</head>',tag+'\n</head>');
fs.writeFileSync(home,html,'utf8');
console.log('AIKO WORLD v32: reference homepage hero rebuilt with one stylesheet; all other site content preserved.');
