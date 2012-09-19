package {
	import com.bar.api.Server;
	import com.bar.api.ServerEvent;
	import com.bar.model.Core;
	import com.bar.model.CoreEvent;
	import com.bar.model.StartMessage;
	import com.bar.ui.UIBarPlace;
	import com.bar.ui.UIShelf;
	import com.bar.ui.windows.FriendsWindow;
	import com.bar.ui.windows.MessageWindow;
	import com.bar.ui.windows.PreloaderForm;
	import com.bar.util.Images;
	import com.efnx.events.MultiLoaderEvent;
	import com.efnx.net.MultiLoader;
	import com.flashmedia.basics.GameScene;
	import com.flashmedia.debug.DebugConsole;
	import com.flashmedia.socialnet.SocialNet;
	import com.flashmedia.socialnet.SocialNetEvent;
	import com.flashmedia.socialnet.SocialNetUser;
	import com.google.analytics.GATracker;
	import com.util.Selector;
	
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Rectangle;
	import flash.ui.Keyboard;

	[SWF(width="730", height="730", backgroundColor="#ffffff", frameRate="25")]

	public class Bar extends GameScene
	{
		/**
		 * Части прогресса загрузки
		 */
		public static const PROGRESS_SERVER_LOGIN_SUCCESS: int = 20;
		public static const PROGRESS_USER_INFO_LOADED: int = 10;
		public static const PROGRESS_SOCIAL_NET_FRIENDS_LOADED: int = 20;
		public static const PROGRESS_TOTAL: int = Images.IMAGES.length + PROGRESS_SERVER_LOGIN_SUCCESS + 2*PROGRESS_USER_INFO_LOADED + 2*PROGRESS_SOCIAL_NET_FRIENDS_LOADED;		
		
		public static const DEFAULT_FONT: String = "Comic Sans MS";
		protected static const CONSOLE_KEY: uint = Keyboard.D;
		public static const CONSOLE_ENABLED: Boolean = true;
		public static const GA_ENABLED: Boolean = true;
		public static const CONF_DEBUG: int = 11;
		public static const CONF_RELEASE: int = 12;
		public static var conf: int = CONF_RELEASE;
		
		
		/**
		 * Вывод отладки в консоль, в т.ч. экранную консоль.
		 **/
//		public static const DEBUG: Boolean = false;
		public static const WIDTH: Number = 730;
		public static const HEIGHT: Number = 730;
		
		
		/**
		 * это id пользователя, со страницы которого было запущено приложение. Или по приглашению.
		 */
		public static var user_id: String;		
		public static var auth_key: String = '';
		public static var sid: String = "";
		public static var secret: String = "";
		public static var is_app_user: String = "";
		public static var api_result: String = "";
		public static var api_settings: String = "";
		public static var referrer: String = "";
		public static var access_token: String = "";
		public static var viewer_id: String = '';
		public static var api_url: String = "";
		public static var fullName: String = '';
		public static var photoPath: String = '';
		public static var host: String = '';
		public static var port: int = 0;
		public static var password: String = '';
		public static var imagesHost: String = '';
		
		
		public static var server: Server;
		public static var core: Core;
		public static var socialNet: SocialNet;
		public static var multiLoader: MultiLoader;
		public static var itemWithdraw: String;
		public static var gaTracker: GATracker;
		/**
		 * [SocialNetUser] Все френды пользователя
		 */
		public var allFriends: Array;
		/**
		 * Id друзей в игре. Отсортированы в порядке уменьшения уровня
		 */
		public static var gameFriendsIds: Array;
		/**
		 * Уровни друзей в игре. Параллельный массив предыдущему.
		 */
		public static var gameFriendsLevels: Array;
		/**
		 * Несколько Id друзей, которые не в игре. Для показа их на форме приглашения.
		 */
		public var someNotInGameFriendsIds: Array;
//		public static var someNotInGameFriendsPhotosPathes: Array;
//		public static var someNotInGameFriendsPhotos: Array;
		/**
		 * Приглашенные этим пользователем
		 */
		public static var invitedIds: Array;
		public static var invitedNames: Array;
		public static var invitedPhotoPathes: Array;
		/**
		 * Ошибка при получении данных из соцсети.
		 */
		private var socialNetError: Boolean;
		/**
		 * Шаг увеличения полосы загрузки.
		 */
		private var progressStep: Number = 0.95;
		
		private var nameAndPhotoLoaded: Boolean;
		private var _loadState: int;
		public var uiBarPlace: UIBarPlace;
		private var preloaderForm: PreloaderForm;
		private static var instanse: Bar;
		public var wrapper: Object;
		/**
		 * Debug
		 */
		private static var console: DebugConsole;
		
		public function Bar()
		{
			applyConfiguration();
			Bar.showDebug("start app");
			instanse = this;
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public static function sendGAStat($id: String): void {
			if (gaTracker && GA_ENABLED) {
				gaTracker.trackPageview($id);
			}
		}
		
		public static function applyConfiguration(): void {
			switch (conf) {
				case CONF_RELEASE: {
					imagesHost = 'http://www.tvoibar.1gb.ru/tb/img/';
					viewer_id = '9028622';  //57856825	9028622 77625236
					fullName = 'Пользователь';
					photoPath = 'http://cs295.vkontakte.ru/u9028622/a_f6aef0ce.jpg';
					host = '81.177.143.226';
					port = 1139;
					password = 'password';
					break;
				}
				case CONF_DEBUG:
				default: {
//					imagesHost = "http://www.tvoibar.1gb.ru/tb/img/";
					imagesHost = '../images/';
					viewer_id = '9028622';  //57856825	9028622 77625236
					fullName = 'Артем Гришанов';
					photoPath = 'http://cs295.vkontakte.ru/u9028622/a_f6aef0ce.jpg';
					host = '127.0.0.1';
					port = 1139;
					password = 'password';
				}
			}
		}
		
		public static function getInstanse(): Bar {
			if (!instanse) {
				instanse = new Bar();
			}
			return instanse;
		}
		
		public function startGame(): void {
			showDebug("startGame");
			if (uiBarPlace) {
				return;
			}
			if (_loadState == 0) {
				return;
			}
			if (!multiLoader.isLoaded) {
				return
			}
//			if (!someNotInGameFriendsPhotos ||
//					someNotInGameFriendsPhotos.length != someNotInGameFriendsIds.length) {
//				if (!socialNetError) {
//					return;
//				}
//			}
			uiBarPlace = new UIBarPlace(this);
			if (nameAndPhotoLoaded) {
				uiBarPlace.topPanel.userName = fullName;
				uiBarPlace.topPanel.photoUrl = photoPath;
			}
			core.load();
		}
		
		public function onBonusFromInvite(event: ServerEvent): void {
			invitedIds = event.invitedIds;
			invitedNames = event.invitedNames;
			invitedPhotoPathes = event.invitedPhotoPathes;
			if (uiBarPlace) {
				uiBarPlace.showBonus();
			}
		}
		
		public function onWithdrawVotesOk(event: ServerEvent): void {
			Bar.showDebug("WithOk: " + event.item + " " + event.votes);
			var centsDelta: int = 0;
			var euroDelta: int = 0;
			switch(event.item) {
				case 'cents':
					switch (event.votes) {
						case 100:
							centsDelta = 1000;
						break;
						case 200:
							centsDelta = 3000;
						break;
						case 300:
							centsDelta = 5000;
						break;
						case 500:
							centsDelta = 10000;
						break;
					}
				break;
				case 'euro':
					switch (event.votes) {
						case 100:
							euroDelta = 1;
						break;
						case 200:
							euroDelta = 3;
						break;
						case 300:
							euroDelta = 5;
						break;
						case 500:
							euroDelta = 10;
						break;
					}
				break;
			}
			core.changeUserMoney(centsDelta, euroDelta);
			needToWithdrawVotes = 0;
		}
		
		private var needToWithdrawVotes: int;
		public function onWithdrawVotesNotEnough(event: ServerEvent): void {
			if (wrapper) {
				/*
				* В метод showPaymentBox передается количество голосов в целых единицах, а не сотых
				*/
				wrapper.external.showPaymentBox(event.votes / 100);
				needToWithdrawVotes = event.votes;
			}
		}
		
		public function onWithdrawVotesError(event: ServerEvent): void {
			//TODO message box
			needToWithdrawVotes = 0;
		}
		
		public function showInviteWindow(): void {
			if (wrapper) {
				wrapper.external.showInviteBox();
			}
		}
		
		public function onAddedToStage(e: Event): void {
			gaTracker = new GATracker(this, "UA-33637436-1", "AS3", false);
			Bar.sendGAStat("/appLoadingStarted");
				Bar.showDebug("addedToStage");
				wrapper = this.parent.parent;
		    	if (wrapper && wrapper.application && wrapper.external) {
					Bar.showDebug("Getting parameters from wrapper...");
					api_url = wrapper.application.parameters.api_url;
		    		viewer_id = wrapper.application.parameters.viewer_id;
		    		user_id = wrapper.application.parameters.user_id;
		    		auth_key = wrapper.application.parameters.auth_key;
					sid = wrapper.application.parameters.sid;
					secret = wrapper.application.parameters.secret;
					is_app_user = wrapper.application.parameters.is_app_user;
					api_result = wrapper.application.parameters.api_result;
					api_settings = wrapper.application.parameters.api_settings;
					referrer = wrapper.application.parameters.referrer;
					access_token = wrapper.application.parameters.access_token;
					
					Bar.showDebug("user_id=" + user_id);
					Bar.showDebug("auth_key=" + auth_key);
					Bar.showDebug("viewer_id=" + viewer_id);
					Bar.showDebug("sid=" + sid);
					Bar.showDebug("api_url=" + api_url);
					Bar.showDebug("secret=" + secret);
					Bar.showDebug("is_app_user=" + is_app_user);
					Bar.showDebug("api_result=" + api_result);
					Bar.showDebug("api_settings=" + api_settings);
					Bar.showDebug("referrer=" + referrer);
					Bar.showDebug("access_token=" + access_token);
					
		    		wrapper.addEventListener('onBalanceChanged', onBalanceChanged);
		    		appObject = wrapper.application;
					//wrapper.application.scaleMode = StageScaleMode.NO_SCALE;
					//wrapper.application.quality = StageQuality.HIGH;
					//wrapper.application.align = StageAlign.LEFT;
		    		//wrapper.external.callMethod('resizeWindow', WIDTH, HEIGHT);
	//	    		
	//	    		api_result = appObject.parameters.api_result;
	//	    		VKontakte.apiUrl = appObject.parameters.api_url;
	//	    		Util.viewer_id = appObject.parameters.viewer_id;
	//	    		Util.user_id = appObject.parameters.user_id;
	//	    		if (Util.viewer_id != Util.user_id) {
	//	    			Util.api.invite();
	//	    		}
	//	    		Util.wrapper.addEventListener('onApplicationAdded', onApplicationAdded);
	//	    		Util.wrapper.addEventListener('onSettingsChanged', onSettingsChanged);
		    	}
				MultiLoader.usingContext = true;
				multiLoader = new MultiLoader();
				server = new Server(host, port, true);
				Bar.showDebug("server created: " + host + " " + port);
				core = new Core(viewer_id, server, UIShelf.SHELF_ROW_COUNT * UIShelf.SHELF_CELL_COUNT);
				core.addEventListener(CoreEvent.EVENT_BAR_LOADED, onBarLoaded);
				socialNet = new SocialNet(viewer_id, SocialNet.NET_VKONTAKTE);
				socialNet.addEventListener(SocialNetEvent.ERROR, onSocialNetError);
				socialNet.addEventListener(SocialNetEvent.USER_INFO, onUserInfoLoaded);
				socialNet.addEventListener(SocialNetEvent.GET_FRIENDS, onSocialNetFriendsLoaded);
//				server.connect(viewer_id, password);
				server.addEventListener(ServerEvent.EVENT_BONUS_FROM_INVITE, onBonusFromInvite);
				server.addEventListener(ServerEvent.EVENT_WITHDRAW_VOTES_OK, onWithdrawVotesOk);
				server.addEventListener(ServerEvent.EVENT_WITHDRAW_VOTES_NOT_ENOUGH, onWithdrawVotesNotEnough);
				server.addEventListener(ServerEvent.EVENT_WITHDRAW_VOTES_ERROR, onWithdrawVotesError);
				server.addEventListener(ServerEvent.EVENT_LOGIN_SUCCESS, onServerLoginSuccess);
				server.addEventListener(ServerEvent.EVENT_FRIENDS_LOADED, onServerFriendsLoaded);
		    	multiLoader.addEventListener(ErrorEvent.ERROR, onMultiloaderError);
		    	multiLoader.addEventListener(MultiLoaderEvent.COMPLETE, onMultiLoaderCompleted);
				for each (var image: String in Images.PRE_IMAGES) {
					multiLoader.load(imagesHost + image, image, 'Bitmap');
				}
				this.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		
		private function onBalanceChanged(event: Event): void {
			Bar.showDebug("onBalanceChanged. Votes=" + needToWithdrawVotes);
			if (server && (needToWithdrawVotes > 0)) {
				server.withdrawVotes(needToWithdrawVotes, Bar.itemWithdraw, Bar.auth_key);
			}
		}
		
		private function onSocialNetError(event: SocialNetEvent): void {
			showDebug("SocialNetError" + event.errorCode + " " + event.errorMessage);
			socialNetError = true;
			startGame();
		}
		
		private function onUserInfoLoaded(event: SocialNetEvent): void {
			showDebug("onUserInfoLoaded");
			for (var i: int = 0; i < event.users.length; i++) {
				var u: SocialNetUser = event.users[i] as SocialNetUser;
				if (u.id == viewer_id) {
					// пользователь - это мы
					if (core && event.users.length > 0) {
						nameAndPhotoLoaded = true;
						core.setUserAttrs(u.fullName, u.photoBigUrl);
						fullName = u.fullName;
						photoPath = u.photoBigUrl;
						if (uiBarPlace) {
							uiBarPlace.topPanel.name = fullName;
							uiBarPlace.topPanel.photoUrl = photoPath;
						}
					}
					if (!allFriends) {
						//Этап основной загрузки. Если друзья нашего пользователя, еще не были загружены - загружаем
						socialNet.getFriends();
					}
				}
				else {
					// пользователь - кто-то еще
					for (var j: int = 0; j < allFriends.length; j++) {
						var au: SocialNetUser = allFriends[j];
						if (u.id == au.id) {
							allFriends[j].firstName = u.firstName;
							allFriends[j].lastName = u.lastName;
							allFriends[j].birthday = u.birthday;
							allFriends[j].nickname = u.nickname;
							allFriends[j].photoBigUrl = u.photoBigUrl;
							allFriends[j].photoMediumUrl = u.photoMediumUrl;
							allFriends[j].photoUrl = u.photoUrl;
							allFriends[j].sex = u.sex;
						}
					}
//					for (var fi: Number = 0; fi < someNotInGameFriendsIds.length; fi++) {
//						if (u.id == someNotInGameFriendsIds[fi]) {
//							someNotInGameFriendsPhotosPathes.push(u.photoBigUrl);
//							multiLoader.load(u.photoBigUrl, u.photoBigUrl, 'Bitmap');
//						}
//					}
					//продолжаем основную загрузку - огрузим все изображения
					if (_loadState == 1) {
						_loadState = 2;
						for each (var image: String in Images.IMAGES) {
							multiLoader.load(imagesHost + image, image, 'Bitmap');
						}
					}
				}
			}
			if (preloaderForm) {
				preloaderForm.progress += PROGRESS_USER_INFO_LOADED;
			}
		}

		private function onServerLoginSuccess(event: ServerEvent): void {
			socialNet.getUserInfo([viewer_id]);
			if (user_id && (user_id != viewer_id)) {
				server.enterByInvite(user_id);
			}
			preloaderForm.progress += PROGRESS_SERVER_LOGIN_SUCCESS;
		}
		
		private function onBarLoaded(event: CoreEvent): void {
			if (preloaderForm) {
				preloaderForm.destroy();
				removeChild(preloaderForm);
				preloaderForm = null;
				addChild(uiBarPlace);
				Bar.sendGAStat("/appLoadingCompleted");
			}
			for each (var sm: StartMessage in core.myBarPlace.user.startMessages) {
//				var msgw: MessageWindow = new MessageWindow(this, MessageWindow.WIDTH, MessageWindow.HEIGHT,
//					"Заголовок сообщения lbksks jkwjk jkwej klwej fjse flsjek jjlj jlwj", "А знаете ли вы?</br>И еще немного текста после даже с переносом.<img align=\"center\" alt=\"\" src=\"http://stg.odnoklassniki.ru/res/default/Images/holiday/ballons_72x72.png\"><p>Конец</p>", "sjsj");
				//<img align="center" alt="" src="http://tvoibar.1gb.ru/tb/img/shop/shop_love.png">
				var msgw: MessageWindow = new MessageWindow(this, MessageWindow.WIDTH, MessageWindow.HEIGHT, sm.caption, sm.htmlText, sm.buttons);
				msgw.visible = true;
				msgw.x = (Bar.WIDTH - msgw.width) / 2;
				msgw.y = (Bar.HEIGHT - msgw.height) / 2;
				msgw.zOrder = UIBarPlace.MESSAGE_WINDOW_Z_ORDER;
				uiBarPlace.addChild(msgw);
			}
		}
		
		private function onMultiloaderError(event: ErrorEvent):void {
		}
		
		private function onMultiLoaderCompleted(event:MultiLoaderEvent):void {
//			// фотографии выборочных друзей для приглашения
//			if (someNotInGameFriendsPhotosPathes) {
//				for (var i: int = 0; i < someNotInGameFriendsPhotosPathes.length; i++) {
//					var url: String = someNotInGameFriendsPhotosPathes[i];
//					if (url == event.entry) {
//						someNotInGameFriendsPhotos.push(multiLoader.get(event.entry));
//					}
//				}
//			}
			if (_loadState == 2) {
				preloaderForm.progress += progressStep;
			}
			if (multiLoader.isLoaded) {
				switch (_loadState) {
					case 0: {
						//загрузка первоначальных изображений для прелоадера завершена
						showDebug("onMultiLoaderCompleted. State=" + _loadState);
						preloaderForm = new PreloaderForm(this);
						addChild(preloaderForm);
						preloaderForm.totalProgress = PROGRESS_TOTAL;
						//Показали прелоадер, теперь можно начинать основную загрузку
						server.connect(viewer_id, password);
						_loadState = 1
						break;
					}
					case 2: {
						//Загрузка всех изображений завершена
						showDebug("onMultiLoaderCompleted. State=" + _loadState);
						multiLoader.removeEventListener(ErrorEvent.ERROR, onMultiloaderError);
						multiLoader.removeEventListener(MultiLoaderEvent.COMPLETE, onMultiLoaderCompleted);
						startGame();
						_loadState = 3;
						break;
					}
				}
			}
//			if (_preloaderShown) {
//				preloaderForm.progress += progressStep;
//			}
//			if (multiLoader.isLoaded) {
//				//multiLoader.removeEventListener(ErrorEvent.ERROR, multiloaderError);
//				//multiLoader.removeEventListener(MultiLoaderEvent.COMPLETE, multiLoaderCompleteListener);
//				
//				if (_preloaderShown) {
//					startGame();
//				}
//				else {
//					_preloaderShown = true;
//					preloaderForm = new PreloaderForm(this);
//					addChild(preloaderForm);
////					for each (var image: String in Images.IMAGES) {
////						multiLoader.load(imagesHost + image, image, 'Bitmap');
////					}
//					preloaderForm.totalProgress = Images.IMAGES.length;
//					//Показали прелоадер, теперь можно начинать основную загрузку
//					server.connect(viewer_id, password);
//				}
//			}
		}
		
		//-------------------------------------------------------------------
		//---------------------- FRIENDS ------------------------------------
		//-------------------------------------------------------------------
		/**
		 * Получены идишники друзей из соц сети
		 */
		protected function onSocialNetFriendsLoaded(event: SocialNetEvent): void {
			//запрос на наш сервер, получаем только тех, кто зарегистрирован в игре
			showDebug("onSocialNetFriendsLoaded");
			allFriends = new Array();
			for (var i: int = 0; i < event.friensdIds.length; i++) {
				var f: SocialNetUser = new SocialNetUser(event.friensdIds[i]);
				allFriends.push(f);
			}
			if (server) {
				server.loadFriends(event.friensdIds);
			}
			preloaderForm.progress += PROGRESS_SOCIAL_NET_FRIENDS_LOADED;
		}
		
		/**
		 * Получены идишники друзей, которые уже установили приложение
		 */
		 protected function onServerFriendsLoaded(event: ServerEvent): void {
		 	Bar.showDebug("onServerFriendsLoaded");
			//Выбрать те идишники, которых нет на сервере и добавить их в окно приглашений
			var notInGameUsers: Array = new Array();
			for (var ui: int = 0; ui < allFriends.length; ui++) {
				var u: SocialNetUser = allFriends[ui] as SocialNetUser;
				var notFound: Boolean = true;
				for (var fi: int = 0; fi < event.friendsIds.length; fi++) {
					if (u.id == event.friendsIds[fi]) {
						notFound = false;
						break;
					}
				}
				if (notFound) {
					notInGameUsers.push(u);
				}
			}
			var sampleFriends: Array = Selector.chooseSomeElements(notInGameUsers, FriendsWindow.ROWS_COUNT * FriendsWindow.COLUMNS_COUNT);
			if (sampleFriends) {
				var friendsIds: Array = new Array();
				for (ui = 0; ui < sampleFriends.length; ui++) {
					u = sampleFriends[ui] as SocialNetUser;
					friendsIds.push(u.id);
				}
				someNotInGameFriendsIds = friendsIds;
//				someNotInGameFriendsPhotos = new Array();
//				someNotInGameFriendsPhotosPathes = new Array();
				socialNet.getUserInfo(someNotInGameFriendsIds);
				
				progressStep = (preloaderForm.totalProgress - preloaderForm.progress) / (someNotInGameFriendsIds.length + preloaderForm.totalProgress - preloaderForm.progress);
			}
			// Сортировка идишников друзей, которые уже в игре
		 	if (Bar.server) {
			 	Bar.server.removeEventListener(ServerEvent.EVENT_FRIENDS_LOADED, onServerFriendsLoaded);
				var sortedFriendsIds: Array = new Array();
				var sortedFriendsLevels: Array = new Array();
				var sortedFriendsExp: Array = new Array();
				var added: Boolean = false;
				for (fi = 0; fi < event.friendsIds.length; fi++) {
					added = false;
					for (var si: int = 0; si < sortedFriendsIds.length; si++) {
						if (event.friendsLevels[fi] == sortedFriendsLevels[si]) {
							if (event.friendsExp[fi] > sortedFriendsExp[si]) {
								sortedFriendsIds.splice(si, -1, event.friendsIds[fi]);
								sortedFriendsLevels.splice(si, -1, event.friendsLevels[fi]);
								sortedFriendsExp.splice(si, -1, event.friendsExp[fi]);
								added = true;
							}
						}
						else if (event.friendsLevels[fi] > sortedFriendsLevels[si]) {
							sortedFriendsIds.splice(si, -1, event.friendsIds[fi]);
							sortedFriendsLevels.splice(si, -1, event.friendsLevels[fi]);
							sortedFriendsExp.splice(si, -1, event.friendsExp[fi]);
							added = true;
						}
						if (added) {
							break;
						}
					}
					if (!added) {
						sortedFriendsIds.push(event.friendsIds[fi]);
						sortedFriendsLevels.push(event.friendsLevels[fi]);
						sortedFriendsExp.push(event.friendsExp[fi]);
					}
				}
				if (sortedFriendsIds) {
					//save friends in game
					gameFriendsIds = sortedFriendsIds;
					gameFriendsLevels = sortedFriendsLevels;
				}
		 	}
		}
		
//		public function checkAppSettings():void {
//			if ((appObject.parameters.api_settings & SETTINGS_NOTICE_ACCEPT) == 0 ||
//			(appObject.parameters.api_settings & SETTINGS_FRIENDS_ACCESS) == 0 ||
//			(appObject.parameters.api_settings & SETTINGS_PHOTO_ACCESS) == 0)
//			{
//				var installSettings:int = 0;
//				installSettings |= SETTINGS_NOTICE_ACCEPT;
//				installSettings |= SETTINGS_FRIENDS_ACCESS;
//				installSettings |= SETTINGS_PHOTO_ACCESS;
//				Util.wrapper.external.showSettingsBox(installSettings);
//			}
//			else {
//				if (api_result) {
//					var json:Object = JSON.deserialize(api_result);
//					Util.user = json.response[0];
//					Util.api.registerUser(Util.user);
//				}
//				else {
//					Util.vkontakte.getProfiles(new Array(''+Util.viewer_id));
//				}
//			}
//		}

		public static function showDebug($msg: String): void {
			if (CONSOLE_ENABLED && instanse) {
				if (!console) {
					console = new DebugConsole(instanse);
					console.consoleRect = new Rectangle(0, 0, 500, 700);
					console.x = 0;
					console.y = 0;
					console.visible = false;
					console.zOrder = 10000;
				}
				console.addMessage($msg);
				trace($msg);
				instanse.addChild(console);
			}
		}
		
		protected function onKeyDown(event: KeyboardEvent): void {
			if (CONSOLE_ENABLED) {
				if (event.ctrlKey && event.keyCode == CONSOLE_KEY) {
					console.visible = !console.visible;
					instanse.addChild(console);
				}
			}
		}
	}
}
