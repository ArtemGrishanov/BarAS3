package com.flashmedia.socialnet.vk
{
	import com.gsolo.encryption.MD5;
	import com.serialization.json.JSON;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.TimerEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.utils.Timer;
	
	public class VKontakte extends EventDispatcher
	{
		/**
		 * Урл, который по умолчанию используется для запроса к апи
		 */
		private static const API_URL:String = 'http://api.vk.com/api.php';
		/**
		 * Секрет, необходимый для осуществления подписи запросов к API. Передается при запуске приожение во флеварс
		 */
		private static const SECRET:String = '8fa672611f';	
		private static const SID:String = '3a71ac3a90bbde5139c08ff9e5cfb8e563118b1f022614a54255217dce91b2';
		private static const APP_PRIVATE_KEY:String = 'Sf3jPCp8bdmwlsOtGlqL';
//		private static const APP_KEY_SAND_BOX:String = 'zzzzzz';
		/**
		 * это id запущенного приложения. Константа в настройках. Также известный как api_id в описании
		 */
		private static const APP_ID:String = '1955775';
		private static const VERSION:String = '3.0';
//		private static const APP_ID_SAND_BOX:String = '100000';
		/**
		 * 0 - продакшн режим. 1 - тестовый режим.
		 */
		public static var testMode: uint = 0;
		public static var apiUrl:String;
		public static var version:String = VERSION;
		public static var appId:String = APP_ID;
		public static var secret:String;
		public static var sid:String;
		
		private const loader:URLLoader = new URLLoader();
		
		private var requestQueue: Array;
		private var timer: Timer;
		private var currentMethod: String;
		private var viewer_id: String;
		
		public function VKontakte(_viewer_id: String)
		{
			apiUrl = (Bar.api_url) ? Bar.api_url : API_URL;
			secret = (Bar.secret) ? Bar.secret : SECRET;
			sid = (Bar.sid) ? Bar.sid : SID;
			viewer_id = _viewer_id;
			currentMethod = null;
			requestQueue = new Array();
			timer = new Timer(500, 0);
			timer.addEventListener(TimerEvent.TIMER, onTimer);
			timer.start();
			
			loader.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
			loader.addEventListener(Event.COMPLETE, completeHandler);
		}
		
		private function onTimer(event: TimerEvent): void {
			if (requestQueue.length > 0 && !currentMethod) {
				var r: Object = requestQueue.pop();
				request(r['method'], r['vars']);
			}
		}

		private function request(method: String, vars:URLVariables):void
		{
			if (!currentMethod) {
				currentMethod = method;
				var request: URLRequest = new URLRequest();
				request.url = apiUrl;
				request.data = vars;
				loader.load(request);
			}
			else {
				var r: Object = {'method': method, 'vars': vars};
				requestQueue.push(r);	
			}
		}
		
		private function errorHandler(e:IOErrorEvent):void {
			dispatchEvent(new VKontakteEvent(VKontakteEvent.ERROR, null, 255));
			currentMethod = null;
		}
		
		private function completeHandler(event:Event):void
		{
			Bar.showDebug("vkontakte.completeHandler. Method=" + currentMethod);
			try {
				var response:Object = JSON.deserialize(loader.data);
				if (response.hasOwnProperty('error')) {
					response = response.error;
					var errorCode:int = response.error_code;
					dispatchEvent(new VKontakteEvent(VKontakteEvent.ERROR, currentMethod, null, errorCode, response.error_msg));
					Bar.showDebug("vkontakte.error: " + errorCode + "/" + response.error_msg);
				}
				else if (response.hasOwnProperty('response')) {
					response = response.response;
					dispatchEvent(new VKontakteEvent(VKontakteEvent.COMPLETED, currentMethod, response));
					Bar.showDebug("vkontakte.response: " + loader.data.toString());
				}
			}
			catch (e:Error) {
				Bar.showDebug("vkontakte.exception");
				dispatchEvent(new VKontakteEvent(VKontakteEvent.ERROR, currentMethod, null, 254, e.message));
			}
			currentMethod = null;
		}
		
		public function getProfiles(uids:Array):void {
			Bar.showDebug("vkontakte.getProfiles");
			var uidsString:String = uids.join(',');
			var vars: Array = getCommonParams();
			vars.push("method=getProfiles");
			vars.push("uids="+uidsString);
			vars.push("fields=nickname,sex,bdate,photo_big,city,country");
			vars.push("sig="+getSig(vars));
			vars.push("sid="+sid);
			request('getProfiles', new URLVariables(vars.join("&")));
		}
		
//		public function isAppUser():void {
//			var vars: URLVariables = new URLVariables();
//			var sig:String = Util.viewer_id+'api_id='+appId+
//				'format=json'+
//				'method=isAppUser'+
//				'test_mode='+testMode+
//				'v=2.0'+appKey;
//				
//			vars['api_id'] = appId;
//			vars['v'] = '2.0';
//			vars['method'] = 'isAppUser';
//			vars['format'] = 'json';
//			vars['test_mode'] = testMode;
//			vars['sig'] = MD5.encrypt(sig);
//			
//			request('isAppUser', vars);
//		}
		
//		public function getUserSettings():void {
//			var vars: URLVariables = new URLVariables();
//			var sig:String = Util.viewer_id+'api_id='+appId+
//				'format=json'+
//				'method=getUserSettings'+
//				'test_mode='+testMode+
//				'v=2.0'+appKey;
//				
//			vars['api_id'] = appId;
//			vars['v'] = '2.0';
//			vars['method'] = 'getUserSettings';
//			vars['format'] = 'json';
//			vars['test_mode'] = testMode;
//			vars['sig'] = MD5.encrypt(sig);
//			
//			request('getUserSettings', vars);
//		}
		
		public function getFriends():void {
			Bar.showDebug("vkontakte.getFriends");
			var vars: Array = getCommonParams();
			vars.push("method=getFriends");
			vars.push("sig="+getSig(vars));
			vars.push("sid="+sid);
			request('getFriends', new URLVariables(vars.join("&")));
		}
		
//		public function getAppFriends():void {
//			var vars: URLVariables = new URLVariables();
//			var sig:String = viewer_id+'api_id='+appId+
//				'format=json'+
//				'method=getAppFriends'+
//				'test_mode='+testMode+
//				'v=2.0'+appKey;
//				
//			vars['api_id'] = appId;
//			vars['v'] = '2.0';
//			vars['method'] = 'getAppFriends';
//			vars['format'] = 'json';
//			vars['test_mode'] = testMode;
//			vars['sig'] = MD5.encrypt(sig);
//			
//			request('getAppFriends', vars);
//		}
		
//		public function getAlbums():void {
//			var vars: URLVariables = new URLVariables();
//			var sig:String = viewer_id+
//				'api_id='+appId+
//				'format=json'+
//				'method=photos.getAlbums'+
//				'test_mode='+testMode+
//				'uid='+viewer_id+
//				'v=2.0'+appKey;
//				
//			vars['api_id'] = appId;
//			vars['v'] = '2.0';
//			vars['uid'] = viewer_id;
//			vars['method'] = 'photos.getAlbums';
//			vars['format'] = 'json';
//			vars['test_mode'] = testMode;
//			vars['sig'] = MD5.encrypt(sig);
//			
//			request('photos.getAlbums', vars);
//		}
		
//		public function getPhotos(aid: String):void {
//			var vars: URLVariables = new URLVariables();
//			var sig:String = viewer_id+
//				'aid='+aid+
//				'api_id='+appId+
//				'format=json'+
//				'method=photos.get'+
//				'test_mode='+testMode+
//				'uid='+viewer_id+
//				'v=2.0'+appKey;
//				
//			vars['api_id'] = appId;
//			vars['v'] = '2.0';
//			vars['aid'] = aid;
//			vars['uid'] = viewer_id;
//			vars['method'] = 'photos.get';
//			vars['format'] = 'json';
//			vars['test_mode'] = testMode;
//			vars['sig'] = MD5.encrypt(sig);
//			
//			request('photos.get', vars);
//		}
		
//		public function getAds():void {
//			var vars: URLVariables = new URLVariables();
//			var sig:String = viewer_id+
//				'api_id='+appId+
//				'format=json'+
//				'method=getAds'+
//				'test_mode='+testMode+
//				'v=2.0'+appKey;
//				
//			vars['api_id'] = appId;
//			vars['method'] = 'getAds';
//			vars['v'] = '2.0';
//			vars['format'] = 'json';
//			vars['test_mode'] = testMode;
//			vars['sig'] = MD5.encrypt(sig);
//			
//			request('getAds', vars);
//		}
		
//		public function getCities(cids:Array):void {
//			var vars: URLVariables = new URLVariables();
//			var cidsString:String = cids.join(',');
//			var sig:String = viewer_id+
//				'api_id='+appId+
//				'cids=' + cidsString + 
//				'format=json'+
//				'method=getCities'+
//				'test_mode='+testMode+
//				'v=2.0'+appKey;
//				
//			vars['api_id'] = appId;
//			vars['method'] = 'getCities';
//			vars['v'] = '2.0';
//			vars['cids'] = cidsString;
//			vars['format'] = 'json';
//			vars['test_mode'] = testMode;
//			vars['sig'] = MD5.encrypt(sig);
//			
//			request('getCities', vars);
//		}
		
//		public function getCountries(cids:Array):void {
//			var vars: URLVariables = new URLVariables();
//			var cidsString:String = cids.join(',');
//			var sig:String = viewer_id+
//				'api_id='+appId+
//				'cids=' + cidsString + 
//				'format=json'+
//				'method=getCountries'+
//				'test_mode='+ testMode +
//				'v=2.0'+appKey;
//				
//			vars['api_id'] = appId;
//			vars['method'] = 'getCountries';
//			vars['v'] = '2.0';
//			vars['cids'] = cidsString;
//			vars['format'] = 'json';
//			vars['test_mode'] = testMode;
//			vars['sig'] = MD5.encrypt(sig);
//			
//			request('getCountries', vars);
//		}
		
		protected function getCommonParams(): Array {
			var vars: Array = new Array();
			vars.push('api_id='+appId);
			vars.push('v='+version);
			vars.push('format=json');
			vars.push('test_mode='+testMode);
			return vars;
		}
		
		protected function getSig($params: Array): String {
			$params.sort();
			var sigStr: String = viewer_id+$params.join('')+secret;
			return MD5.encrypt(sigStr);
		}
	}
}