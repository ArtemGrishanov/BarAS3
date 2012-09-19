package com.bar.model.essences
{
	import flash.display.Bitmap;
	
	public class DecorPart
	{
		/**
		 * Жесткое расположение декора в баре по координатам
		 */
		public var x: Number;
		public var y: Number;
		/**
		 * Регулирует наложение декора один на другой.
		 */
		public var zOrder: Number;
		/**
		 * Изображение, которое показывается в баре
		 */
		public var bitmap: Bitmap;
		
		public function DecorPart(_x: Number,
								  _y: Number,
								  _zOrder: Number,
								  _bitmap: Bitmap = null)
		{
			x = _x;
			y = _y;
			zOrder = _zOrder;
			bitmap = _bitmap;
		}

	}
}