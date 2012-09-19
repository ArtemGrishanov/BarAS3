package com.bar.model
{
	public class StartMessage
	{
		public var id: int;
		public var caption: String;
		public var htmlText: String;
		public var buttons: String;
		
		public function StartMessage($id: int, $caption: String, $htmlText: String, $buttons: String)
		{
			id = $id;
			caption = $caption;
			htmlText = $htmlText;
			buttons = $buttons;
		}
	}
}