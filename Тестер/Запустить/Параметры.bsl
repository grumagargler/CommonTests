﻿СтандартнаяОбработка = ложь;

п = новый Структура ();
п.Вставить ( "Пользователь" );
п.Вставить ( "Пароль" );
п.Вставить ( "База" ); // Имя ИБ как она названа в списке баз стартера 1С
п.Вставить ( "Порт", AppData.Port ); // Порт клиента тестирования
п.Вставить ( "КлиентТестирования", истина ); // Запускать по умолчанию приложение в режиме тестирования
п.Вставить ( "РежимЗапуска", 0 ); // 0 - метод стандартно запустит 1С на выполнение
								  // 1 - метод только вернет комманду запуска, без запуска самого приложения
п.Вставить ( "Ждать", 60 ); // Максимальный период ожидания в секундах, в течение которого Тестер
							// будет пытаться подключиться к запускаемому приложению.
п.Вставить ( "Обработка" ); // Путь к обработке, которая будет запущена после старта программы
							// В кавычки путь брать не обязательно
п.Вставить ( "Параметры" ); // Прочие параметры запуска
возврат п;
