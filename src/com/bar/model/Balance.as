package com.bar.model
{
	import com.bar.model.essences.Client;
	import com.bar.model.essences.ClientType;
	import com.bar.model.essences.Decor;
	import com.bar.model.essences.DecorPart;
	import com.bar.model.essences.DecorType;
	import com.bar.model.essences.GoodsType;
	import com.bar.model.essences.Production;
	import com.bar.model.essences.ProductionType;
	import com.util.Selector;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	
	public class Balance
	{
		/**
		 * Бонус от приглашения друга.
		 * Центы. 
		 */
		public static var bonusFromInvite: uint = 100;
		/**
		 * Период таймера в движке
		 * МИЛЛИСЕКУНДЫ
		 */
		public static var coreTimerPeriod: Number = 2000;
		/**
		 * Начальные деньги
		 */
		public static var startMoneyCent: uint = 1000;
		public static var startMoneyEuro: uint = 2;
		/**
		 * Деньги за ежедневный заход в приложение
		 */
		public static var moneyCentDayVisit: uint = 100;
		/**
		 * Уровень с которого начинается игра 
		 */
		public static var startLevel: uint = 1;
		/**
		 * Опыт с которого начинается игра 
		 */
		public static var startExperience: uint = 0;
		/**
		 * Максимальный уровень в игре 
		 */
		public static var maxLevel: uint = 10;
		/**
		 * Количество опыта для получения каждого уровня
		 * При переходе от уровня к уровню опыт не сбрасывается. Растет все время по ходу игры.
		 */
		public static var levelExp: Array = new Array (0, 10/*1*/, 50, 100, 200, 350/*5*/, 500, 750, 1000, 1500, 2000/*10*/, 3000, 5000);
		/**
		 * Начальное количество любви
		 */
		public static var startLove: uint = 100;
		/**
		 * Количество любви, которое снимется, если клиента, откажутся обслуживать.
		 */
		public static var loveForDenyClient: int = -5;
		/**
		 * Максимальное количество клиентов в баре
		 */
		public static var maxClientsCount: uint = 4;
		/**
		 * Минимальная скорость прихода клиентов. Человек/минуту
		 * К ней прибавляется еще скорость от любви и количества приглашенных.
		 */
		public static var minClientSpeed: Number = 4;//5
		/**
		 * Период, по истечении которого у клиента уменьшается настроение
		 * СЕКУНДЫ
		 */
		public static var periodToLowMood: uint = 5;
		/**
		 * Базовая, минимальная вероятность выдачи чаевых
		 */
		public static var baseTipProb: Number = 0.3;
		/**
		 * Максимальное настроение клиента
		 */
		public static const maxClientMood: int = 5;
		/**
		 * Время "жизни" чаевых. Секунды.
		 */
		public static const tipsLifeTime: int = 5;
//		/**
//		 * Минимальное количество клиентов, приходящих в клиентский период
//		 */
//		public static var minClientsCountInClientPeriod: Number = 3;
//		/**
//		 * Клиентский период, для рассчета скорости прихода клиентов
//		 * СЕКУНДЫ 
//		 */
//		public static var clientPeriod: Number = 10;
		public static var clientTypes: Array;
		public static var decorTypes: Array;
		public static var productionTypes: Array;
		public static var goodsTypes: Array;

		{
			initClientTypes();
			initDecorTypes();
			initProductionTypes();
			initGoodsTypes();
		}

		public function Balance()
		{
		}
		
//		/**
//		 * Загрузка настроек с сервера
//		 */
//		public static function loadBalance(): void {
//			
//		}
		
		/**
		 * Возвращает типы клиентов в игре
		 */
		public static function initClientTypes(): void {
			clientTypes = new Array();
			clientTypes.push(new ClientType('blond_in_red', ClientType.FEMALE, -96, -244, new Bitmap(new BitmapData(50, 50, false, 0xdede44))));
			clientTypes.push(new ClientType('teenager', ClientType.MALE, -44, -231, new Bitmap(new BitmapData(30, 50, false, 0xffd004))));
			clientTypes.push(new ClientType('violet_girl', ClientType.FEMALE, -112, -236, new Bitmap(new BitmapData(50, 50, false, 0xdede44))));
			clientTypes.push(new ClientType('geek', ClientType.MALE, -88, -232, new Bitmap(new BitmapData(30, 50, false, 0xffd004))));
			clientTypes.push(new ClientType('man_kachok', ClientType.MALE, -112, -244, new Bitmap(new BitmapData(50, 50, false, 0xdede44))));
			clientTypes.push(new ClientType('sexy-blond', ClientType.FEMALE, -99, -231, new Bitmap(new BitmapData(30, 50, false, 0xffd004))));
		}
		
		/**
		 * Возвращает типы декора в игре.
		 * 1 параметр - ТИП. Обозначает пренадлежность к определенному декору (напр. все части
		 * 		стула перед и зад (x4) обозначаются одинаково 'stul1').
		 * 		Частей одного типа может быть несколько. Они могут иметь разные координаты и zOrder.
		 * 3 параметр - категория декора. Для заменяемости (лампа заменяет лампу).
		 */
		public static function initDecorTypes(): void {
			decorTypes = new Array();
			//1 level
			var decorType: DecorType = new DecorType('picture1', 'Картина 1', 'pic_right', 1, 0, 0, 0, 50, 0);
			decorType.parts.push(new DecorPart(535, 155, 10));
			decorTypes.push(decorType);
			
			decorType = new DecorType('shkaf1', 'Шкаф 1', 'shkaf', 1, 0, 0, 0, 500, 0);
			decorType.parts.push(new DecorPart(0, 47, 5));
			decorTypes.push(decorType);
			
			decorType = new DecorType('wall1', 'Стена 1', 'wall', 1, 0, 0, 0, 400, 0);
			decorType.parts.push(new DecorPart(0, 60, 2));
			decorTypes.push(decorType);
			
			decorType = new DecorType('bartable1', 'Барная стойка 1', 'bartable', 1, 0, 0, 0, 600, 0);
			decorType.parts.push(new DecorPart(0, 450, 20));
			decorTypes.push(decorType);
			
			decorType = new DecorType('stul1', 'Стул 1', 'stul', 1, 0, 0, 0, 300, 0);
			decorType.parts.push(new DecorPart(50, 544, 23));
			decorType.parts.push(new DecorPart(230, 544, 23));
			decorType.parts.push(new DecorPart(410, 544, 23));
			decorType.parts.push(new DecorPart(590, 544, 23));
			decorType.parts.push(new DecorPart(49, 549, 30));
			decorType.parts.push(new DecorPart(229, 549, 30));
			decorType.parts.push(new DecorPart(409, 549, 30));
			decorType.parts.push(new DecorPart(589, 549, 30));
			decorTypes.push(decorType);
			
			decorType = new DecorType('lamp1', 'Лампа 1', 'top_lamp', 1, 0, 0, 0, 200, 0);
			decorType.parts.push(new DecorPart(83, 60, 40));
			decorType.parts.push(new DecorPart(565, 60, 40));
			decorTypes.push(decorType);
			
			decorType = new DecorType('woman_body', 'Бармен Девушка', 'woman_body', 1, 0, 0, 0, 0, 0);
			decorType.parts.push(new DecorPart(56, 206, 5));
			decorType.parts.push(new DecorPart(112, 395, 6));
			decorType.parts.push(new DecorPart(103, 285, 6));
			decorTypes.push(decorType);
			
//			decorType = new DecorType('woman_pants1', 'Трусы 1', 'woman_pants', 1, 0, 0, 0, 0, 0);
//			decorTypes.push(decorType);
//			
//			decorType = new DecorType('woman_bust1', 'Ливчик 1', 'woman_bust', 1, 0, 0, 0, 0, 0);
//			decorTypes.push(decorType);
			
			decorType = new DecorType('woman_tshirt1', 'Блузка 1', 'woman_tshirt', 1, 0, 0, 0, 300, 0);
			decorType.parts.push(new DecorPart(97, 276, 8));
			decorTypes.push(decorType);
			
			decorType = new DecorType('woman_skirt1', 'Юбка 1', 'woman_skirt', 1, 0, 0, 0, 250, 0);
			decorType.parts.push(new DecorPart(111, 380, 7));
			decorTypes.push(decorType);
			
			decorType = new DecorType('picture2', 'Картина 2', 'pic_right', 1, 5, 20, 0.05, 300, 0);
			decorType.parts.push(new DecorPart(535, 155, 10));
			decorTypes.push(decorType);
			
			decorType = new DecorType('picture3', 'Картина 3', 'pic_right', 2, 7, 25, 0.07, 400, 0);
			decorType.parts.push(new DecorPart(535, 155, 10));
			decorTypes.push(decorType);
			
			decorType = new DecorType('wall2', 'Красный кирпич', 'wall', 1, 10, 30, 0.08, 500, 0);
			decorType.parts.push(new DecorPart(0, 60, 2));
			decorTypes.push(decorType);
			
			decorType = new DecorType('wall3', 'Модерн', 'wall', 1, 20, 50, 0.08, 1100, 0);
			decorType.parts.push(new DecorPart(0, 60, 2));
			decorTypes.push(decorType);
			
			decorType = new DecorType('wall4', 'Кожа', 'wall', 2, 30, 60, 0.08, 0, 2);
			decorType.parts.push(new DecorPart(0, 60, 2));
			decorTypes.push(decorType);
			
			decorType = new DecorType('wall5', 'Красная Кожа', 'wall', 3, 40, 70, 0.08, 0, 3);
			decorType.parts.push(new DecorPart(0, 60, 2));
			decorTypes.push(decorType);
			
			decorType = new DecorType('shkaf2', 'Шкаф 2', 'shkaf', 2, 20, 40, 0.05, 0, 1);
			decorType.parts.push(new DecorPart(0, 47, 5));
			decorTypes.push(decorType);
			
			decorType = new DecorType('shkaf3', 'Шкаф 3', 'shkaf', 3, 25, 50, 0.06, 0, 2);
			decorType.parts.push(new DecorPart(0, 47, 5));
			decorTypes.push(decorType);
			
			decorType = new DecorType('bartable2', 'Барная стойка 2', 'bartable', 2, 40, 70, 0.07, 0, 3);
			decorType.parts.push(new DecorPart(0, 450, 20));
			decorTypes.push(decorType);
			
			decorType = new DecorType('lamp2', 'Лампа 2', 'top_lamp', 2, 10, 20, 0.03, 0, 1);
			decorType.parts.push(new DecorPart(75, 20, 40));
			decorType.parts.push(new DecorPart(565, 20, 40));
			decorTypes.push(decorType);
			
			decorType = new DecorType('lamp3', 'Лампа 3', 'top_lamp', 3, 15, 30, 0.04, 0, 1);
			decorType.parts.push(new DecorPart(75, 20, 40));
			decorType.parts.push(new DecorPart(565, 20, 40));
			decorTypes.push(decorType);
			
			decorType = new DecorType('stul2', 'Стул 2', 'stul', 3, 30, 40, 0.05, 0, 2);
			decorType.parts.push(new DecorPart(50, 544, 23));
			decorType.parts.push(new DecorPart(230, 544, 23));
			decorType.parts.push(new DecorPart(410, 544, 23));
			decorType.parts.push(new DecorPart(590, 544, 23));
			decorType.parts.push(new DecorPart(49, 482, 30));
			decorType.parts.push(new DecorPart(229, 482, 30));
			decorType.parts.push(new DecorPart(409, 482, 30));
			decorType.parts.push(new DecorPart(589, 482, 30));
			decorTypes.push(decorType);
		}
		
		/**
		 * Возвращает типы продукции в игре
		 */
		public static function initProductionTypes(): void {
			productionTypes = new Array();
			//1 level
			productionTypes.push(new ProductionType('beer', 'Светлое пиво', 50, 0, 1, 1, 0, 0));
			productionTypes.push(new ProductionType('vodka', 'Водка', 220, 0, 10, 1, 500, 0));
			productionTypes.push(new ProductionType('orange', 'Апельсиновый сок', 120, 0, 4, 1, 0, 0));
			productionTypes.push(new ProductionType('soda', 'Содовая', 40, 0, 1, 1, 0, 0));
			//2 level
			productionTypes.push(new ProductionType('viski', 'Виски', 350, 0, 8, 2, /*1500*/0, 1));
			productionTypes.push(new ProductionType('limon', 'Лимоны', 200, 0, 20, 2, 0, 0));
			productionTypes.push(new ProductionType('sirop', 'Сироп', 150, 0, 10, 2, 0, 0));
			//3 level
			productionTypes.push(new ProductionType('ice', 'Лед', 50, 0, 10, 3, 0, 0));
			productionTypes.push(new ProductionType('jin', 'Джин', 450, 0, 7, 3, /*3000*/0, 1));
			//4 level
			productionTypes.push(new ProductionType('coffee', 'Кофе', 300, 0, 20, 4, 0, 0));
			productionTypes.push(new ProductionType('slivki', 'Сливки', 100, 0, 10, 4, 0, 0));
			productionTypes.push(new ProductionType('orange_liker', 'Ликер Апельсиновый', 210, 0, 7, 4, 0/*5000*/, 2));
			//5 level
			productionTypes.push(new ProductionType('sirop_gren', 'Сироп Гренадин', 200, 0, 10, 5, 0, 0));
			productionTypes.push(new ProductionType('tekila', 'Текила', 350, 0, 7, 5, 0/*8000*/, 2));			
			//6 level
			productionTypes.push(new ProductionType('mint', 'Мята', 100, 0, 20, 6, 0, 0));
			productionTypes.push(new ProductionType('rom', 'Ром', 400, 0, 10, 6, /*11000*/0, 3));
			//7 level
			productionTypes.push(new ProductionType('tomato', 'Томатный сок', 120, 0, 4, 7, 0, 0));
			productionTypes.push(new ProductionType('coffee_liker', 'Кофейный ликер', 330, 0, 6, 7, /*15000*/0, 3));
			//8 level
			productionTypes.push(new ProductionType('energy', 'Энергетик', 80, 0, 1, 8, 0, 0));
			productionTypes.push(new ProductionType('blue', 'Блю кюросао', 700, 0, 7, 8, /*20000*/0, 4));
			//9 level
			productionTypes.push(new ProductionType('sambuka', 'Самбука', 630, 0, 7, 9, /*26000*/0, 4));
			//10 level
			productionTypes.push(new ProductionType('beyleis', 'Бейлиз', 770, 0, 7, 10, /*33000*/0, 5));
			//11 level
			productionTypes.push(new ProductionType('xox', 'Коньяк', 840, 0, 6, 11, /*40000*/0, 5));
			//12 level
			productionTypes.push(new ProductionType('absent', 'Абсент', 750, 0, 5, 12, /*50000*/0, 6));
		}
		
		/**
		 * Возвращает типы товаров(коктейлей) в игре
		 */
		public static function initGoodsTypes(): void {
			goodsTypes = new Array();
			//1 level
			goodsTypes.push(new GoodsType('beer', 'Пиво', [{'productionType': 'beer', 'partsCount': 1}], 80, 1, 1, 10));
			goodsTypes.push(new GoodsType('vodka', 'Водка 100 грамм', [{'productionType': 'vodka', 'partsCount': 1}], 40, 1, 1, 10));
			goodsTypes.push(new GoodsType('soda', 'Содовая', [{'productionType': 'soda', 'partsCount': 1}], 55, 1, 1, 0));
			goodsTypes.push(new GoodsType('orange', 'Апельсиновый сок', [{'productionType': 'orange', 'partsCount': 1}], 50, 1, 1, 0));
			goodsTypes.push(new GoodsType('ersh', 'Ерш', [{'productionType': 'beer', 'partsCount': 1}, {'productionType': 'vodka', 'partsCount': 1}], 120, 2, 1, 15));
			goodsTypes.push(new GoodsType('otvertka', 'Отвертка', [{'productionType': 'vodka', 'partsCount': 1}, {'productionType': 'orange', 'partsCount': 1}], 90, 2, 1, 15));
			//2 level
			goodsTypes.push(new GoodsType('viski', 'Виски', [{'productionType': 'viski', 'partsCount': 1}], 70, 1, 2, 10));
			goodsTypes.push(new GoodsType('millionair', 'Миллионер', [{'productionType': 'viski', 'partsCount': 1}, {'productionType': 'sirop', 'partsCount': 1}, {'productionType': 'limon', 'partsCount': 1}], 115, 2, 2, 15));
			goodsTypes.push(new GoodsType('vodka-tonic', 'Водка-Тоник', [{'productionType': 'vodka', 'partsCount': 1}, {'productionType': 'soda', 'partsCount': 1}], 110, 2, 2, 15));
			goodsTypes.push(new GoodsType('jameson-viski-sayer', 'Джемесон Виски', [{'productionType': 'viski', 'partsCount': 1}, {'productionType': 'sirop', 'partsCount': 1}, {'productionType': 'limon', 'partsCount': 1}, {'productionType': 'orange', 'partsCount': 1}], 150, 3, 2, 15));
			//3 level
			goodsTypes.push(new GoodsType('jin', 'Джин',
										[{'productionType': 'jin', 'partsCount': 1}],
										90, 1, 3, 10));
			goodsTypes.push(new GoodsType('sex_beach', 'Секс на пляже',
										[{'productionType': 'vodka', 'partsCount': 1},
										{'productionType': 'sirop', 'partsCount': 1},
										{'productionType': 'ice', 'partsCount': 1}],
										70, 2, 3, 15));
			goodsTypes.push(new GoodsType('jin_tonik', 'Джин-Тоник',
										[{'productionType': 'soda', 'partsCount': 1},
										{'productionType': 'limon', 'partsCount': 1},
										{'productionType': 'ice', 'partsCount': 1},
										{'productionType': 'jin', 'partsCount': 1}],
										180, 2, 3, 15));
			goodsTypes.push(new GoodsType('paradiso', 'Парадизо',
										[{'productionType': 'jin', 'partsCount': 1},
										{'productionType': 'orange', 'partsCount': 1},
										{'productionType': 'ice', 'partsCount': 1}],
										155, 2, 3, 15));
			goodsTypes.push(new GoodsType('vanila_ice', 'Ванила Айс',
										[{'productionType': 'vodka', 'partsCount': 1},
										{'productionType': 'sirop', 'partsCount': 1},
										{'productionType': 'limon', 'partsCount': 1},
										{'productionType': 'ice', 'partsCount': 1}],
										95, 2, 3, 15));
			//4 level
			goodsTypes.push(new GoodsType('coffee', 'Кофе',
										[{'productionType': 'coffee', 'partsCount': 1},
										{'productionType': 'slivki', 'partsCount': 1}],
										45, 2, 4, 0));
			goodsTypes.push(new GoodsType('orange_liker', 'Ликер Апельсиновый',
										[{'productionType': 'orange_liker', 'partsCount': 1}],
										55, 1, 4, 10));
			goodsTypes.push(new GoodsType('irish_coffee', 'Ирландский Кофе',
										[{'productionType': 'coffee', 'partsCount': 1},
										{'productionType': 'viski', 'partsCount': 1},
										{'productionType': 'sirop', 'partsCount': 1},
										{'productionType': 'slivki', 'partsCount': 1}],
										140, 2, 4, 0));
			//no icon
//			goodsTypes.push(new GoodsType('coffee_fredo', 'Кофе Фредо',
//										[{'productionType': 'coffee', 'partsCount': 1},
//										{'productionType': 'sirop', 'partsCount': 1},
//										{'productionType': 'slivki', 'partsCount': 1}],
//										60, 2, 4, 0));
			goodsTypes.push(new GoodsType('white_ledi', 'Белая леди',
										[{'productionType': 'limon', 'partsCount': 1},
										{'productionType': 'orange_liker', 'partsCount': 1},
										{'productionType': 'jin', 'partsCount': 1}],
										160, 2, 4, 0));
			//5 level
			goodsTypes.push(new GoodsType('tekila', 'Текила',
										[{'productionType': 'tekila', 'partsCount': 1}],
										80, 1, 5, 10));
			goodsTypes.push(new GoodsType('tekila_sunrise', 'Текила Санрайз',
										[{'productionType': 'tekila', 'partsCount': 1},
										{'productionType': 'orange', 'partsCount': 1},
										{'productionType': 'sirop_gren', 'partsCount': 1}],
										160, 3, 5, 10));
			goodsTypes.push(new GoodsType('margarita', 'Маргарита',
										[{'productionType': 'tekila', 'partsCount': 1},
										{'productionType': 'limon', 'partsCount': 1},
										{'productionType': 'orange_liker', 'partsCount': 1}],
										150, 3, 5, 10));
			goodsTypes.push(new GoodsType('granat_mix', 'Гранатовый Микс',
										[{'productionType': 'soda', 'partsCount': 1},
										{'productionType': 'ice', 'partsCount': 1},
										{'productionType': 'sirop_gren', 'partsCount': 1}],
										110, 2, 5, 0));
			//6 level
			goodsTypes.push(new GoodsType('rom', 'Ром',
										[{'productionType': 'rom', 'partsCount': 1}],
										70, 1, 6, 10));
			goodsTypes.push(new GoodsType('mai_tai', 'Май Тай',
										[{'productionType': 'limon', 'partsCount': 1},
										{'productionType': 'mint', 'partsCount': 1},
										{'productionType': 'orange_liker', 'partsCount': 1},
										{'productionType': 'rom', 'partsCount': 1},
										{'productionType': 'sirop_gren', 'partsCount': 1},
										{'productionType': 'ice', 'partsCount': 1}],
										175, 4, 6, 10));
			goodsTypes.push(new GoodsType('mohito', 'Мохито',
										[{'productionType': 'soda', 'partsCount': 1},
										{'productionType': 'sirop', 'partsCount': 1},
										{'productionType': 'limon', 'partsCount': 1},
										{'productionType': 'mint', 'partsCount': 1},
										{'productionType': 'rom', 'partsCount': 1}],
										170, 3, 6, 10));
			goodsTypes.push(new GoodsType('havana', 'Сладкая Гавана',
										[{'productionType': 'slivki', 'partsCount': 1},
										{'productionType': 'rom', 'partsCount': 1},
										{'productionType': 'orange_liker', 'partsCount': 1},
										{'productionType': 'sirop_gren', 'partsCount': 1}],
										165, 4, 6, 10));
			//7 level
			goodsTypes.push(new GoodsType('tomato', 'Томатный сок',
										[{'productionType': 'tomato', 'partsCount': 1}],
										55, 1, 7, 0));
			goodsTypes.push(new GoodsType('coffee_liker', 'Кофейный ликер',
										[{'productionType': 'coffee_liker', 'partsCount': 1}],
										90, 1, 7, 10));
			goodsTypes.push(new GoodsType('rocket', 'Ракетное топливо',
										[{'productionType': 'vodka', 'partsCount': 1},
										{'productionType': 'soda', 'partsCount': 1},
										{'productionType': 'rom', 'partsCount': 1},
										{'productionType': 'jin', 'partsCount': 1},
										{'productionType': 'tekila', 'partsCount': 1}],
										330, 5, 7, 50));
			goodsTypes.push(new GoodsType('blood_mary', 'Кровавая Мери',
										[{'productionType': 'vodka', 'partsCount': 1},
										{'productionType': 'limon', 'partsCount': 1},
										{'productionType': 'ice', 'partsCount': 1},
										{'productionType': 'tomato', 'partsCount': 1}],
										120, 3, 7, 20));
			//8 level
			goodsTypes.push(new GoodsType('energetic', 'Энергетик',
										[{'productionType': 'energy', 'partsCount': 1}],
										115, 1, 8, 0));
			goodsTypes.push(new GoodsType('blu', 'Блю куросао',
										[{'productionType': 'blue', 'partsCount': 1}],
										160, 1, 8, 10));
			goodsTypes.push(new GoodsType('blue_margarite', 'Маргатира Голубая',
										[{'productionType': 'limon', 'partsCount': 1},
										{'productionType': 'tekila', 'partsCount': 1},
										{'productionType': 'blue', 'partsCount': 1}],
										250, 4, 8, 20));
			goodsTypes.push(new GoodsType('vodka_bull', 'Водка Булл',
										[{'productionType': 'vodka', 'partsCount': 1},
										{'productionType': 'energy', 'partsCount': 1}],
										160, 2, 8, 20));
			//9 level
			goodsTypes.push(new GoodsType('sambuka', 'Самбука',
										[{'productionType': 'sambuka', 'partsCount': 1}],
										150, 1, 9, 10));
			goodsTypes.push(new GoodsType('black_rus', 'Черный Русский',
										[{'productionType': 'vodka', 'partsCount': 1},
										{'productionType': 'coffee', 'partsCount': 1},
										{'productionType': 'sambuka', 'partsCount': 1}],
										195, 3, 9, 10));
			goodsTypes.push(new GoodsType('blue_laguna', 'Голубая Лагуна',
										[{'productionType': 'limon', 'partsCount': 1},
										{'productionType': 'tekila', 'partsCount': 1},
										{'productionType': 'blue', 'partsCount': 1}],
										255, 4, 9, 10));
			//10 level
			goodsTypes.push(new GoodsType('beyleis', 'Бейлиз',
										[{'productionType': 'beyleis', 'partsCount': 1}],
										175, 1, 10, 10));
			goodsTypes.push(new GoodsType('b-52', 'B-52',
										[{'productionType': 'beyleis', 'partsCount': 1},
										{'productionType': 'coffee_liker', 'partsCount': 1},
										{'productionType': 'sambuka', 'partsCount': 1}],
										385, 8, 10, 50));
			goodsTypes.push(new GoodsType('posle6', 'После Шести',
										[{'productionType': 'beyleis', 'partsCount': 1},
										{'productionType': 'coffee_liker', 'partsCount': 1},
										{'productionType': 'sirop_gren', 'partsCount': 1}],
										295, 8, 10, 40));
			//11 level
			goodsTypes.push(new GoodsType('konjak', 'Коньяк',
										[{'productionType': 'konjak', 'partsCount': 1}],
										220, 1, 11, 30));
			goodsTypes.push(new GoodsType('side_car', 'Сайд Кар',
										[{'productionType': 'limon', 'partsCount': 1},
										{'productionType': 'orange_liker', 'partsCount': 1},
										{'productionType': 'konjak', 'partsCount': 1},
										{'productionType': 'sambuka', 'partsCount': 1}],
										400, 8, 11, 50));
			goodsTypes.push(new GoodsType('abk', 'А.Б.К.',
										[{'productionType': 'beyleis', 'partsCount': 1},
										{'productionType': 'konjak', 'partsCount': 1}],
										380, 8, 11, 40));
			goodsTypes.push(new GoodsType('french_mohito', 'Френч Мохито',
										[{'productionType': 'soda', 'partsCount': 1},
										{'productionType': 'sirop', 'partsCount': 1},
										{'productionType': 'mint', 'partsCount': 1},
										{'productionType': 'ice', 'partsCount': 1},
										{'productionType': 'konjak', 'partsCount': 1}],
										310, 7, 11, 50));
			//12 level
			goodsTypes.push(new GoodsType('absent', 'Абсент',
										[{'productionType': 'absent', 'partsCount': 1}],
										230, 1, 12, 30));
			goodsTypes.push(new GoodsType('magnum44', 'Maгнум 44',
										[{'productionType': 'rom', 'partsCount': 1},
										{'productionType': 'absent', 'partsCount': 1},
										{'productionType': 'sambuka', 'partsCount': 1}],
										420, 8, 12, 50));
			goodsTypes.push(new GoodsType('absent_bull', 'Абсент Булл',
										[{'productionType': 'energy', 'partsCount': 1},
										{'productionType': 'absent', 'partsCount': 1}],
										340, 4, 12, 50));
			goodsTypes.push(new GoodsType('oblaka', 'Облака',
										[{'productionType': 'tekila', 'partsCount': 1},
										{'productionType': 'absent', 'partsCount': 1},
										{'productionType': 'blue', 'partsCount': 1},
										{'productionType': 'beyleis', 'partsCount': 1},
										{'productionType': 'sambuka', 'partsCount': 1}],
										700, 10, 12, 100));
		}
		
		/**
		 * Возвращает начальные набор продукции
		 */
		public static function getStartProduction(): Array {
			var production: Array = new Array();
			production.push(new Production(productionTypes[0] as ProductionType));
			production.push(new Production(productionTypes[0] as ProductionType));
			production.push(new Production(productionTypes[0] as ProductionType));
			production.push(new Production(productionTypes[1] as ProductionType));
			production.push(new Production(productionTypes[2] as ProductionType));
			production.push(new Production(productionTypes[3] as ProductionType));
			production.push(new Production(productionTypes[3] as ProductionType));
			return production;
		}
		
		/**
		 * Возвращает начальные набор декора
		 */
		public static function getStartDecor(): Array {
			var decor: Array = new Array();
			decor.push(new Decor(getDecorTypeByName('picture1')));
			decor.push(new Decor(getDecorTypeByName('lamp1')));
			decor.push(new Decor(getDecorTypeByName('wall1')));
			decor.push(new Decor(getDecorTypeByName('shkaf1')));
			decor.push(new Decor(getDecorTypeByName('stul1')));
			decor.push(new Decor(getDecorTypeByName('bartable1')));
			decor.push(new Decor(getDecorTypeByName('woman_body')));
			decor.push(new Decor(getDecorTypeByName('woman_tshirt1')));
			decor.push(new Decor(getDecorTypeByName('woman_skirt1')));
			return decor;
		}
		
		/**
		 * Получить тип продукции по ее имени
		 * Иногда несостыковки, где-то передается String - имя, а где то ProductionType
		 */
		public static function getProductionTypeByName(name: String): ProductionType {
			for each (var p: ProductionType in productionTypes) {
				if (p.type == name) {
					return p;
				}
			}
			return null;
		}
		
		/**
		 * Получить тип клиента по ее имени
		 */
		public static function getClientTypeByName(name: String): ClientType {
			for each (var c: ClientType in clientTypes) {
				if (c.type == name) {
					return c;
				}
			}
			return null;
		}
		
		/**
		 * Получить тип товара по его имени
		 */
		public static function getGoodsTypeByName(name: String): GoodsType {
			for each (var g: GoodsType in goodsTypes) {
				if (g.type == name) {
					return g;
				}
			}
			return null;
		}
		
		/**
		 * Получить тип декора по его имени
		 */
		public static function getDecorTypeByName(name: String): DecorType {
			for each (var d: DecorType in decorTypes) {
				if (d.type == name) {
					return d;
				}
			}
			return null;
		}
		
		/**
		 * Получить количество любви за настроение клиента.
		 */
		public static function getLoveForMood(mood: Number): Number {
			return mood;
		}
		
		/**
		 * Выдает вероятность того, что клиент придет в данный момент
		 * Предполагается, что эта функция вызывается каждый тик таймера.
		 * И в итоге вероятность сработает примерно clientSpeed раз
		 * clientSpeed - скорость прихода чел/мин
		 */
		public static function getClientComeProb(clientSpeed: Number): Number {
			return (coreTimerPeriod / 1000 * clientSpeed) / 60;
		}
		
		/**
		 * Сумма чаевых, уплаченных клиентом.
		 * 0 - клиент не оставил чаевых.
		 */
		public static function tipsSum(barPlace: BarPlace, client: Client): Number {
			var p: Number = baseTipProb + barPlace.user.love * 0.001 + barPlace.tipProb + client.mood * 0.05;
			if (Selector.prob(p)) {
				return (int)(client.orderGoodsType.priceCent * 0.1);
			}
			//love: Number, barmanTips: Number, decorTips: Number, orderTime: Number
			return 0;
		}
	
		/**
		 * Количество любви от быстро обслуженных клиентов
		 */
		public static function loveSpeedService(): Number {
			return 1;
		}
		
//		/**
//		 * Клиент выбирает, что ему заказать
//		 * @return Индекс в массиве goods
//		 */
//		 public static function clientChooseGoods(goods: Array): uint {
//		 	return 0;
//		 }

		 /**
		  * Получить уникальный идентификатор для gameObject
		  */
		 public static function getUnicId(): Number {
		 	return Math.round(Math.random() * 1000000);
		 }
	}
}