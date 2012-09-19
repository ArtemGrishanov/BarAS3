package com.bar.ui.windows
{
	import com.bar.ui.panels.ExchangePanel;
	import com.flashmedia.basics.GameScene;
	
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;

	public class ExchangeWindow extends Window
	{
		public static const WIDTH: Number = 556;
		public static const HEIGHT: Number = 290;
		
		public static const TOP_INDENT_HEADER: Number = 10;
		public static const TOP_INDENT: Number = 50;
		public static const LEFT_INDENT: Number = 15;
		public static const BETWEEN_X_INDENT: Number = 10;
		public static const BETWEEN_Y_INDENT: Number = 10;
		
		public var epCents1000: ExchangePanel;
		public var epCents3000: ExchangePanel;
		public var epCents5000: ExchangePanel;
		public var epCents10000: ExchangePanel;
		
		public var epEuro1: ExchangePanel;
		public var epEuro3: ExchangePanel;
		public var epEuro5: ExchangePanel;
		public var epEuro10: ExchangePanel;
		
		public function ExchangeWindow(value:GameScene)
		{
			super(value, WIDTH, HEIGHT);
			var nameTf: TextField = new TextField();
			nameTf.selectable = false;
			nameTf.defaultTextFormat = new TextFormat(Bar.DEFAULT_FONT, 14, 0x000000, true);
			nameTf.text = 'Здесь вы можете приорести игровую валюту за голоса:';
			nameTf.autoSize = TextFieldAutoSize.LEFT;
			nameTf.x = (WIDTH - nameTf.width) / 2;
			nameTf.y = TOP_INDENT_HEADER;
			addChild(nameTf);
			
			epCents1000 = new ExchangePanel(scene, 100, 1000);
			epCents3000 = new ExchangePanel(scene, 200, 3000);
			epCents5000 = new ExchangePanel(scene, 300, 5000);
			epCents10000 = new ExchangePanel(scene, 500, 10000);
			
			epEuro1 = new ExchangePanel(scene, 100, 0, 1);
			epEuro3 = new ExchangePanel(scene, 200, 0, 3);
			epEuro5 = new ExchangePanel(scene, 300, 0, 5);
			epEuro10 = new ExchangePanel(scene, 500, 0, 10);

			epCents1000.x = LEFT_INDENT;			
			epCents1000.y = TOP_INDENT;
			epCents3000.x = LEFT_INDENT;			
			epCents3000.y = TOP_INDENT + (epCents1000.height + BETWEEN_Y_INDENT)* 1;
			epCents5000.x = LEFT_INDENT;			
			epCents5000.y = TOP_INDENT + (epCents1000.height + BETWEEN_Y_INDENT)* 2;
			epCents10000.x = LEFT_INDENT;			
			epCents10000.y = TOP_INDENT + (epCents1000.height + BETWEEN_Y_INDENT)* 3;
			
			epEuro1.x = LEFT_INDENT + epCents1000.width + BETWEEN_X_INDENT;			
			epEuro1.y = TOP_INDENT;
			epEuro3.x = epEuro1.x;			
			epEuro3.y = TOP_INDENT + (epEuro1.height + BETWEEN_Y_INDENT)* 1;
			epEuro5.x = epEuro1.x;			
			epEuro5.y = TOP_INDENT + (epEuro1.height + BETWEEN_Y_INDENT)* 2;
			epEuro10.x = epEuro1.x;			
			epEuro10.y = TOP_INDENT + (epEuro1.height + BETWEEN_Y_INDENT)* 3;
			
			addChild(epCents1000);
			addChild(epCents3000);
			addChild(epCents5000);
			addChild(epCents10000);
			addChild(epEuro1);
			addChild(epEuro3);
			addChild(epEuro5);
			addChild(epEuro10);
		}
	}
}