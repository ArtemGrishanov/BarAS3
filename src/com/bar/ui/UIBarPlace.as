package com.bar.ui
{
	import com.bar.model.Balance;
	import com.bar.model.CoreEvent;
	import com.bar.model.essences.Client;
	import com.bar.model.essences.Decor;
	import com.bar.model.essences.DecorPart;
	import com.bar.model.essences.DecorType;
	import com.bar.model.essences.GoodsType;
	import com.bar.model.essences.Production;
	import com.bar.model.essences.ProductionType;
	import com.bar.ui.panels.ClientButtonsPanel;
	import com.bar.ui.panels.ClientOrderPanel;
	import com.bar.ui.panels.ClientOrderPanelEvent;
	import com.bar.ui.panels.GoodsPanel;
	import com.bar.ui.panels.MainMenuPanel;
	import com.bar.ui.panels.MainMenuPanelEvent;
	import com.bar.ui.panels.ProductionPanel;
	import com.bar.ui.panels.TopPanel;
	import com.bar.ui.tooltips.ClientToolTip;
	import com.bar.ui.tooltips.ProductionToolTip;
	import com.bar.ui.windows.ExchangeWindow;
	import com.bar.ui.windows.FriendsWindow;
	import com.bar.ui.windows.Window;
	import com.bar.util.Images;
	import com.flashmedia.basics.GameLayer;
	import com.flashmedia.basics.GameObject;
	import com.flashmedia.basics.GameObjectEvent;
	import com.flashmedia.basics.GameScene;
	import com.flashmedia.basics.actions.Visible;
	import com.flashmedia.util.BitmapUtil;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.filters.ColorMatrixFilter;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.getClassByAlias;
	import flash.net.registerClassAlias;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	import flash.utils.getDefinitionByName;

	public class UIBarPlace extends GameLayer
	{
		public static const CLIENT_BUTTONS_Y: Number = 450;
		
		public static const CLIENT_SIT_Y: Number = 553;
		public static const CLIENT_SIT_CENTER_X: Array = [94, 275, 455, 635];
		
		public static const TIPS_POSITION_Y: Number = 442;
		public static const TIPS_POSITION_X: Array = [114, 257, 434, 583, 500];
		
		public static const BAR_TABLE_Y: Number = 436;
		
//		public static const PRODUCTION_POSITION_X: Number = 200;
//		public static const PRODUCTION_POSITION_Y: Number = 50;
		
		public static const SHELF_Z_ORDER: Number = 10;
		public static const PRODUCTION_Z_ORDER: Number = 24;
		public static const PRODUCTION_ACTIVE_Z_ORDER: Number = 100;
		public static const TOOLTIP_Z_ORDER: Number = 55;
		public static const CLIENT_BTN_PANEL_Z_ORDER: Number = 35;
		public static const TIPS_Z_ORDER: Number = 23;
		public static const CLIENT_Z_ORDER: Number = 25;
		public static const CLIENT_SERVE_PANEL_Z_ORDER: Number = 38;
		public static const MAIN_MENU_PANEL_Z_ORDER: Number = 37;
		public static const EXCHANGE_WINDOW_Z_ORDER: Number = 60;
		public static const FRIENDS_WINDOW_Z_ORDER: Number = 60;
		public static const MESSAGE_WINDOW_Z_ORDER: Number = 61;
		public static const TOP_PANEL_Z_ORDER: Number = 50;
		public static const PRODUCTION_SHOP_WINDOW_Z_ORDER: Number = 38;
		public static const TUTORIAL_WINDOW_Z_ORDER: Number = 80;
		public static const TUTORIAL_ARROW_Z_ORDER: Number = 81;
		public static const UP_LEVEL_WINDOW_Z_ORDER: Number = 90;
		public static const BONUS_WINDOW_Z_ORDER: Number = 100;
		
		public var goClients: Array;
		public var goTips: Array;
		public var tipsClientIds: Array;
		public var goProduction: Array;
		public var goDecor: Array;
		public var prodCount: int;
		public var shelf: UIShelf;
		
		//public var ttProductionGameObject: GameObject;
		public var ttProduction: ProductionToolTip;
		public var ttClientGameObject: GameObject;
		public var ttClient: ClientToolTip;
		
		public var cBntPanel: ClientButtonsPanel;
		public var cOrderPanel: ClientOrderPanel;
		public var clientGameObject: GameObject;
		public var mainMenuPanel: MainMenuPanel;
		public var topPanel: TopPanel;
		public static var exchangeWindow: ExchangeWindow;
		public static var friendsWindow: FriendsWindow;
		private var friendsWindowShowed: Boolean;
		
		public var timer: Timer;
		public var timeStamp: Number;
		public var hoverProductionGameObject: GameObject;
		public var innerPreloader: MovieClip;		
		private static var instance: UIBarPlace;
		public static function getInstance(): UIBarPlace {
			return instance;
		}
		
		public function UIBarPlace(value:GameScene)
		{
			super(value);
			instance = this;
			innerPreloader = new InnerPreloader();
			
			scene.addEventListener(MouseEvent.CLICK, sceneMouseClick);
			//scene.addEventListener(MouseEvent.MOUSE_MOVE, sceneMouseMove);
			
			//todo resourse loading
			Balance.clientTypes[0].bitmap = Images.getImage(Images.CLIENT1);
			Balance.clientTypes[1].bitmap = Images.getImage(Images.CLIENT2);
			Balance.clientTypes[2].bitmap = Images.getImage(Images.CLIENT3);
			Balance.clientTypes[3].bitmap = Images.getImage(Images.CLIENT4);
			Balance.clientTypes[4].bitmap = Images.getImage(Images.CLIENT5);
			Balance.clientTypes[5].bitmap = Images.getImage(Images.CLIENT6);
			
			//1 level
			Balance.goodsTypes[0].bitmap = Images.getImage(Images.GOODS_BEER);
			Balance.goodsTypes[1].bitmap = Images.getImage(Images.GOODS_VODKA);
			Balance.goodsTypes[2].bitmap = Images.getImage(Images.GOODS_SODA);
			Balance.goodsTypes[3].bitmap = Images.getImage(Images.GOODS_ORANGE);
			Balance.goodsTypes[4].bitmap = Images.getImage(Images.GOODS_ERSH);
			Balance.goodsTypes[5].bitmap = Images.getImage(Images.GOODS_OTVERTKA);
			//2 level
			Balance.goodsTypes[6].bitmap = Images.getImage(Images.GOODS_VISKI);
			Balance.goodsTypes[7].bitmap = Images.getImage(Images.GOODS_MILLIONAIR);
			Balance.goodsTypes[8].bitmap = Images.getImage(Images.GOODS_VODKA_TONIC);
			Balance.goodsTypes[9].bitmap = Images.getImage(Images.GOODS_JAMESON_VISKI_SAYER);
			//3 level
			Balance.goodsTypes[10].bitmap = Images.getImage(Images.GOODS_GIN);
			Balance.goodsTypes[11].bitmap = Images.getImage(Images.GOODS_SEX_BEACH);
			Balance.goodsTypes[12].bitmap = Images.getImage(Images.GOODS_GIN_TONIC);
			Balance.goodsTypes[13].bitmap = Images.getImage(Images.GOODS_PARADIZO);
			Balance.goodsTypes[14].bitmap = Images.getImage(Images.GOODS_VANILA_ICE);
			//4 level
			Balance.goodsTypes[15].bitmap = Images.getImage(Images.GOODS_COFFEE);
			Balance.goodsTypes[16].bitmap = Images.getImage(Images.GOODS_ORANGE_LIKER);
			Balance.goodsTypes[17].bitmap = Images.getImage(Images.GOODS_IRISH_COFFEE);
			Balance.goodsTypes[18].bitmap = Images.getImage(Images.GOODS_WHITE_LEDY);
			//5 level
			Balance.goodsTypes[19].bitmap = Images.getImage(Images.GOODS_TEKILA);
			Balance.goodsTypes[20].bitmap = Images.getImage(Images.GOODS_TEKILA_SUNRISE);
			Balance.goodsTypes[21].bitmap = Images.getImage(Images.GOODS_MARGARITA);
			Balance.goodsTypes[22].bitmap = Images.getImage(Images.GOODS_GRANAT_MIX);
			//6 level
			Balance.goodsTypes[23].bitmap = Images.getImage(Images.GOODS_ROM);
			Balance.goodsTypes[24].bitmap = Images.getImage(Images.GOODS_MAI_TAI);
			Balance.goodsTypes[25].bitmap = Images.getImage(Images.GOODS_MOHITO);
			Balance.goodsTypes[26].bitmap = Images.getImage(Images.GOODS_GAVANA);
			//7 level
			Balance.goodsTypes[27].bitmap = Images.getImage(Images.GOODS_TOMATO);
			Balance.goodsTypes[28].bitmap = Images.getImage(Images.GOODS_COFFEE_LIKER);
			Balance.goodsTypes[29].bitmap = Images.getImage(Images.GOODS_ROCKET);
			Balance.goodsTypes[30].bitmap = Images.getImage(Images.GOODS_BLOOD_MARY);
			//8 level
			Balance.goodsTypes[31].bitmap = Images.getImage(Images.GOODS_ENERGETIC);
			Balance.goodsTypes[32].bitmap = Images.getImage(Images.GOODS_BLUE);
			Balance.goodsTypes[33].bitmap = Images.getImage(Images.GOODS_MARGARITA_BLUE);
			Balance.goodsTypes[34].bitmap = Images.getImage(Images.GOODS_VODKA_BULL);
			//9 level
			Balance.goodsTypes[35].bitmap = Images.getImage(Images.GOODS_SAMBUKA);
			Balance.goodsTypes[36].bitmap = Images.getImage(Images.GOODS_BLACK_RUS);
			Balance.goodsTypes[37].bitmap = Images.getImage(Images.GOODS_BLUE_LAGUNA);
			//10 level
			Balance.goodsTypes[38].bitmap = Images.getImage(Images.GOODS_BALEIYS);
			Balance.goodsTypes[39].bitmap = Images.getImage(Images.GOODS_B52);
			Balance.goodsTypes[40].bitmap = Images.getImage(Images.GOODS_POSLE6);
			//11 level
			Balance.goodsTypes[41].bitmap = Images.getImage(Images.GOODS_KONJAK);
			Balance.goodsTypes[42].bitmap = Images.getImage(Images.GOODS_SIDE_CAR);
			Balance.goodsTypes[43].bitmap = Images.getImage(Images.GOODS_ABK);
			Balance.goodsTypes[44].bitmap = Images.getImage(Images.GOODS_FRENCH_MOHITO);
			//12 level
			Balance.goodsTypes[45].bitmap = Images.getImage(Images.GOODS_ABSENT);
			Balance.goodsTypes[46].bitmap = Images.getImage(Images.GOODS_MAGNUM44);
			Balance.goodsTypes[47].bitmap = Images.getImage(Images.GOODS_ABSENT_BULL);
			Balance.goodsTypes[48].bitmap = Images.getImage(Images.GOODS_OBLAKA);
			
			//1 level
			Balance.productionTypes[0].bitmap = Images.getImage(Images.PROD_BEER);
			Balance.productionTypes[1].bitmap = Images.getImage(Images.PROD_VODKA);
			Balance.productionTypes[2].bitmap = Images.getImage(Images.PROD_ORANGE);
			Balance.productionTypes[3].bitmap = Images.getImage(Images.PROD_SODA);
			//2 level
			Balance.productionTypes[4].bitmap = Images.getImage(Images.PROD_VISKI);
			Balance.productionTypes[5].bitmap = Images.getImage(Images.PROD_LIMON);
			Balance.productionTypes[6].bitmap = Images.getImage(Images.PROD_SIROP);
			//3 level
			Balance.productionTypes[7].bitmap = Images.getImage(Images.PROD_ICE);
			Balance.productionTypes[8].bitmap = Images.getImage(Images.PROD_JIN);
			//4 level
			Balance.productionTypes[9].bitmap = Images.getImage(Images.PROD_COFFEE);
			Balance.productionTypes[10].bitmap = Images.getImage(Images.PROD_SLIVKI);
			Balance.productionTypes[11].bitmap = Images.getImage(Images.PROD_ORANGE_LIKER);
			//5 level
			Balance.productionTypes[12].bitmap = Images.getImage(Images.PROD_SIROP_GRENADIN);
			Balance.productionTypes[13].bitmap = Images.getImage(Images.PROD_TEKILA);
			//6 level
			Balance.productionTypes[14].bitmap = Images.getImage(Images.PROD_MINT_CAP);
			Balance.productionTypes[15].bitmap = Images.getImage(Images.PROD_ROM);
			//7 level
			Balance.productionTypes[16].bitmap = Images.getImage(Images.PROD_TOMATO);
			Balance.productionTypes[17].bitmap = Images.getImage(Images.PROD_COFFEE_LIKER);
			//8 level
			Balance.productionTypes[18].bitmap = Images.getImage(Images.PROD_ENERGETIC);
			Balance.productionTypes[19].bitmap = Images.getImage(Images.PROD_BLUE_KUROSAO);
			//9 level
			Balance.productionTypes[20].bitmap = Images.getImage(Images.PROD_SAMBUKA);
			//10 level
			Balance.productionTypes[21].bitmap = Images.getImage(Images.PROD_BEILEYS);
			//11 level
			Balance.productionTypes[22].bitmap = Images.getImage(Images.PROD_KONJAK);
			//12 level
			Balance.productionTypes[23].bitmap = Images.getImage(Images.PROD_ABSENT);
			
			//Decor
			var decorType: DecorType = Balance.getDecorTypeByName('picture1');
			decorType.iconBitmap = Images.getImage(Images.DECICO_PICTURE1);
			decorType.getPart(0).bitmap = Bar.multiLoader.get(Images.PICTURE1);
			
			decorType = Balance.getDecorTypeByName('shkaf1');
			decorType.iconBitmap = Images.getImage(Images.DECICO_SHKAF1);
			decorType.getPart(0).bitmap = Bar.multiLoader.get(Images.SHKAF1);
			
			decorType = Balance.getDecorTypeByName('wall1');
			decorType.iconBitmap = Images.getImage(Images.DECICO_WALL1);
			decorType.getPart(0).bitmap = Bar.multiLoader.get(Images.WALL1);
			
			decorType = Balance.getDecorTypeByName('bartable1');
			decorType.iconBitmap = Images.getImage(Images.DECICO_BARTABLE1);
			decorType.getPart(0).bitmap = Bar.multiLoader.get(Images.BARTABLE1);
			
			decorType = Balance.getDecorTypeByName('stul1');
			decorType.iconBitmap = Images.getImage(Images.DECICO_STUL1);
			decorType.getPart(0).bitmap = BitmapUtil.cloneBitmap(Bar.multiLoader.get(Images.STUL1_BACK));
			decorType.getPart(1).bitmap = BitmapUtil.cloneBitmap(Bar.multiLoader.get(Images.STUL1_BACK));
			decorType.getPart(2).bitmap = BitmapUtil.cloneBitmap(Bar.multiLoader.get(Images.STUL1_BACK));
			decorType.getPart(3).bitmap = BitmapUtil.cloneBitmap(Bar.multiLoader.get(Images.STUL1_BACK));
			decorType.getPart(4).bitmap = BitmapUtil.cloneBitmap(Bar.multiLoader.get(Images.STUL1_FOREWARD));
			decorType.getPart(5).bitmap = BitmapUtil.cloneBitmap(Bar.multiLoader.get(Images.STUL1_FOREWARD));
			decorType.getPart(6).bitmap = BitmapUtil.cloneBitmap(Bar.multiLoader.get(Images.STUL1_FOREWARD));
			decorType.getPart(7).bitmap = BitmapUtil.cloneBitmap(Bar.multiLoader.get(Images.STUL1_FOREWARD));
			
			decorType = Balance.getDecorTypeByName('lamp1');
			decorType.iconBitmap = Images.getImage(Images.DECICO_LAMP1);
			decorType.getPart(0).bitmap = BitmapUtil.cloneBitmap(Bar.multiLoader.get(Images.LAMP1));
			decorType.getPart(1).bitmap = BitmapUtil.cloneBitmap(Bar.multiLoader.get(Images.LAMP1));
			
			decorType = Balance.getDecorTypeByName('woman_body');
			decorType.getPart(0).bitmap = Bar.multiLoader.get(Images.WOMAN_BODY);
			decorType.getPart(1).bitmap = Bar.multiLoader.get(Images.WOMAN_PANTS1);
			decorType.getPart(2).bitmap = Bar.multiLoader.get(Images.WOMAN_BUST1);
			
			decorType = Balance.getDecorTypeByName('woman_tshirt1');
			decorType.getPart(0).bitmap = Bar.multiLoader.get(Images.WOMAN_TSHIRT1);
			
			decorType = Balance.getDecorTypeByName('woman_skirt1');
			decorType.getPart(0).bitmap = Bar.multiLoader.get(Images.WOMAN_SKIRT1);
			
			decorType = Balance.getDecorTypeByName('picture2');
			decorType.iconBitmap = Images.getImage(Images.DECICO_PICTURE2);
			decorType.getPart(0).bitmap = Bar.multiLoader.get(Images.PICTURE2);

			decorType = Balance.getDecorTypeByName('picture3');
			decorType.iconBitmap = Images.getImage(Images.DECICO_PICTURE3);
			decorType.getPart(0).bitmap = Bar.multiLoader.get(Images.PICTURE3);
			
			decorType = Balance.getDecorTypeByName('wall2');
			decorType.iconBitmap = Images.getImage(Images.DECICO_WALL2);
			decorType.getPart(0).bitmap = Bar.multiLoader.get(Images.WALL2);
			
			decorType = Balance.getDecorTypeByName('wall3');
			decorType.iconBitmap = Images.getImage(Images.DECICO_WALL3);
			decorType.getPart(0).bitmap = Bar.multiLoader.get(Images.WALL3);
			
			decorType = Balance.getDecorTypeByName('wall4');
			decorType.iconBitmap = Images.getImage(Images.DECICO_WALL4);
			decorType.getPart(0).bitmap = Bar.multiLoader.get(Images.WALL4);
			
			decorType = Balance.getDecorTypeByName('wall5');
			decorType.iconBitmap = Images.getImage(Images.DECICO_WALL5);
			decorType.getPart(0).bitmap = Bar.multiLoader.get(Images.WALL5);

			decorType = Balance.getDecorTypeByName('shkaf2');
			decorType.iconBitmap = Images.getImage(Images.DECICO_SHKAF2);
			decorType.getPart(0).bitmap = Bar.multiLoader.get(Images.SHKAF2);
			
			decorType = Balance.getDecorTypeByName('shkaf3');
			decorType.iconBitmap = Images.getImage(Images.DECICO_SHKAF3);
			decorType.getPart(0).bitmap = Bar.multiLoader.get(Images.SHKAF3);

			decorType = Balance.getDecorTypeByName('bartable2');
			decorType.iconBitmap = Images.getImage(Images.DECICO_BARTABLE2);
			decorType.getPart(0).bitmap = Bar.multiLoader.get(Images.BARTABLE2);

			decorType = Balance.getDecorTypeByName('lamp2');
			decorType.iconBitmap = Images.getImage(Images.DECICO_LAMP2);
			decorType.getPart(0).bitmap = BitmapUtil.cloneBitmap(Bar.multiLoader.get(Images.LAMP2));
			decorType.getPart(1).bitmap = BitmapUtil.cloneBitmap(Bar.multiLoader.get(Images.LAMP2));
			
			decorType = Balance.getDecorTypeByName('lamp3');
			decorType.iconBitmap = Images.getImage(Images.DECICO_LAMP3);
			decorType.getPart(0).bitmap = BitmapUtil.cloneBitmap(Bar.multiLoader.get(Images.LAMP3));
			decorType.getPart(1).bitmap = BitmapUtil.cloneBitmap(Bar.multiLoader.get(Images.LAMP3));

			decorType = Balance.getDecorTypeByName('stul2');
			decorType.iconBitmap = Images.getImage(Images.DECICO_STUL2);
			decorType.getPart(0).bitmap = BitmapUtil.cloneBitmap(Bar.multiLoader.get(Images.STUL2_BACK));
			decorType.getPart(1).bitmap = BitmapUtil.cloneBitmap(Bar.multiLoader.get(Images.STUL2_BACK));
			decorType.getPart(2).bitmap = BitmapUtil.cloneBitmap(Bar.multiLoader.get(Images.STUL2_BACK));
			decorType.getPart(3).bitmap = BitmapUtil.cloneBitmap(Bar.multiLoader.get(Images.STUL2_BACK));
			decorType.getPart(4).bitmap = BitmapUtil.cloneBitmap(Bar.multiLoader.get(Images.STUL2_FOREWARD));
			decorType.getPart(5).bitmap = BitmapUtil.cloneBitmap(Bar.multiLoader.get(Images.STUL2_FOREWARD));
			decorType.getPart(6).bitmap = BitmapUtil.cloneBitmap(Bar.multiLoader.get(Images.STUL2_FOREWARD));
			decorType.getPart(7).bitmap = BitmapUtil.cloneBitmap(Bar.multiLoader.get(Images.STUL2_FOREWARD));
			
			initGameObject();
			
			mainMenuPanel = new MainMenuPanel(scene);
			if (Bar.gameFriendsIds && Bar.gameFriendsLevels) {
				mainMenuPanel.addFriends(Bar.gameFriendsIds, Bar.gameFriendsLevels);
			}
			mainMenuPanel.zOrder = MAIN_MENU_PANEL_Z_ORDER;
			mainMenuPanel.addEventListener(MainMenuPanelEvent.EVENT_ITEM_CLICK, mainMenuItemClick);
			mainMenuPanel.addEventListener(MainMenuPanelEvent.EVENT_PRODUCTION_CLICK, mainMenuProductionClick);
			mainMenuPanel.addEventListener(MainMenuPanelEvent.EVENT_LICENSE, mainMenuLicense);
			mainMenuPanel.addEventListener(MainMenuPanelEvent.EVENT_DECOR_CLICK, mainMenuDecorClick);
			mainMenuPanel.addEventListener(MainMenuPanelEvent.EVENT_DECOR_OVER, mainMenuDecorOver);
			mainMenuPanel.addEventListener(MainMenuPanelEvent.EVENT_DECOR_OUT, mainMenuDecorOut);
			mainMenuPanel.addEventListener(MainMenuPanelEvent.EVENT_INVITE_FRIEND, mainMenuInviteFriend);
			mainMenuPanel.addEventListener(MainMenuPanelEvent.EVENT_FRIEND_CLICK, mainMenuFriendClick);
			addChild(mainMenuPanel);
			
			topPanel = new TopPanel(scene);
			topPanel.zOrder = TOP_PANEL_Z_ORDER;
			//todo set avatar
//			topPanel.avatar = new Bitmap(new BitmapData(40, 40, false, 0x340aee));
//			topPanel.addEventListener(MainMenuPanelEvent.EVENT_ITEM_CLICK, mainMenuItemClick);
			addChild(topPanel);
			
			exchangeWindow = new ExchangeWindow(scene);
			exchangeWindow.x = (Bar.WIDTH - exchangeWindow.width) / 2;
			exchangeWindow.y = (Bar.HEIGHT - exchangeWindow.height) / 2;
			exchangeWindow.visible = false;
			exchangeWindow.zOrder = EXCHANGE_WINDOW_Z_ORDER;
			addChild(exchangeWindow);
			
			friendsWindow = new FriendsWindow(scene);
			friendsWindow.x = (Bar.WIDTH - friendsWindow.width) / 2;
			friendsWindow.y = (Bar.HEIGHT - friendsWindow.height) / 2;
			friendsWindow.visible = false;
			friendsWindow.zOrder = FRIENDS_WINDOW_Z_ORDER;
			friendsWindow.friendsPhotos = Bar.getInstanse().someNotInGameFriendsIds;
			addChild(friendsWindow);
			
//			productionShopWindow = new ProductionShopWindow(scene);
//			productionShopWindow.zOrder = PRODUCTION_SHOP_WINDOW_Z_ORDER;
//			productionShopWindow.visible = false;
//			productionShopWindow.addProduction(Balance.productionTypes, Bar.core.myBarPlace.user.licensedProdTypes);
//			productionShopWindow.addEventListener(ProductionShopWindowEvent.EVENT_PRODUCTION_CLICK, productionShopWindowClick);
//			productionShopWindow.addEventListener(ProductionShopWindowEvent.EVENT_LICENSE, productionShopWindowLicense);
//			addChild(productionShopWindow);
			
			cBntPanel = new ClientButtonsPanel(scene);
			cBntPanel.zOrder = CLIENT_BTN_PANEL_Z_ORDER;
			cBntPanel.y = CLIENT_BUTTONS_Y;
			cBntPanel.visible = false;
			cBntPanel.serveButton.addEventListener(GameObjectEvent.TYPE_MOUSE_CLICK, onServeClientBtnClick);
			cBntPanel.denyButton.addEventListener(GameObjectEvent.TYPE_MOUSE_CLICK, onDenyClientBtnClick);
			addChild(cBntPanel);
			
			cOrderPanel = new ClientOrderPanel(scene);
			cOrderPanel.zOrder = CLIENT_SERVE_PANEL_Z_ORDER;
			cOrderPanel.visible = false;
			cOrderPanel.addEventListener(ClientOrderPanelEvent.EVENT_PRODUCTION_ADDED, onProductionAdded);
			cOrderPanel.addEventListener(ClientOrderPanelEvent.EVENT_CANCEL, onServeCancel);
			addChild(cOrderPanel);
			
			ttProduction = new ProductionToolTip(scene);
			ttProduction.zOrder = TOOLTIP_Z_ORDER;
//			ttProduction.addEventListener(GameObjectEvent.TYPE_SET_HOVER, function (e: GameObjectEvent): void {
//				ttProduction.hide();
//			});
			addChild(ttProduction);
			
			ttClient = new ClientToolTip(scene);
			ttClient.zOrder = TOOLTIP_Z_ORDER;
			addChild(ttClient);
			
			Bar.core.addEventListener(CoreEvent.EVENT_BAR_LOADED, onBarLoaded);
			Bar.core.addEventListener(CoreEvent.EVENT_DECOR_LOADED, decorLoaded);
			Bar.core.addEventListener(CoreEvent.EVENT_PRODUCTION_LOADED, productionLoaded);
			Bar.core.addEventListener(CoreEvent.EVENT_GOODS_LOADED, goodsLoaded);
			Bar.core.addEventListener(CoreEvent.EVENT_NEW_CLIENT, newClient);
			Bar.core.addEventListener(CoreEvent.EVENT_CLIENT_STATUS_CHANGED, clientStatusChanged);
			Bar.core.addEventListener(CoreEvent.EVENT_CLIENT_DENIED, clientDenied);
			Bar.core.addEventListener(CoreEvent.EVENT_CLIENT_DELETED, clientDeleted);
			Bar.core.addEventListener(CoreEvent.EVENT_CLIENT_START_SERVING, clientStartServing);
			Bar.core.addEventListener(CoreEvent.EVENT_CLIENT_STOP_SERVING, clientStopServing);
			Bar.core.addEventListener(CoreEvent.EVENT_CLIENT_SERVED, clientServed);
			Bar.core.addEventListener(CoreEvent.EVENT_CLIENT_PAY_TIP, clientPayTip);
			Bar.core.addEventListener(CoreEvent.EVENT_CLIENT_MOOD_CHANGED, clientMoodChanged);
			Bar.core.addEventListener(CoreEvent.EVENT_PRODUCTION_LICENSED, productionLicensed);
			Bar.core.addEventListener(CoreEvent.EVENT_PRODUCTION_ADDED_TO_BAR, onAddProductionToBar);
			Bar.core.addEventListener(CoreEvent.EVENT_PRODUCTION_UPDATED, productionUpdated);
			Bar.core.addEventListener(CoreEvent.EVENT_PRODUCTION_ADDED_TO_CUR_GOODS, productionAddedToCurGoods);
			Bar.core.addEventListener(CoreEvent.EVENT_PRODUCTION_EMPTY, productionEmpty);
			Bar.core.addEventListener(CoreEvent.EVENT_PRODUCTION_DELETED, productionDeleted);
			Bar.core.addEventListener(CoreEvent.EVENT_USER_MONEY_CENT_CHANGED, userMoneyCentChanged);
			Bar.core.addEventListener(CoreEvent.EVENT_USER_MONEY_EURO_CHANGED, userMoneyEuroChanged);
			Bar.core.addEventListener(CoreEvent.EVENT_USER_EXP_CHANGED, userExpChanged);
			Bar.core.addEventListener(CoreEvent.EVENT_USER_LEVEL_CHANGED, userLevelChanged);
			Bar.core.addEventListener(CoreEvent.EVENT_USER_LOVE_CHANGED, userLoveChanged);
			Bar.core.addEventListener(CoreEvent.EVENT_BARMAN_TAKE_TIP, barmanTakeTip);
			Bar.core.addEventListener(CoreEvent.EVENT_TIPS_DELETED, tipsDeleted);
			Bar.core.addEventListener(CoreEvent.EVENT_DECOR_ADDED_TO_BAR, addDecorToBar);
			
			timeStamp = new Date().getTime() / 1000;
			timer = new Timer(1000, 0);
			timer.addEventListener(TimerEvent.TIMER, function (event: TimerEvent): void {
				var now: Number = new Date().getTime() / 1000;
				if (hoverProductionGameObject && !ttProduction.visible && ((now - timeStamp) >= 0.5)) {
					var p: Production = Bar.core.getProductionById(hoverProductionGameObject.id);
					ttProduction.setAttrs(p.typeProduction.name, p.partsCount);
					ttProduction.surfaceXY(hoverProductionGameObject.x + hoverProductionGameObject.width / 2,
												hoverProductionGameObject.y, 20);
				}
			});
			timer.start();
			
			if (Bar.invitedIds) {
				showBonus();
			}
		}

		/**
		 * Создание динамических игровых объектов:
		 * 	-Клиенты
		 * 	-Продукция
		 * 	-Декор
		 * 	-Чаевые
		 */
		public function initGameObject(): void {
			//удаляем клиентов, если они есть
			if (goClients) {
				for each (var o: GameObject in goClients) {
					o.removeEventListener(GameObjectEvent.TYPE_MOUSE_CLICK, onClientMouseClick);
					o.removeEventListener(GameObjectEvent.TYPE_LOST_FOCUS, onClientLostFocus);
					o.removeEventListener(GameObjectEvent.TYPE_SET_HOVER, onClientSetHover);
					o.removeEventListener(GameObjectEvent.TYPE_LOST_HOVER, onClientLostHover);
					removeChild(o);
				}
			}
			// создание пустых клиентов			
			goClients = new Array(Balance.maxClientsCount);
			for (var i: int = 0; i < Balance.maxClientsCount; i++) {
				var uiClient: UIClient = new UIClient(scene);
				uiClient.moodClient = 0;
				uiClient.visible = false;
				uiClient.zOrder = CLIENT_Z_ORDER;
				uiClient.addEventListener(GameObjectEvent.TYPE_MOUSE_CLICK, onClientMouseClick);
				uiClient.addEventListener(GameObjectEvent.TYPE_LOST_FOCUS, onClientLostFocus);
				uiClient.addEventListener(GameObjectEvent.TYPE_SET_HOVER, onClientSetHover);
				uiClient.addEventListener(GameObjectEvent.TYPE_LOST_HOVER, onClientLostHover);
				goClients[i] = uiClient;
				addChild(uiClient);
			}
			//Заново пересоздавать декор не надо, т.к. он показывается visible|!visible в зависимости от пользователя
			if (goDecor) {
				for each (o in goDecor) {
					o.visible = false;
					o.alpha = 0.5;
				}
			}
			//создание декора, если еще не создан.
			if (!goDecor) {
				goDecor = new Array();
				for (i = 0; i < Balance.decorTypes.length; i++) {
					var dt: DecorType = Balance.decorTypes[i] as DecorType;
					for (var partIndex: int = 0; partIndex < dt.parts.length; partIndex++) {
						var decorPart: DecorPart = dt.getPart(partIndex);
						var go: GameObject = new GameObject(scene);
						go.type = dt.type;
						go.bitmap = decorPart.bitmap;
						go.visible = false;
						go.zOrder = decorPart.zOrder;
						go.x = decorPart.x;
						go.y = decorPart.y;
						go.alpha = 0.5;
						goDecor.push(go);
						addChild(go);
					}
				}
			}
			if (goTips) {
				//при смене бара в любом случае скрываем все чаевые
				for each (o in goTips) {
					o.visible = false;
				}
			}
			if (!goTips) {
				//создание пустых чаевых
				goTips = new Array(Balance.maxClientsCount);
				tipsClientIds = new Array(Balance.maxClientsCount);
				for (i = 0; i < Balance.maxClientsCount; i++) {
					go = new GameObject(scene);
					go.visible = false;
					go.setSelect(true);
					go.bitmap = BitmapUtil.cloneBitmap(Bar.multiLoader.get(Images.TIPS));
					go.zOrder = TIPS_Z_ORDER;
					go.x = TIPS_POSITION_X[i];
					go.y = TIPS_POSITION_Y;
					go.addEventListener(GameObjectEvent.TYPE_MOUSE_CLICK, onTipsMouseClick);
					go.addEventListener(GameObjectEvent.TYPE_SET_HOVER, onItemSetHover);
					go.addEventListener(GameObjectEvent.TYPE_LOST_HOVER, onItemLostHover);
					goTips[i] = go;
					tipsClientIds[i] = 0;
					addChild(go);
				}
			}
			//удаляем продукцию, если она есть
			if (goProduction) {
				for each (o in goProduction) {
					o.addEventListener(GameObjectEvent.TYPE_DRAG_STARTED, shelf.onDragStartedProductionObject);
					o.addEventListener(GameObjectEvent.TYPE_DRAG_STARTED, onDragStartedProductionObject);
					o.addEventListener(GameObjectEvent.TYPE_DRAGGING, shelf.onDragProductionObject);
					o.addEventListener(GameObjectEvent.TYPE_MOUSE_UP, shelf.onProductionMouseUp);
					o.addEventListener(GameObjectEvent.TYPE_MOUSE_UP, onProductionMouseUp);
					o.addEventListener(GameObjectEvent.TYPE_SET_HOVER, onProductionMouseHover);
					o.addEventListener(GameObjectEvent.TYPE_LOST_HOVER, onProductionLostHover);
					shelf.deleteProduction(o);
					removeChild(o);
				}
			}
			goProduction = new Array();
			prodCount = 0;
			shelf = new UIShelf(scene, false);
			shelf.addEventListener(UIShelfEvent.EVENT_PRODUCTION_PLACE_CHANGED, onShelfProductionPlaceChanged);
			shelf.zOrder = SHELF_Z_ORDER;
			addChild(shelf);
		}
		
		private var dontHideCBtn: Boolean;
		public function sceneMouseClick(event: MouseEvent): void {
			if (cBntPanel.visible && !dontHideCBtn) {
				cBntPanel.visible = false;
			}
			dontHideCBtn = false;
		}
		
		public function mainMenuProductionClick(event: MainMenuPanelEvent): void {
			Bar.core.buyProduction(event.productionType);
		}
		
		public function mainMenuLicense(event: MainMenuPanelEvent): void {
			Bar.core.licenseProduction(event.productionType);
		}
		
		public function mainMenuDecorClick(event: MainMenuPanelEvent): void {
			Bar.core.buyDecor(event.decorType);	
		}
		
		public function mainMenuDecorOver(event: MainMenuPanelEvent): void {
			if (!Bar.core.myBarPlace.decorExist(event.decorType) && Bar.core.myBarPlace.user.level >= event.decorType.accessLevel) {
				// скрыть существующий декор этой категории при предпросмотре
				for each (var d: Decor in Bar.core.myBarPlace.decor) {
					if (d.typeDecor.category == event.decorType.category) {
						for each (go in goDecor) {
							if (go.type == d.typeDecor.type) {
								go.visible = false;
							}
						}
					}
				}
				// предпросмотр декора
				for each (var go: GameObject in goDecor) {
					if (go.type == event.decorType.type) {
						go.visible = true;
					}
				}
			}
		}
		
		public function mainMenuDecorOut(event: MainMenuPanelEvent): void {
			if (!Bar.core.myBarPlace.decorExist(event.decorType) && Bar.core.myBarPlace.user.level >= event.decorType.accessLevel) {
				for each (var go: GameObject in goDecor) {
					if (go.type == event.decorType.type) {
						go.visible = false;
					}
				}
				// вернуть существующий декор этой категории при предпросмотре
				for each (var d: Decor in Bar.core.myBarPlace.decor) {
					if (d.typeDecor.category == event.decorType.category) {
						for each (go in goDecor) {
							if (go.type == d.typeDecor.type) {
								go.visible = true;
							}
						}
					}
				}
			}
		}
		
		public function mainMenuItemClick(event: MainMenuPanelEvent): void {
			switch (event.menuItem) {
				case MainMenuPanel.MENU_WINE_SHOP:
					//productionShopWindow.visible = true;
				break;
				case MainMenuPanel.MENU_BAR_ASSORTIMENT:
				
				break;
				case MainMenuPanel.MENU_NEWS:
				
				break;
			}
		}
		
		public function mainMenuInviteFriend(event: MainMenuPanelEvent): void {
			//TODO
			if (friendsWindow) {
				friendsWindow.visible = true;
			}
		}
		
		public function mainMenuFriendClick(event: MainMenuPanelEvent): void {
			addChild(innerPreloader);
			Bar.core.loadBar(event.user.id);
		}
		
		public function onShelfProductionPlaceChanged(event: UIShelfEvent): void {
			Bar.core.moveProduction(event.gameObject.id, event.cellIndex, event.rowIndex);
		}
		
		public function onServeCancel(event: ClientOrderPanelEvent): void {
			Bar.core.stopClientServing(clientGameObject.id);
		}
		
		/**
		 * Завершена анимация приготовления в окне обслуживания
		 */
		public function onProductionAdded(event: ClientOrderPanelEvent): void {
			Bar.core.makeGoods(event.production);
		}
		
		public function onServeClientBtnClick(event: GameObjectEvent): void {
			Bar.core.startClientServing(clientGameObject.id);
		}
		
		public function onDenyClientBtnClick(event: GameObjectEvent): void {
			Bar.core.denyClient(clientGameObject.id);
		}
		
		public function onDragStartedProductionObject(event: GameObjectEvent): void {
			event.gameObject.zOrder = PRODUCTION_ACTIVE_Z_ORDER;
			ttProduction.hide();
		}
		
		public function onProductionMouseUp(event: GameObjectEvent): void {
			var xx: Number = event.gameObject.x + event.gameObject.width / 2;
			var yy: Number = event.gameObject.y + event.gameObject.height / 2;
			if (cOrderPanel.visible && UIUtil.inRect(new Point(xx, yy), new Rectangle(cOrderPanel.x - 10, cOrderPanel.y - 10, cOrderPanel.width + 20, cOrderPanel.height + 20))) {
				var p: Production = Bar.core.getProductionById(event.gameObject.id);
				cOrderPanel.addProduction(p);
				shelf.addProduction(event.gameObject, true, p.rowIndex, p.cellIndex);
				// Bar.core.makeGoods(p); вызовется, когда завершится анимация приготовления
			}
			else {
				shelf.resetAllHighlights();
				shelf.addProduction(event.gameObject);
			}
			event.gameObject.zOrder = PRODUCTION_Z_ORDER;
		}
		
		public function onProductionMouseHover(event: GameObjectEvent): void {
			var cmf: ColorMatrixFilter = new ColorMatrixFilter([
			1,0,0,0,80,
			0,1,0,0,60,
			0,0,1,0,40,
			0,0,0,1,0
			]);
			event.gameObject.applyFilter(cmf);
			if (!event.gameObject.isDragging) {
				//TODO bug 'p' can be null (когда обслуживание не заканчивается - хотя продуктов на order панели уже нет)
				hoverProductionGameObject = event.gameObject;
				timeStamp = new Date().getTime() / 1000;
			}
		}
		
		public function onProductionLostHover(event: GameObjectEvent): void {
			event.gameObject.removeFilter(ColorMatrixFilter);
			hoverProductionGameObject = null;
			ttProduction.hide();
		}
		
		public function addClient(c: Client): void {
			var uiClient: UIClient = goClients[c.position] as UIClient;
			uiClient.clientUser = c;
			uiClient.visible = true;
			if (!Bar.core.myBarShowed()) {
				uiClient.moodClient = 0;
			}
			var visAction: Visible = new Visible(scene, 'visClient', uiClient);
			visAction.duration = 1000;
			visAction.start();
		}
		
		public function onItemSetHover(event: GameObjectEvent): void {
			event.gameObject.applyFilter(new GlowFilter(0xffffff, 1, 10, 10));
		}
		
		public function onItemLostHover(event: GameObjectEvent): void {
			event.gameObject.removeFilter(GlowFilter);
		}
		
		public function onClientSetHover(event: GameObjectEvent): void {
			//todo изменение прозрачности
			event.gameObject.applyFilter(new GlowFilter(0xffffff, 1, 10, 10));
			var c: Client = Bar.core.getClientById(event.gameObject.id);
			ttClient.setAttrs(c.name, c.orderGoodsType.name, Balance.getGoodsTypeByName(c.orderGoodsType.type).bitmap);
			ttClient.surfaceXY(CLIENT_SIT_CENTER_X[(event.gameObject as UIClient).client.position], CLIENT_SIT_Y - 220, 10);
		}
		
		public function onClientLostHover(event: GameObjectEvent): void {
			event.gameObject.removeFilter(GlowFilter);
			ttClient.hide();
		}
		
		public function onClientLostFocus(event: GameObjectEvent): void {
			//cBntPanel.visible = false;
		}
		
		public function onClientMouseClick(event: GameObjectEvent): void {
			if (Bar.core.myBarShowed()) {
				ttClient.hide();
				clientGameObject = event.gameObject;
				var c: UIClient = event.gameObject as UIClient;
				cBntPanel.x = CLIENT_SIT_CENTER_X[c.client.position] - cBntPanel.width / 2;
				cBntPanel.visible = true;
				dontHideCBtn = true;
			}
		}
		
		public function onTipsMouseClick(event: GameObjectEvent): void {
			Bar.core.takeTips(tipsClientIds[goTips.indexOf(event.gameObject)]);
		}
		
		public function deleteClient(c: Client): void {
			var uiClient: UIClient = goClients[c.position] as UIClient;
			uiClient.visible = false;
		}
		
		public function addProduction(p: Production): void {
			try {
				var go: GameObject = new GameObject(scene);
				go.id = p.id;
				go.zOrder = PRODUCTION_Z_ORDER;
				go.setSelect(true);
				go.canDrag = true;
				go.setFocus(true, false);
				go.setHover(true, false);
				go.type = UIShelf.GAME_OBJECT_TYPE;
				go.bitmap = BitmapUtil.cloneBitmap(p.typeProduction.bitmap);
	//			var t:TextField = new TextField();
	//			t.text = p.typeProduction.type;
	//			t.autoSize = TextFieldAutoSize.LEFT;
	//			t.selectable = false;
	//			go.setTextField(t);
				go.addEventListener(GameObjectEvent.TYPE_DRAG_STARTED, shelf.onDragStartedProductionObject);
				go.addEventListener(GameObjectEvent.TYPE_DRAG_STARTED, onDragStartedProductionObject);
				go.addEventListener(GameObjectEvent.TYPE_DRAGGING, shelf.onDragProductionObject);
				go.addEventListener(GameObjectEvent.TYPE_MOUSE_UP, shelf.onProductionMouseUp);
				go.addEventListener(GameObjectEvent.TYPE_MOUSE_UP, onProductionMouseUp);
				go.addEventListener(GameObjectEvent.TYPE_SET_HOVER, onProductionMouseHover);
				go.addEventListener(GameObjectEvent.TYPE_LOST_HOVER, onProductionLostHover);
				goProduction.push(go);
				prodCount++;
				addChild(go);
				shelf.addProduction(go, false, p.rowIndex, p.cellIndex);
			}
			catch (e: Error) {
				
			}
		}
		
		public function deleteProduction(p: Production): void {
			prodCount--;
			var go: GameObject = scene.getChildById(p.id);
			goProduction.splice(goProduction.indexOf(go), 1);
			shelf.deleteProduction(go);
			removeChild(go);
		}
		
		public function highLightNeedProduction(): void {
			if (Bar.core.currentGoods) {
				for each (var go: GameObject in goProduction) {
					go.removeFilter(GlowFilter);
				}
				var needProduction: Array = Bar.core.currentGoods.needProduction;
				for each (var np: Object in needProduction) {
					for each (var p: Production in Bar.core.myBarPlace.production) {
						if (p.typeProduction.type == np['productionType']) {
							scene.getChildById(p.id).applyFilter(new GlowFilter(0xffffff, 1, 10, 10));
						}
					}
				}
			}
			else {
				for each (go in goProduction) {
					go.removeFilter(GlowFilter);
				}
			}
		}
		
		//-----------------------------------------------------------
		//-------------------- Core Events --------------------------
		//-----------------------------------------------------------
		
		
		public function onBarLoaded(event: CoreEvent): void {
			Bar.showDebug('UIBarPlace.Bar Loaded: ' + event.barPlace.user.fullName);
			if (event.barPlace.user.fullName) {
				topPanel.userName = event.barPlace.user.fullName;
			}
			topPanel.cents = event.barPlace.user.moneyCent;
			topPanel.euro = event.barPlace.user.moneyEuro;
			topPanel.love = event.barPlace.user.love;
			topPanel.level = event.barPlace.user.level;
			topPanel.exp = event.barPlace.user.experience;
			
			// очистить и заново создать игровые объекты
			initGameObject();
			
			for each (var p: Production in event.barPlace.production) {
				addProduction(p);
			}
			for each (var d: Decor in event.barPlace.decor) {
				for each (var go: GameObject in goDecor) {
					if (go.type == d.typeDecor.type) {
						go.visible = true;
						go.alpha = 1.0;
					}
				}
			}
			for each (var c: Client in event.barPlace.clients) {
				addClient(c);
			}
			if (Bar.viewer_id == event.barPlace.user.id_user) {
				mainMenuPanel.addProduction(Balance.productionTypes, Bar.core.myBarPlace.user.licensedProdTypes, Bar.core.myBarPlace.user.level);
				mainMenuPanel.addDecor(Balance.decorTypes, Bar.core.myBarPlace.user.level);
				mainMenuPanel.addGoods(Balance.goodsTypes, Bar.core.myBarPlace.user.level);
				mainMenuPanel.setDecorForSell(Bar.core.enableForBuyDecor());
				if (Bar.core.firstLaunch) {
					showTutorial(TUTORIAL_HELLO);
				}
				else {
					if (!friendsWindowShowed) {
						friendsWindow.visible = true;
						friendsWindowShowed = true;
					}
				}
				mainMenuPanel.myBarMode = true;
				for each (var o: GameObject in goProduction) {
					o.setSelect(true);
				}
			}
			else {
				mainMenuPanel.myBarMode = false;
				for each (o in goProduction) {
					o.setSelect(false);
				}
			}
			topPanel.photoUrl = Bar.core.currentBar.user.photoPath;
			if (contains(innerPreloader)) {
				removeChild(innerPreloader);
			}
		}
		
		public function decorLoaded(event: CoreEvent): void {
			
		}
		
		public function productionLoaded(event: CoreEvent): void {
			
		}
		
		public function goodsLoaded(event: CoreEvent): void {
			
		}
		
		public function newClient(event: CoreEvent): void {
			trace('New Client: ' + event.client.name + '. Order: ' + event.client.orderGoodsType.name + '. In bar: ' + Bar.core.myBarPlace.clients.length + ' clients.');
			addClient(event.client);
		}
		
		public function clientStartServing(event: CoreEvent): void {
			trace('Start Serving Client: ' + event.client.name + '. Order: ' + event.client.orderGoodsType.name);
			cBntPanel.visible = false;
			var xx: Number = 0;
			switch (event.client.position) {
				case 0:
				xx = 30;
				break;
				case 3:
				xx = -40;
				break;
			}
			cOrderPanel.showGoods(event.client.orderGoodsType,
									CLIENT_SIT_CENTER_X[event.client.position] - cOrderPanel.width / 2 + xx,
									clientGameObject.y + (clientGameObject.height - cOrderPanel.height) / 2);
			highLightNeedProduction();
		}
		
		public function clientStopServing(event: CoreEvent): void {
			trace('Stop Serving Client: ' + event.client.name + '. Order: ' + event.client.orderGoodsType.name);
			cOrderPanel.visible = false;
			highLightNeedProduction();
		}
		
		public function clientServed(event: CoreEvent): void {
			trace('Client Served: ' + event.client.name);
			cOrderPanel.visible = false;
			deleteClient(event.client);
			highLightNeedProduction();
			if (Bar.core.firstLaunch && event.firstClientServed) {
				showTutorial(TUTORIAL_AFTER_FIRST_SERVE);
			}
		}
		
		public function clientStatusChanged(event: CoreEvent): void {
			switch (event.client.status) {
				case Client.STATUS_WAITING:
					
				break;
				case Client.STATUS_ORDERING:
					
				break;
				case Client.STATUS_EATING:
					
				break;
			}
		}
		
		public function clientPayTip(event: CoreEvent): void {
			trace('$$$ Tips Cents:: ' + event.tipMoneyCent + ' - ' + event.client.name);
			//Bar.core.takeTips(event.client.id);
			var tipGo: GameObject = (goTips[event.tipPosition] as GameObject);
			tipGo.visible = true;
			tipsClientIds[event.tipPosition] = event.clientId;
		}
		
		public function clientDeleted(event: CoreEvent): void {
			//trace('Client deleted:: ' + event.client.name + '. In bar: ' + Bar.core.myBarPlace.clients.length + ' clients.');
			//deleteClient(event.client);
		}
		
		public function clientDenied(event: CoreEvent): void {
			trace('Client denied:: ' + event.client.name + '. In bar: ' + Bar.core.myBarPlace.clients.length + ' clients.');
//			modelStat.lastLevel.clientsDenied.push(event.client);
			cBntPanel.visible = false;
			deleteClient(event.client);
		}
		
		public function clientMoodChanged(event: CoreEvent): void {
			trace('Mood changed:: ' + event.client.mood + '(0-' + Balance.maxClientMood + ') ' + event.client.name);
			var uiClient: UIClient = goClients[event.client.position] as UIClient;
			uiClient.moodClient = event.client.mood;
		}
		
		public function onAddProductionToBar(event: CoreEvent): void {
			trace('Production added to bar:: Production: ' + event.production.typeProduction.name + '(' + event.production.partsCount + ') ' + event.production.id);
			addProduction(event.production);
		}
		
		public function productionUpdated(event: CoreEvent): void {
			//TODO возврат продукции на полке в исходное состояние
			for each (var p: Production in event.barPlace.production) {
				var prodGO: GameObject = scene.getChildById(p.id);
				if (!prodGO) {
					//TODO координаты
					addProduction(p);
				}
			}
		}
		
		public function productionAddedToCurGoods(event: CoreEvent): void {
			highLightNeedProduction();
			trace('Production added to cur goods:: Production: ' + event.production.typeProduction.name + '(' + event.production.partsCount + ') ' + event.production.id);
		}
		
		public function productionEmpty(event: CoreEvent): void {
			trace('Production Empty:: ' + event.production.typeProduction.name + '(' + event.production.partsCount + ') ' + event.production.id);
			Bar.core.deleteProduction(event.production.id);
		}
		
		public function productionDeleted(event: CoreEvent): void {
			trace('Production Deleted:: ' + event.production.typeProduction.name + '(' + event.production.partsCount + ') ' + event.production.id);
			deleteProduction(event.production);
		}
		
		public function userMoneyCentChanged(event: CoreEvent): void {
			var d: Number = event.newMoneyCent - event.oldMoneyCent;
			trace('$$$ Money Cents: ' + event.newMoneyCent + ' (' + ((event.newMoneyCent > event.oldMoneyCent)?'+':'') + d + ')');
			topPanel.cents = event.newMoneyCent;
//			modelStat.lastLevel.moneyCent = event.newMoneyCent;
//			if (d >= 0) {
//				modelStat.lastLevel.moneyCentUp += d;
//			}
//			else {
//				modelStat.lastLevel.moneyCentDown += d;
//			}
		}
		
		public function userMoneyEuroChanged(event: CoreEvent): void {
			var d: Number = event.newMoneyEuro - event.oldMoneyEuro;
			trace('$$$ Money Euro: ' + event.newMoneyEuro + ' (' + ((event.newMoneyEuro > event.oldMoneyEuro)?'+':'') + d + ')');
			topPanel.euro = event.newMoneyEuro;
		}
		
		public function userLevelChanged(event: CoreEvent): void {
			var d: Number = event.newLevel - event.oldLevel;
			trace('Level: ' + event.newLevel + ' (' + ((event.newLevel > event.oldLevel)?'+':'') + d + ')');
			topPanel.level = event.newLevel;
			mainMenuPanel.setLevel(Bar.core.myBarPlace.user.licensedProdTypes, event.newLevel);
			if (Bar.core.firstLaunch) {
				showTutorial(TUTORIAL_LEVEL2_UP);
			}
			showUpLevel(event.newLevel);
//			modelStat.lastLevel.endLevel();
//			trace(modelStat.lastLevel.toString());
//			modelStat.startNewLevel(event.newLevel);
		}
		
		public function userLoveChanged(event: CoreEvent): void {
			var d: Number = event.newLove - event.oldLove;
			trace('Love: ' + event.newLove + ' (' + ((event.newLove > event.oldLove)?'+':'') + d + ')');
//			modelStat.lastLevel.loveCount += d;
			topPanel.love = event.newLove;
		}
		
		public function userExpChanged(event: CoreEvent): void {
			var d: Number = event.newExp - event.oldExp;
			topPanel.exp = event.newExp;
			trace('Experience: ' + event.newExp + ' (' + ((event.newExp > event.oldExp)?'+':'') + d + ')');
		}
		
		public function barmanTakeTip(event: CoreEvent): void {
			trace('Barman take tip: ' + event.tipMoneyCent + '. From client: ' + event.clientId);
			(goTips[event.tipPosition] as GameObject).visible = false;
		}
		
		public function tipsDeleted(event: CoreEvent): void {
			trace('Tips Deleted. Position: ' + event.tipPosition);
			(goTips[event.tipPosition] as GameObject).visible = false;
		}
		
		public function addDecorToBar(event: CoreEvent): void {
			trace('Decor added to bar:: Decor: ' + event.decor.typeDecor.name + '. Id:' + event.decor.id);
//			modelStat.lastLevel.decor.push(event.decor);
			// при замещении декора из одной категории - старый декор необходимо сделать полупрозрачным
			for each (var dt: DecorType in Balance.decorTypes) {
				if (
					(dt.category == event.decor.typeDecor.category)
					&& (dt.type != event.decor.typeDecor.type)
				) {
					for each (go in goDecor) {
						if (go.type == dt.type) {
							go.visible = false;
							go.alpha = 0.5;
						}
					}
				}
			}
			// обновить декор в магазине на главной панели
			mainMenuPanel.setDecorForSell(Bar.core.enableForBuyDecor());
			for each (var go: GameObject in goDecor) {
				if (go.type == event.decor.typeDecor.type) {
					go.visible = true;
					go.alpha = 1.0;
				}
			}
		}
		
		public function productionLicensed(event: CoreEvent): void {
			trace('Production Licensed: ' + event.typeProduction.type + ' Cost: ' + event.typeProduction.licenseCostCent + 'c. ' + event.typeProduction.licenseCostEuro + 'e.');
//			modelStat.lastLevel.licensedProdTypes.push(event.typeProduction);
			mainMenuPanel.licenseProduction(event.typeProduction);
		}
		//-----------------------------------------------------------------------
		//-----------------------------------------------------------------------
		// Окна бонусов
		//-----------------------------------------------------------------------
		//-----------------------------------------------------------------------
		public static const BONUS_WIDTH: Number = 300;
		public var BONUS_HEIGHT: Number = 300;
		public static const BONUS_TEXT_WIDTH: Number = 250;
		public static const BONUS_TEXT_Y: Number = 25;
		public var BONUS_BTN_Y: Number = 277;
		public var bonusWindow: Window;
		public var bonusGoButton: GameObject;
		public var bonusMessageTextField: TextField;
		public function showBonus(): void {
			if (Bar.core) {
				Bar.core.changeUserMoney(Balance.bonusFromInvite * Bar.invitedIds.length, 0);
			}
			if (!bonusMessageTextField) {
				bonusMessageTextField = new TextField();
				bonusMessageTextField.defaultTextFormat = new TextFormat(Bar.DEFAULT_FONT, 14);
				bonusMessageTextField.width = TUTORIAL_TEXT_WIDTH;
				bonusMessageTextField.wordWrap = true;
				bonusMessageTextField.selectable = false;
				bonusMessageTextField.autoSize = TextFieldAutoSize.CENTER;
				bonusMessageTextField.x = (BONUS_WIDTH - bonusMessageTextField.width) / 2;
				bonusMessageTextField.y = TUTORIAL_TEXT_Y;
				if (Bar.invitedIds) {
					bonusMessageTextField.text = 'Тебе начислено ' + (Balance.bonusFromInvite * Bar.invitedIds.length) + ' центов!\n';
					bonusMessageTextField.appendText('Тобой были приглашены:\n');
					for (var i: int = 0; i < Bar.invitedIds.length; i++) {
						bonusMessageTextField.appendText('     ' + (Bar.invitedNames[i] as String) + '\n');
					}
				}
				//BONUS_HEIGHT = bonusMessageTextField.height + 40;
				//BONUS_BTN_Y = BONUS_HEIGHT - 33;
			}
			if (!bonusWindow) {
				bonusWindow = new Window(scene, BONUS_WIDTH, BONUS_HEIGHT);
				bonusWindow.zOrder = BONUS_WINDOW_Z_ORDER;
				bonusWindow.x = (Bar.WIDTH - bonusWindow.width) / 2;
				bonusWindow.y = (Bar.HEIGHT - bonusWindow.height) / 2;
				addChild(bonusWindow);
				bonusWindow.addChild(bonusMessageTextField);
			}
			bonusWindow.visible = true;
			if (!bonusGoButton) {
				bonusGoButton = new GameObject(scene);
				bonusGoButton.bitmap = Images.getImage(Images.BTN_PLAY);
				bonusGoButton.x = (BONUS_WIDTH - bonusGoButton.width) / 2;
				bonusGoButton.y = BONUS_BTN_Y;
				bonusGoButton.setSelect(true);
				bonusWindow.addChild(bonusGoButton);
				bonusGoButton.addEventListener(GameObjectEvent.TYPE_MOUSE_CLICK, function (event: GameObjectEvent): void {
						bonusWindow.visible = false;
				});
			}
		}
		
		//-----------------------------------------------------------------------
		//-----------------------------------------------------------------------
		// Окна туториала
		//-----------------------------------------------------------------------
		//-----------------------------------------------------------------------
		
		public static const TUTORIAL_HELLO: String = 't_hello';
		public static const TUTORIAL_ATTRS: String = 't_attrs';
		public static const TUTORIAL_SERVING: String = 't_serving';
		public static const TUTORIAL_AFTER_FIRST_SERVE: String = 't_after_first_serve';
		public static const TUTORIAL_LEVEL2_UP: String = 't_level2_up';
		
		public static const TUTORIAL_WIDTH: Number = 300;
		public static const TUTORIAL_HEIGHT: Number = 300;
		public static const TUTORIAL_TEXT_WIDTH: Number = 250;
		public static const TUTORIAL_TEXT_Y: Number = 25;
		public static const TUTORIAL_BTN_Y: Number = 277;
		public var tutorialWindow: Window;
		public var tutorialArrow: GameObject;
		public var tutorialNextButton: GameObject;
		public var tutorialGoButton: GameObject;
		public var tutorialMessageTextField: TextField;
		public var tutorialState: String;
		public function showTutorial(state: String): void {
			tutorialState = state;
			if (!tutorialWindow) {
				tutorialWindow = new Window(scene, TUTORIAL_WIDTH, TUTORIAL_HEIGHT);
				tutorialWindow.zOrder = TUTORIAL_WINDOW_Z_ORDER;
				tutorialWindow.x = (Bar.WIDTH - tutorialWindow.width) / 2;
				tutorialWindow.y = (Bar.HEIGHT - tutorialWindow.height) / 2;
				addChild(tutorialWindow);
			}
			tutorialWindow.visible = true;
			if (!tutorialArrow) {
				tutorialArrow = new GameObject(scene);
				tutorialArrow.zOrder = TUTORIAL_ARROW_Z_ORDER;
				addChild(tutorialArrow);
			}
			tutorialArrow.visible = false;
			if (!tutorialNextButton) {
				tutorialNextButton = new GameObject(scene);
				tutorialNextButton.bitmap = Images.getImage(Images.BTN_NEXT);
				tutorialNextButton.x = (TUTORIAL_WIDTH - tutorialNextButton.width) / 2;
				tutorialNextButton.y = TUTORIAL_BTN_Y;
				tutorialNextButton.setSelect(true);
				tutorialWindow.addChild(tutorialNextButton);
				tutorialNextButton.addEventListener(GameObjectEvent.TYPE_MOUSE_CLICK, function (event: GameObjectEvent): void {
					switch (tutorialState) {
						case TUTORIAL_HELLO:
							showTutorial(TUTORIAL_ATTRS);
						break;
						case TUTORIAL_ATTRS:
							showTutorial(TUTORIAL_SERVING);
						break;
						case TUTORIAL_SERVING:
						break;
						case TUTORIAL_AFTER_FIRST_SERVE:
						break;
						case TUTORIAL_LEVEL2_UP:
						break;
					}
				});
			}
			tutorialNextButton.visible = false;
			if (!tutorialGoButton) {
				tutorialGoButton = new GameObject(scene);
				tutorialGoButton.bitmap = Images.getImage(Images.BTN_PLAY);
				tutorialGoButton.x = (TUTORIAL_WIDTH - tutorialGoButton.width) / 2;
				tutorialGoButton.y = TUTORIAL_BTN_Y;
				tutorialGoButton.setSelect(true);
				tutorialWindow.addChild(tutorialGoButton);
				tutorialGoButton.addEventListener(GameObjectEvent.TYPE_MOUSE_CLICK, function (event: GameObjectEvent): void {
					switch (tutorialState) {
						case TUTORIAL_HELLO:
						break;
						case TUTORIAL_ATTRS:
						break;
						case TUTORIAL_SERVING:
							hideTutorial();
						break;
						case TUTORIAL_AFTER_FIRST_SERVE:
							hideTutorial();
						break;
						case TUTORIAL_LEVEL2_UP:
							hideTutorial();
						break;
					}
				});
			}
			tutorialGoButton.visible = false;
			if (!tutorialMessageTextField) {
				tutorialMessageTextField = new TextField();
				tutorialMessageTextField.defaultTextFormat = new TextFormat(Bar.DEFAULT_FONT, 14);
				tutorialMessageTextField.width = TUTORIAL_TEXT_WIDTH;
				tutorialMessageTextField.wordWrap = true;
				tutorialMessageTextField.selectable = false;
				tutorialMessageTextField.autoSize = TextFieldAutoSize.CENTER;
				tutorialMessageTextField.x = (tutorialWindow.width - tutorialMessageTextField.width) / 2;
				tutorialMessageTextField.y = TUTORIAL_TEXT_Y;
				tutorialWindow.addChild(tutorialMessageTextField);
			}
			tutorialMessageTextField.visible = false;
//			if (tutorialWindow.contains(messageTextField)) {
//				tutorialWindow.removeChild(messageTextField);
//			}
			switch (tutorialState) {
				case TUTORIAL_HELLO:
					tutorialMessageTextField.text = 'Привет!\n' + 
						'Поздравляю, у тебя теперь есть свой бар.\n' +
						'Здесь ты сможешь принимать посетителей и зарабатывать деньги!\n' +
						'Обустраивай свой бар - сделай его самым лучшим!';
					tutorialMessageTextField.visible = true;
					tutorialNextButton.visible = true;
					break;
				case TUTORIAL_ATTRS:
					//TODO arrow
					//TODO иконки характеристик
					tutorialMessageTextField.text = 'Тебе как владельцу стоит знать все основные характеристики:\n' + 
							'Уровень - отображается рядом с твоим аватаром\n' + 
							'Опыт - прибавляется от каждого приготовленного коктейля.'
							'Любовь - уровень любви твоих клиентов. Чем больше любовь, тем выше количество посетителей.\n' + 
							'Центы - основной вид денег для покупки продукции в магазине.\n' + 
							'Евро - служат для покупки специальных предметов интерьера и оплаты некоторых услуг.';
					tutorialMessageTextField.visible = true;
					tutorialNextButton.visible = true;
					break;
				case TUTORIAL_SERVING:
					//TODO arrow
					//TODO иконка кнопки обслужить
					tutorialMessageTextField.text = 'А вот и твой первый посетитель!\n' + 
							'Кликай на посетителя, а затем на кнопку "Обслужить".\n' + 
							'Для приготовления коктейля перетаскивай нужную продукцию с полки на панель с изображением коктейля.';
					tutorialMessageTextField.visible = true;
					tutorialGoButton.visible = true;
					break;
				case TUTORIAL_AFTER_FIRST_SERVE:
					//TODO arrow to shop
					//TODO иконка магазина продукции
					tutorialMessageTextField.text = 'Отлично!\n' + 
							'Посетитель ушел в хорошем настроении и наверняка зайдет еще :)\n' + 
							'Если у тебя закончилась какая-то продукция, ты можешь купить ее в магазине.\n' + 
							'Теперь ты знаешь все необходимое для начала работы. Набери 2 уровень!';
					tutorialMessageTextField.visible = true;
					tutorialGoButton.visible = true;
					break;
				case TUTORIAL_LEVEL2_UP:
					tutorialMessageTextField.text = 'Некоторые виды алкогольной продукции требуют лицензии на них.\n' +
						'Купи лецензию и сможешь приобретать этот товар в свой бар.\n\n' +
						'Также ты можешь обустраивать свой бар, приобретая новые предметы в "Магазине интерьера".\n' +
						'Это позволит повысить количество посетителей и их любовь к тебе.\n' + 
						'Сделай свой бар самым красивым!';
					tutorialMessageTextField.visible = true;
					tutorialGoButton.visible = true;
					break;
			}
//			tutorialWindow.addChild(messageTextField);
		}
		
		public function hideTutorial(): void {
			tutorialWindow.visible = false;
			tutorialArrow.visible = false;
		}
		
		//-----------------------------------------------------------------------
		//-----------------------------------------------------------------------
		// Окна переходов между уровенями
		//-----------------------------------------------------------------------
		//-----------------------------------------------------------------------
		
		public static const UP_LEVEL_WIDTH: Number = 700;
		public static const UP_LEVEL_HEIGHT: Number = 300;
		public static const UP_LEVEL_TEXT_WIDTH: Number = 500;
		public static const UP_LEVEL_TEXT_Y: Number = 30;
		public static const UP_LEVEL_BTN_Y: Number = 250;
		public static const UP_LEVEL_GOODS_Y: Number = 100;
		public static const UP_LEVEL_PRODUCTION_Y: Number = 190;
		public static const UP_LEVEL_BETWEEN_PANELS: Number = 5;
		public var upLevelWindow: Window;
		public var upLevelGoButton: GameObject;
		public var upLevelMessageTextField: TextField;
		public var upLevel: Number;
		public var upLevelProduction: Array;
		public var upLevelGoods: Array;
		
		public function showUpLevel(level: Number): void {
			upLevel = level;
			if (!upLevelWindow) {
				upLevelWindow = new Window(scene, UP_LEVEL_WIDTH, UP_LEVEL_HEIGHT);
				upLevelWindow.zOrder = UP_LEVEL_WINDOW_Z_ORDER;
				upLevelWindow.x = (Bar.WIDTH - upLevelWindow.width) / 2;
				upLevelWindow.y = (Bar.HEIGHT - upLevelWindow.height) / 2;
				addChild(upLevelWindow);
			}
			upLevelWindow.visible = true;
			if (!upLevelGoButton) {
				upLevelGoButton = new GameObject(scene);
				upLevelGoButton.bitmap = Images.getImage(Images.BTN_PLAY);
				upLevelGoButton.x = (UP_LEVEL_WIDTH - upLevelGoButton.width) / 2;
				upLevelGoButton.y = TUTORIAL_BTN_Y;
				upLevelGoButton.setSelect(true);
				upLevelWindow.addChild(upLevelGoButton);
				upLevelGoButton.addEventListener(GameObjectEvent.TYPE_MOUSE_CLICK, function (event: GameObjectEvent): void {
					hideUpLevel();
				});
			}
			upLevelGoButton.visible = true;
			if (!upLevelMessageTextField) {
				upLevelMessageTextField = new TextField();
				upLevelMessageTextField.defaultTextFormat = new TextFormat(Bar.DEFAULT_FONT, 14);
				upLevelMessageTextField.width = UP_LEVEL_TEXT_WIDTH;
				upLevelMessageTextField.wordWrap = true;
				upLevelMessageTextField.selectable = false;
				upLevelMessageTextField.autoSize = TextFieldAutoSize.CENTER;
				upLevelMessageTextField.x = (upLevelWindow.width - upLevelMessageTextField.width) / 2;
				upLevelMessageTextField.y = TUTORIAL_TEXT_Y;
				upLevelWindow.addChild(upLevelMessageTextField);
			}
			upLevelMessageTextField.text = 'Поздравляем! Теперь посетители могут заказать новые коктейли и напитки!\n' +
				'А в магазине ты сможешь купить новую продукцию.';
			upLevelMessageTextField.visible = true;
			if (!upLevelProduction) {
				upLevelProduction = new Array();
			}
			else {
				for each (pp in upLevelProduction) {
					if (upLevelWindow.contains(pp)) {
						upLevelWindow.removeChild(pp);
					}
				}
				upLevelProduction = new Array();
			}
			for each (var pt: ProductionType in Balance.productionTypes) {
				if (upLevel == pt.accessLevel) {
					upLevelProduction.push(new ProductionPanel(scene, pt, null));
				}
			}
			var xx: Number = (UP_LEVEL_WIDTH - (upLevelProduction.length * ProductionPanel.WIDTH + (upLevelProduction.length - 1) * UP_LEVEL_BETWEEN_PANELS)) / 2;
			for each (var pp: ProductionPanel in upLevelProduction) {
				pp.x = xx;
				pp.y = UP_LEVEL_PRODUCTION_Y; 
				pp.enabledProduction = true;
				pp.licensed = true;
				xx += ProductionPanel.WIDTH + UP_LEVEL_BETWEEN_PANELS;
				upLevelWindow.addChild(pp);
			}
			if (!upLevelGoods) {
				upLevelGoods = new Array();
			}
			else {
				for each (gp in upLevelGoods) {
					if (upLevelWindow.contains(gp)) {
						upLevelWindow.removeChild(gp);
					}
				}
				upLevelGoods = new Array();
			}
			for each (var gt: GoodsType in Balance.goodsTypes) {
				if (upLevel == gt.accessLevel) {
					upLevelGoods.push(new GoodsPanel(scene, gt, null));
				}
			}
			xx = (UP_LEVEL_WIDTH - (upLevelGoods.length * GoodsPanel.WIDTH + (upLevelGoods.length - 1) * UP_LEVEL_BETWEEN_PANELS)) / 2;
			for each (var gp: GoodsPanel in upLevelGoods) {
				gp.x = xx;
				gp.y = UP_LEVEL_GOODS_Y; 
				gp.enabledGoods = true;
				xx += GoodsPanel.WIDTH + UP_LEVEL_BETWEEN_PANELS;
				upLevelWindow.addChild(gp);
			}
		}
		
		public function hideUpLevel(): void {
			upLevelWindow.visible = false;
		}
	}
}
