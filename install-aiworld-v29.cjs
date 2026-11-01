/** AIKO WORLD v29: fix barely visible RENT/Maureen homepage background.
 * Run AFTER v28 in Netlify Build command. Does not edit Supabase or other data.
 */
const fs = require('fs');
const path = require('path');
const root = process.cwd();
const site = path.join(root, 'public');
const page = path.join(site, 'index.html');
const source = path.join(root, 'hero-v29-rent-bg.css');
const oldBg = path.join(site, 'images', 'hero-rent-maureen-bg.webp');
if (![page, source, oldBg].every(file => fs.existsSync(file))) {
  throw new Error('v29: v28 installation or v29 stylesheet missing; check Build command order.');
}
let html = fs.readFileSync(page, 'utf8');
if (!html.includes('hero-v28.css') || !html.includes('photo-five')) {
  throw new Error('v29: v28 five-photo homepage is required.');
}
fs.copyFileSync(source, path.join(site, 'hero-v29-rent-bg.css'));
const tag = '<link rel="stylesheet" href="hero-v29-rent-bg.css?v=29.1">';
const oldLink = /<link\b[^>]*href=["'][^"']*hero-v29-rent-bg\.css[^"']*["'][^>]*>/i;
if (oldLink.test(html)) html = html.replace(oldLink, tag);
else html = html.replace('</head>', tag + '\n</head>');
fs.writeFileSync(page, html, 'utf8');
console.log('AIKO WORLD v29: background contrast and visibility corrected; 5 cards and all other content preserved.');
