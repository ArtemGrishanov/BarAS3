package com.bar.ui.panels
{
	import com.bar.util.Images;
	import com.flashmedia.basics.GameLayer;
	import com.flashmedia.basics.GameObjectEvent;
	import com.flashmedia.basics.GameScene;
	import com.flashmedia.util.BitmapUtil;
	
	import flash.display.Bitmap;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	public class ExchangePanel extends GameLayer
	{
		public static const WIDTH: Number = 150;
		public static const HEIGHT: Number = 30;
		
		private var nameTf: TextField;
		private var moneyBitmap: Bitmap;
		private var votes: int;
		private var item: String;
		
		public function ExchangePanel(value: GameScene, votes: Number, cents: Number = 0, euro: Number = 0)
		{
			super(value);
			this.votes = votes;
			setSelect(true);
			setHover(true, false);
			bitmap = BitmapUtil.cloneBitmap(Bar.multiLoader.get(Images.EXCH_PANEL));
			
			nameTf = new TextField();
			nameTf.selectable = false;
			nameTf.defaultTextFormat = new TextFormat(Bar.DEFAULT_FONT, 14, 0xdeda72, true);
			var endStr: String = '';
			var votesToUser: int = votes / 100;
			switch (votesToUser) {
				case 1:
				break;
				case 2:
				case 3:
				case 4:
					endStr = 'а';
				break;
				default:
					endStr = 'ов';
			}
			if (cents > 0) {
				moneyBitmap = Images.getImage(Images.TOOLBAR_CENTS);
				nameTf.text = ' ' + cents.toString() + ' = ' + votesToUser.toString() + ' голос' + endStr;
				item = 'cents';
			}
			else if (euro > 0) {
				moneyBitmap = Images.getImage(Images.TOOLBAR_EURO);
				nameTf.text = ' ' + euro.toString() + ' = ' + votesToUser.toString() + ' голос' + endStr;
				item = 'euro';
			}
			addChild(moneyBitmap);
			nameTf.autoSize = TextFieldAutoSize.LEFT;
			moneyBitmap.x = (width - (nameTf.width + moneyBitmap.width)) / 2;
			moneyBitmap.y = (height - moneyBitmap.height) / 2 - 4;
			nameTf.x = moneyBitmap.x + moneyBitmap.width;
			nameTf.y = (height - nameTf.height) / 2 - 4;
			setTextField(nameTf);
			
			addEventListener(GameObjectEvent.TYPE_SET_HOVER, onItemSetHover);
			addEventListener(GameObjectEvent.TYPE_LOST_HOVER, onItemLostHover);
		}
		
		protected override function mouseClickListener(event:MouseEvent):void {
			super.mouseClickListener(event);
			if (Bar.server) {
				Bar.itemWithdraw = item;
				Bar.server.withdrawVotes(votes, item, Bar.auth_key);
			}
		}
		
		public function onItemSetHover(event: GameObjectEvent): void {
			event.gameObject.applyFilter(new GlowFilter(0xffffff, 1, 10, 10));
		}
		
		public function onItemLostHover(event: GameObjectEvent): void {
			event.gameObject.removeFilter(GlowFilter);
		}
	}
}