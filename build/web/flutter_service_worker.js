'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"flutter_bootstrap.js": "bf6b7ae9f40297c0b6c73f2944a201cb",
"version.json": "8e6661e5e028808c7d052d4c0af778a3",
"index.html": "ffef72402fabc8b586a0f8f241a2ca85",
"/": "ffef72402fabc8b586a0f8f241a2ca85",
"main.dart.js": "2e552e1dc40dae8ad31d8b0f8873b1eb",
"flutter.js": "76f08d47ff9f5715220992f993002504",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"manifest.json": "8aa8438c817620e315aca2040558097d",
"assets/AssetManifest.json": "983300b6ca41de6a082dc17db78f5a05",
"assets/NOTICES": "612055d2d5418f1d9c5d81af7cc2b831",
"assets/FontManifest.json": "dc3d03800ccca4601324923c0b1d6d57",
"assets/AssetManifest.bin.json": "c41ee366df590232c05706364a1b5442",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "e986ebe42ef785b27164c36a9abc7818",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"assets/AssetManifest.bin": "87512d69d3a742e76828b37343354c29",
"assets/fonts/MaterialIcons-Regular.otf": "6590ec40485e17a27f9d92ff39aeaee8",
"assets/assets/Cathay%2520Pacific%2520Airlines.png": "5331a74afe6969317b1a945495582317",
"assets/assets/JP%2520Morgan%2520Blue.png": "16b431f2268f125ab8f73d8208135fc6",
"assets/assets/IDFC.png": "7faabf54f911849d45313ad7fd1a47a4",
"assets/assets/Fly%2520emirates.png": "b5a7a0caa89472a2a5349b4fb816ecdb",
"assets/assets/Hudl.png": "da8981f3248467fcdc4a213dcd233065",
"assets/assets/stat_font_black.png": "c5fdd852b1161fa2c717d96b7d28bc34",
"assets/assets/Hapag%2520Lloyd.png": "7cbb1942c450006edc8cb84f1eb40999",
"assets/assets/Master%2520Card.png": "631ddd27b4167dd59ee6aabf9f3a5e7f",
"assets/assets/AD%2520Factors%2520Blue.png": "b4a6f23be2dc1e06e1eca4deb4d89a7b",
"assets/assets/JP%2520Morgan%2520White.png": "16b431f2268f125ab8f73d8208135fc6",
"assets/assets/ADfactors%2520Orange.png": "b4a6f23be2dc1e06e1eca4deb4d89a7b",
"assets/assets/CMA.png": "33a040739c4bbadff89c2554ce49a095",
"assets/assets/Citi%2520bank.png": "79622d36f2efe9fb00a4442ff76b6d9f",
"assets/assets/Hdfc%2520bank%25201.png": "07a6934a2f946ca34cf04406149934d8",
"assets/assets/JP%2520Morgan%2520Red.png": "16b431f2268f125ab8f73d8208135fc6",
"assets/assets/Hdfc%2520bank%25202.png": "07a6934a2f946ca34cf04406149934d8",
"assets/assets/Saint%2520Gobain.png": "e6c4a3f1e5760b22b2aadf3b156c7c09",
"assets/assets/Teleperformance.png": "e4db7ebf7d981109f4a3261dd9a4769c",
"assets/assets/Kotak.png": "ec0791d907a1602fee9e0c35e7446f3e",
"canvaskit/skwasm_st.js": "d1326ceef381ad382ab492ba5d96f04d",
"canvaskit/skwasm.js": "f2ad9363618c5f62e813740099a80e63",
"canvaskit/skwasm.js.symbols": "58dcc01e30099382fa92dce2380cd7cf",
"canvaskit/canvaskit.js.symbols": "737048e1d3ad50f18036f932917e50e0",
"canvaskit/skwasm.wasm": "fd2098ced28c6cdf814a261b666680c5",
"canvaskit/chromium/canvaskit.js.symbols": "8a65c5ebe7c9c953d1feb5a1388fa860",
"canvaskit/chromium/canvaskit.js": "73343b0c5d471d1114d7f02e06c1fdb2",
"canvaskit/chromium/canvaskit.wasm": "d6463da2fd70207a2bfece2f04715f19",
"canvaskit/skwasm_st.js.symbols": "da210335b5bbbc02ead100da96ab34be",
"canvaskit/canvaskit.js": "de27f912e40a372c22a069c1c7244d9b",
"canvaskit/canvaskit.wasm": "78b9309f3bf6ccd94c7569945c9c344d",
"canvaskit/skwasm_st.wasm": "14be5e6268cd4e3e80caa07e8ceed900"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
