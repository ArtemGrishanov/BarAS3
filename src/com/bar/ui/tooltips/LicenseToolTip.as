package com.bar.ui.tooltips
{
	import com.bar.util.Images;
	import com.flashmedia.basics.GameScene;
	import com.flashmedia.util.BitmapUtil;
	
	import flash.display.Bitmap;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	public class LicenseToolTip extends ToolTip
	{
		public static const CAPTION_CENTER_Y: Number = 15;
		public static const PRICE_CENTER_Y: Number = 45;
		public static const ICON_TEXT_INDENT: Number = 5;
		
		private var captionTf: TextField;
		private var priceTf: TextField;
		private var moneyIcon: Bitmap;
		private var centBitmap: Bitmap;
		private var euroBitmap: Bitmap;
		
		public function LicenseToolTip(value:GameScene)
		{
			super(value);
			euroBitmap = Images.getImage(Images.TOOLBAR_EURO);
			centBitmap = Images.getImage(Images.TOOLBAR_CENTS);
			bitmapPointerDown = BitmapUtil.cloneBitmap(Bar.multiLoader.get(Images.HINT_UP1));
			captionTf = new TextField();
			captionTf.selectable = false;
			captionTf.autoSize = TextFieldAutoSize.LEFT;
			captionTf.defaultTextFormat = new TextFormat(Bar.DEFAULT_FONT, 14);
			captionTf.text = 'Лицензия:';
			captionTf.x = (width - captionTf.width) / 2;
			captionTf.y = CAPTION_CENTER_Y - captionTf.height / 2;
			
			priceTf = new TextField();
			priceTf.selectable = false;
			priceTf.autoSize = TextFieldAutoSize.LEFT;
			priceTf.defaultTextFormat = new TextFormat(Bar.DEFAULT_FONT, 14);
			priceTf.text = '0';
			priceTf.y = PRICE_CENTER_Y - priceTf.height / 2;
		}
		
		public function setPrice(cents: Number = 0, euro: Number = 0): void {
			if (euro > 0) {
				priceTf.text = euro.toString();
				moneyIcon = euroBitmap;
			}
			else if (cents > 0) {
				priceTf.text = cents.toString();
				moneyIcon = centBitmap;
			}
			if (!contains(moneyIcon)) {
				addChild(moneyIcon);
			}
			moneyIcon.y = PRICE_CENTER_Y - moneyIcon.height / 2;
			moneyIcon.x = (width - priceTf.width - ICON_TEXT_INDENT - moneyIcon.width) / 2;
			priceTf.x = moneyIcon.x + moneyIcon.width + ICON_TEXT_INDENT;
			if (!contains(captionTf)) {
				addChild(captionTf);
			}
			if (!contains(priceTf)) {
				addChild(priceTf);
			}
			super.update();
		}
	}
}