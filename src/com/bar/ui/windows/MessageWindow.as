package com.bar.ui.windows
{
	import com.bar.util.Images;
	import com.flashmedia.basics.GameObject;
	import com.flashmedia.basics.GameObjectEvent;
	import com.flashmedia.basics.GameScene;
	
	import flash.display.Scene;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	/**
	 * Универсальное окно сообщений, которое показывается при входе в приложение.
	 * Сообщения задаются на сервере и показываются один раз, если оно еще не было до этого просмотрено
	 */
	public class MessageWindow extends Window
	{
		public static const WIDTH: Number = 400;
		public static const HEIGHT: Number = 350;
		public static const CAPTION_Y: Number = 40;
		
		public var captionTf: TextField;
		public var messageTf: TextField;
		public var buttons: Array;
		
		public function MessageWindow(value:GameScene, w:Number, h:Number, $caption: String, $htmlText: String, $buttons: String)
		{
			super(value, w, h);
			
			captionTf = new TextField();
			captionTf.selectable = false;
			captionTf.defaultTextFormat = new TextFormat(Bar.DEFAULT_FONT, 14, 0x000000, true);
			captionTf.autoSize = TextFieldAutoSize.LEFT;
			captionTf.text = $caption;
			captionTf.width = 350;
			captionTf.wordWrap = true;
			captionTf.x = (WIDTH - captionTf.width) / 2;
			captionTf.y = CAPTION_Y;
			addChild(captionTf);
			
			messageTf = new TextField();
			messageTf.selectable = false;
			messageTf.defaultTextFormat = new TextFormat(Bar.DEFAULT_FONT, 14, 0x000000, false);
			messageTf.autoSize = TextFieldAutoSize.LEFT;
			messageTf.wordWrap = true;
			messageTf.multiline = true;
			messageTf.htmlText = $htmlText;
			messageTf.width = 350;
			messageTf.x = (WIDTH - messageTf.width) / 2;
			messageTf.y = CAPTION_Y + captionTf.height + 20;
			addChild(messageTf);
			
			var bt: GameObject;
//			if ($buttons) {
				//TODO обработка нескольких кнопок - выравнивание, несколько обработчиков
				
//				btnInvite = new GameObject(scene);
//				btnInvite.setSelect(true);
//				btnInvite.setHover(true, false);
//				btnInvite.bitmap = Images.getImage(Images.BTN_INVITE);
//				btnInvite.x = BTN_OK_CENTER_X - btnInvite.width / 2;
//				btnInvite.y = BTN_OK_CENTER_Y - btnInvite.height / 2;
//				btnInvite.addEventListener(GameObjectEvent.TYPE_MOUSE_CLICK, onOkBtnClick);
//				btnInvite.addEventListener(GameObjectEvent.TYPE_SET_HOVER, onItemSetHover);
//				btnInvite.addEventListener(GameObjectEvent.TYPE_LOST_HOVER, onItemLostHover);
//				addChild(btnInvite);
//			}
//			else {
				bt = new GameObject(scene);
				bt.bitmap = Images.getImage(Images.BTN_OK);
				bt.addEventListener(GameObjectEvent.TYPE_MOUSE_CLICK, onOkBtnClick);
//			}
			bt.setSelect(true);
			bt.setHover(true, false);
			bt.x = (width - bt.width) / 2;
			bt.y = height - bt.height/ 2;
			bt.addEventListener(GameObjectEvent.TYPE_SET_HOVER, onItemSetHover);
			bt.addEventListener(GameObjectEvent.TYPE_LOST_HOVER, onItemLostHover);
			addChild(bt);
		}
	
		protected function onOkBtnClick(event: GameObjectEvent): void {
			if (isModal) {
				scene.resetModal(this);
			}
			visible = false;
		}
	}
}