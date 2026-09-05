document.addEventListener('DOMContentLoaded', function () {
    const mapContainer = document.getElementById('mapCanvas');

    if (!mapContainer) {
        console.error('Контейнер карты не найден.');
        return;
    }

    // Удаляем старую Canvas-карту
    mapContainer.innerHTML = '';

    // Создаём контейнер для Яндекс.Карты
    const yandexMap = document.createElement('div');
    yandexMap.id = 'yandex-map';
    yandexMap.style.width = '100%';
    yandexMap.style.height = '603px';
    yandexMap.style.borderRadius = '16px';
    yandexMap.style.overflow = 'hidden';

    mapContainer.parentNode.replaceChild(yandexMap, mapContainer);

    // Загружаем карту Яндекс
    const script = document.createElement('script');

    script.type = 'text/javascript';
    script.charset = 'utf-8';
    script.async = true;

    script.src =
        'https://api-maps.yandex.ru/services/constructor/1.0/js/' +
        '?um=constructor%3A0ee7c293946471b953779a82f5da79f4cf780d9e7c5f5898cc1cd448c24f122d' +
        '&width=100%' +
        '&height=603' +
        '&lang=ru_RU' +
        '&scroll=true';

    document.body.appendChild(script);
});
