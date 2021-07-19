// Template Name: Affan - PWA Mobile HTML Template
// Template Author: Designing World
// Template Author URL: https://themeforest.net/user/designing-world

const staticCacheName = 'precache-v1';
const dynamicCacheName = 'runtimeCache-v1';

// Pre Caching Assets
const precacheAssets = [
    '/',
    'mobile/css/bootstrap.min.css',
    'mobile/css/owl.carousel.min.css',
    'mobile/img/core-img/dot-blue.png',
    'mobile/img/core-img/dot.png',
    'mobile/img/core-img/logo.png',
    'mobile/img/core-img/logo-dark.png',
    'mobile/img/core-img/favicon.ico',
    'mobile/js/active.js',
    'mobile/js/dark-mode-switch.js',
    'mobile/js/bootstrap.bundle.min.js',
    'mobile/js/jquery.min.js',
    'mobile/js/owl.carousel.min.js',
    'mobile/js/pwa.js',
    'mobile/element-hero-blocks.html',
    'mobile/page-login.html',
    'mobile/manifest.json',
    'mobile/page-home.html',
    'mobile/pages.html',
    'mobile/elements.html',
    'mobile/settings.html',
    'mobile/page-fallback.html',
    'mobile/style.css'
];

// Install Event
self.addEventListener('install', function (event) {
    event.waitUntil(
        caches.open(staticCacheName).then(function (cache) {
            return cache.addAll(precacheAssets);
        })
    );
});

// Activate Event
self.addEventListener('activate', function (event) {
    event.waitUntil(
        caches.keys().then(keys => {
            return Promise.all(keys
                .filter(key => key !== staticCacheName && key !== dynamicCacheName)
                .map(key => caches.delete(key))
            );
        })
    );
});

// Fetch Event
self.addEventListener('fetch', function (event) {
    event.respondWith(
        caches.match(event.request).then(cacheRes => {
            return cacheRes || fetch(event.request).then(response => {
                return caches.open(dynamicCacheName).then(function (cache) {
                    cache.put(event.request, response.clone());
                    return response;
                })
            });
        }).catch(function() {
            // Fallback Page, When No Internet Connection
            return caches.match('page-fallback.html');
          })
    );
});