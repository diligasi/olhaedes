window.addEventListener('load', () => {
    if ('serviceWorker' in navigator) {
        navigator.serviceWorker.register('/service-worker.js', { scope: '/app' }).then(registration => {
            console.info('[Service Worker] Registered: ', registration);

            if (registration.installing) {
                registration.installing;
                console.info('[Service Worker] Installing.');
            } else if (registration.waiting) {
                registration.waiting;
                console.info('[Service Worker] Installed & Waiting.');
            } else if (registration.active) {
                registration.active;
                console.info('[Service Worker] Active.');
            }
        }).catch(registrationError => {
            console.warn(`[Service Worker] Registration Failed: ${registrationError}`);
        });
    }
});
