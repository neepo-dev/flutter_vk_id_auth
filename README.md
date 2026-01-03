# Flutter VK ID Auth Demo

Демо-приложение Flutter для Android с авторизацией через [**VK ID One Tap**](https://id.vk.com/about/business/go/docs/ru/vkid/latest/vk-id/connection/elements/onetap-button/onetap-flutter).

---

## Возможности

- Авторизация через VK ID (One Tap)
- Хранение токена и данных пользователя в [Secure Storage](https://pub.dev/packages/flutter_secure_storage)
- Управление состоянием через [Bloc Cubit](https://pub.dev/packages/bloc)
- Расширения для BuildContext для быстрого доступа к `currentUser` и `userIsLoggedIn`

---

### Комментарии

- Храним в `/android/local.properties` константы с данными вашего [приложения VK](https://id.vk.ru/about/business/go/), пример:
  - `VKIDRedirectHost=vk.ru`
  - `VKIDRedirectScheme=vk12345678`
  - `VKIDClientID=12345678`
  - `VKIDClientSecret=blahblahboobooboo`

---

### Ссылки

- [VK ID Flutter SDK](https://pub.dev/packages/vkid_flutter_sdk)
- [Документация VK ID](https://id.vk.com/about/business/go/docs/ru/vkid/latest/vk-id/connection/create-application)
