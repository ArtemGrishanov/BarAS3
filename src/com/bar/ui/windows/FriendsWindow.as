package com.bar.ui.windows
{
	import com.bar.ui.panels.FriendPanel;
	import com.bar.util.Images;
	import com.efnx.events.MultiLoaderEvent;
	import com.efnx.net.MultiLoader;
	import com.flashmedia.basics.GameObject;
	import com.flashmedia.basics.GameObjectEvent;
	import com.flashmedia.basics.GameScene;
	import com.flashmedia.gui.GridBox;
	import com.flashmedia.socialnet.SocialNetEvent;
	import com.flashmedia.socialnet.SocialNetUser;
	import com.flashmedia.util.BitmapUtil;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class FriendsWindow extends Window
	{
		public static const WIDTH: Number = 400;
		public static const HEIGHT: Number = 350;
//		public static const LEFT_ARROW_CENTER_X: Number = 210;
//		public static const LEFT_ARROW_CENTER_Y: Number = 391;
//		public static const RIGHT_ARROW_CENTER_X: Number = 357;
//		public static const RIGHT_ARROW_CENTER_Y: Number = 391;
//		public static const BTN_CANCEL_CENTER_X: Number = 183;
//		public static const BTN_CANCEL_CENTER_Y: Number = 453;
		public static const BTN_OK_CENTER_X: Number = 200;
		public static const BTN_OK_CENTER_Y: Number = 345;
		public static const GRID_BOX_X: Number = 45;
		public static const GRID_BOX_Y: Number = 80;
		public static const CAPTION_X: Number = 45;
		public static const CAPTION_Y: Number = 40;
		
		public static const ROWS_COUNT: Number = 3;
		public static const COLUMNS_COUNT: Number = 4;
		
		public var btnInvite: GameObject;
		public var captionTf: TextField;
		public var gridBox: GridBox;
		public var _multiLoader: MultiLoader;
		public var _someFriends: Array;		
		
		public function FriendsWindow(value: GameScene)
		{
			super(value, WIDTH, HEIGHT);
			
//			multiLoader = new MultiLoader();
			
			captionTf = new TextField();
			captionTf.selectable = false;
			captionTf.defaultTextFormat = new TextFormat(Bar.DEFAULT_FONT, 14, 0x000000, true);
			captionTf.autoSize = TextFieldAutoSize.LEFT;
			captionTf.text = "100 монет за каждого приглашенного друга!";
			captionTf.x = (WIDTH - captionTf.width) / 2;
			captionTf.y = CAPTION_Y;
			addChild(captionTf);

			btnInvite = new GameObject(scene);
			btnInvite.setSelect(true);
			btnInvite.setHover(true, false);
			btnInvite.bitmap = Images.getImage(Images.BTN_INVITE);
			btnInvite.x = BTN_OK_CENTER_X - btnInvite.width / 2;
			btnInvite.y = BTN_OK_CENTER_Y - btnInvite.height / 2;
			btnInvite.addEventListener(GameObjectEvent.TYPE_MOUSE_CLICK, onOkBtnClick);
			btnInvite.addEventListener(GameObjectEvent.TYPE_SET_HOVER, onItemSetHover);
			btnInvite.addEventListener(GameObjectEvent.TYPE_LOST_HOVER, onItemLostHover);
			addChild(btnInvite);
			
			gridBox = new GridBox(scene, COLUMNS_COUNT, ROWS_COUNT);
			gridBox.x = GRID_BOX_X;
			gridBox.y = GRID_BOX_Y;
			gridBox.setPaddings(0, 0, 0, 0);
			gridBox.indentBetweenCols = 5;
			gridBox.indentBetweenRows = 5;
			addChild(gridBox);
			
			_multiLoader = new MultiLoader();
			_multiLoader.addEventListener(MultiLoaderEvent.COMPLETE, onPhotoLoad);
			_someFriends = new Array();
		}
		
		/**
		 * Images - friends photos
		 */
		public function set friendsPhotos(value: Array): void {
			gridBox.removeAllItems();
			for each (var id: String in value) {
				for each (var u: SocialNetUser in Bar.getInstanse().allFriends) {
					if (u.id == id && u.photoBigUrl) {
						_someFriends.push(u);
						_multiLoader.load(u.photoBigUrl, u.photoBigUrl, "Bitmap");
					}
				}
			}
		}
		
		/**
		 * Загружены фото друзей.
		 */
		protected function onPhotoLoad(event: MultiLoaderEvent): void {
//			for each (var u: SocialNetUser in _someFriends) {
//				var loadedBitmap: Bitmap = null;
//				try {
//					loadedBitmap = _multiLoader.get(u.photoBigUrl);
//				}
//				catch (e: Error) {}
			var loadedBitmap: Bitmap = null;
			try {
				loadedBitmap = _multiLoader.get(event.entry);
			}
			catch (e: Error) {}
			if (loadedBitmap) {
				var frGo: GameObject = new GameObject(scene);
				frGo.bitmap = BitmapUtil.fillByRect(loadedBitmap, FriendPanel.WIDTH, FriendPanel.HEIGHT);
				frGo.bitmap = BitmapUtil.drawBorder(frGo.bitmap, 0xf1a62e, 1);
				frGo.buttonMode = true;
				frGo.useHandCursor = true;
				gridBox.addItem(frGo);
			}
//			}
		}
		
		protected function onOkBtnClick(event: GameObjectEvent): void {
			if (isModal) {
				scene.resetModal(this);
			}
			visible = false;
			Bar.getInstanse().showInviteWindow();
		}
	}
}