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
// v30 visual correction runs after v29 without requiring a new Netlify command.
const v30 = path.join(root, 'hero-v30-match-mockup.css');
if (fs.existsSync(v30)) {
  fs.copyFileSync(v30, path.join(site, 'hero-v30-match-mockup.css'));
  const v30Tag = '<link rel="stylesheet" href="hero-v30-match-mockup.css?v=30.2">';
  const v30Link = /<link\b[^>]*href=["'][^"']*hero-v30-match-mockup\.css[^"']*["'][^>]*>/i;
  if (v30Link.test(html)) html = html.replace(v30Link, v30Tag);
  else html = html.replace('</head>', v30Tag + '\n</head>');
}
// v31: replace approximate v30 framing with the approved reference composition.
// Loaded LAST so all older v28-v30 CSS can coexist without removing any CMS content.
const v31 = path.join(root, 'hero-v31-exact-target.css');
if (!fs.existsSync(v31)) throw new Error('v31 stylesheet missing from GitHub checkout');
fs.copyFileSync(v31, path.join(site, 'hero-v31-exact-target.css'));
const v31Tag = '<link rel="stylesheet" href="hero-v31-exact-target.css?v=31.2">';
const v31Link = /<link\b[^>]*href=["'][^"']*hero-v31-exact-target\.css[^"']*["'][^>]*>/i;
if (v31Link.test(html)) html = html.replace(v31Link, v31Tag);
else html = html.replace('</head>', v31Tag + '\n</head>');
fs.writeFileSync(page, html, 'utf8');
console.log('AIKO WORLD v31: approved reference matched; previous data, calendar and five photos preserved.');
