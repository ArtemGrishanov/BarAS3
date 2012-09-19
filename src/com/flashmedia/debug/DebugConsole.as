package com.flashmedia.debug
{
	import com.flashmedia.basics.GameLayer;
	import com.flashmedia.basics.GameScene;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFormat;

	public class DebugConsole extends GameLayer
	{
		protected var _consoleRect: Rectangle;
		protected var _debuggingTextFields: Array;
		
		public function DebugConsole($scene: GameScene) {
			super($scene);
			_debuggingTextFields = new Array();
		}
		
		public function set consoleRect($value: Rectangle): void {
			_consoleRect = $value;
			this.graphics.clear();
			this.graphics.beginFill(0xaaaaaa, 0.8);
			this.graphics.drawRect(0, 0, _consoleRect.width, _consoleRect.height);
			this.graphics.endFill();
			x = _consoleRect.x;
			y = _consoleRect.y;
		}
		
		public function addMessage(msg: String): void {
			var messageAdded: Boolean = false;
			if (_debuggingTextFields.length > 0) {
				var lastText: String = (_debuggingTextFields[0] as TextField).text;
				var index: Number = lastText.indexOf("~");
				var lastMessage: String = null;
				var lastCount: Number = 1;
				if (index > 0) {
					lastMessage = lastText.substring(0, index);
					var sn: String = lastText.substring(index + 1, lastText.length);
					lastCount = (Number)(sn);
					if (!(lastCount is Number)) {
						lastCount = 1;
					}
				}
				else {
					lastMessage = lastText;
				}
				if (lastMessage == msg) {
					(_debuggingTextFields[0] as TextField).text = msg + "~" + ((Number)(lastCount) + 1).toString();
					messageAdded = true;
				}
			}
			if (!messageAdded) {
				var newTf: TextField = new TextField();
				newTf.defaultTextFormat = new TextFormat("Arial", 10);
				newTf.width = _consoleRect.width;
				newTf.height = 16;
				newTf.text = msg;
				_debuggingTextFields.splice(0, 0, newTf);
				var yy: int = _consoleRect.height - newTf.height;
				var linesCount: uint = 0;
				for each (var tf: TextField in _debuggingTextFields) {
					if (yy + tf.height >= 0) {
						if (!this.contains(tf)) {
							this.addChild(tf);
						}
						tf.y = yy;
						yy -= tf.height;
						linesCount++;
					} else {
						if (this.contains(tf)) {
							this.removeChild(tf);
						}
					}
				}
				if (_debuggingTextFields.length > linesCount) {
					_debuggingTextFields.splice(linesCount, _debuggingTextFields.length - linesCount);
				}
			}
		}
	}
}