﻿// Производит открытие всех доступных пользователю объектов в коммандном интерфейсе
// Панель навигации и панель разделов должны быть включены
// Примечание: в процессе тестирования, активируемая панель функций тестируемого раздела
// может перекрывать рабочую область, в связи с чем, может сложиться впечатление,
// что ничего не происходит. На самом деле, объекты открываются, просто их за этой панелью не видно.

Подключить ();
ЗакрытьВсё ();

интерфейс = ГлавноеОкно.ПолучитьКомандныйИнтерфейс ();
разделы = интерфейс.НайтиОбъект ( , "Панель разделов");
если разделы = неопределено тогда
    Стоп ( "Установите пожалуйста отображение панели разделов командного интерфейса!" );
конецесли;

проверено = новый Соответствие ();
разделы = разделы.ПолучитьПодчиненныеОбъекты ();
группа = Тип ( "ТестируемаяГруппаКомандногоИнтерфейса" );
ИгнорироватьОшибки = истина;
для каждого раздел из разделы цикл
    раздел.Нажать ();
    меню = интерфейс.НайтиОбъект ( , "Меню функций" );
    команды = меню.НайтиОбъекты ();    
    для каждого команда из команды Цикл
        если Тип ( Команда ) = группа Тогда
            продолжить;
        конецесли;    
        ссылка = команда.НавигационнаяСсылка;
        если истина = проверено [ ссылка ] тогда
            продолжить;
        конецесли;
        проверено [ ссылка ] = истина;
        попытка
            команда.Нажать ();
            ошибка = Приложение.ПолучитьТекущуюИнформациюОбОшибке ();
        исключение
            ошибка = ИнформацияОбОшибке ();
        конецпопытки;
        если ( ошибка <> неопределено ) тогда
            ЗаписатьОшибку ( "" + раздел + " / " + команда.ТекстЗаголовка + ":" + ошибка.Описание );
        конецесли;
        ЗакрытьВсё ();
        раздел.Нажать ();
    конеццикла;
конеццикла;
раздел.Нажать ();
ИгнорироватьОшибки = ложь;
