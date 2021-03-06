﻿// Порты запуска приложений
портЕРП = 1538;
портБух = 1539;

// Мы хотим, чтобы Тестер фотографировал ошибки каждого приложения
// даже если их окна будут перекрывать друг друга. Маска поиска задается
// регулярным выражением. Поиск производится по заголовку главного окна
скриншотыЕРП = "Демонстрационная база / 1С:ERP.+";
скриншотыБух = "Демонстрационная база / Абдулов.+";

// ******************
// Запуск ERP
// ******************

п = Вызвать ( "Тестер.Запустить.Параметры" );
п.База = "ERP Управление предприятием 2 (демо)";
п.Пользователь = "Администратор (ОрловАВ)";
п.Порт = портЕРП;
п.Параметры = "/LRU"; // Язык интерфейса
п.Ждать = 30;
Вызвать ( "Тестер.Запустить", п );

// ********************
// Запуск Бухгалтерии
// ********************

п.База = "Бухгалтерия предприятия КОРП (демо)";
п.Пользователь = "Абдулов (директор)";
п.Порт = портБух; // Другой порт
Вызвать ( "Тестер.Запустить", п );

// ***********************************
// Работаем с запущенными приложениями
// ***********************************

// Системный параметр, задает маску поиска приложения по его заголовку
ScreenshotsLocator = скриншотыЕРП;

// Закроем окна в ЕРП
Подключить ( , портЕРП );
ЗакрытьВсё ();
Отключить ();

// Закроем окна в Бухгалтерии
ScreenshotsLocator = скриншотыБух;
Подключить ( , портБух );
ЗакрытьВсё ();
Отключить ();

// Откроем в ЕРП справочник номенклатура
ScreenshotsLocator = скриншотыЕрп;
Подключить ( , портЕРП );
Коммандос ( "e1cib/list/Справочник.Номенклатура" );

// Делаем что-то еще
// .....

// ***********************
// Закрываем приложения
// ***********************

Подключить ( , портЕРП );
Отключить ( истина ); // Параметр истина - приложение будет закрыто

Подключить ( , портБух );
Отключить ( истина );