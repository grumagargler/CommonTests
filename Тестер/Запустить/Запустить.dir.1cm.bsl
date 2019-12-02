﻿// Производит запуск 1С согласно переданных параметров и возвращает
// сформированную строку запуска
// Параметры:
// Структура, Тестер.Запустить.Параметры

комманда = сформироватьКомманду ( _ );
если ( _.РежимЗапуска = 0 ) тогда
	ЗапуститьПриложение ( комманда );
	подключиться ( _ );
	подавитьБезопастность ( _ );
конецесли;
возврат комманда;

Функция сформироватьКомманду ( Параметры )

	команда = """" + BinDir () + "1cv8c.exe"" enterprise";
	
	п = Параметры.База;
	если ( п <> неопределено ) тогда
		команда = команда + " /IBName """ + п + """";
	конецесли;
	п = Параметры.Пользователь;
	если ( п <> неопределено ) тогда
		команда = команда + " /N """ + п + """";
	конецесли;
	п = Параметры.Пароль;
	если ( п <> неопределено ) тогда
		команда = команда + " /P """ + п + """";
	конецесли;
	если ( Параметры.КлиентТестирования ) тогда
		п = Параметры.Порт;
		если ( п = неопределено ) тогда
			команда = команда + " /TESTCLIENT ";
		иначе
			команда = команда + " /TESTCLIENT -TPORT " + Format ( п, "NG=0" );
		конецесли;
	конецесли;
	п = Параметры.Обработка;
	если ( п = неопределено ) тогда
		открытьОбработку = ложь;
	иначе
		команда = команда + " /Execute """ + п + """";
		открытьОбработку = истина;
	конецесли;
	п = Параметры.Параметры;
	если ( п <> неопределено ) тогда
		команда = команда + " " + п;
	конецесли;
	возврат команда;
	ЗапуститьПриложение ( команда );
	
КонецФункции

Процедура подключиться ( Параметры )

	ждать = Параметры.Ждать;
	если ( ждать = неопределено ) тогда
		возврат;
	конецесли;
	начало = ТекущаяДата ();
	пока ( ждать > ( ТекущаяДата () - начало ) ) цикл
		попытка
			Подключить ( , Параметры.Порт );
			прервать;
		исключение
		конецпопытки;
		прошло = ТекущаяДата () - начало;
	конеццикла;

КонецПроцедуры

Процедура подавитьБезопастность ( Параметры )

	если ( Параметры.Обработка = неопределено ) тогда
		возврат;
	конецесли;
	если ( не Дождаться ( "1?:*" ) ) тогда
		возврат;
	конецесли;
	форма = Здесь ( "1?:*" );
	поле = Тип ( "ТестируемоеПолеФормы" );
	надпись = форма.НайтиОбъект ( поле, "Предупреждение безопасности*" );
	если ( надпись = неопределено ) тогда
		надпись = форма.НайтиОбъект ( поле, "Security warning*" );
		да = "Yes";
		если ( надпись = неопределено ) тогда
			возврат;
		конецесли;
	иначе
		да = "Да";
	конецесли;
	Нажать ( да );

КонецПроцедуры
