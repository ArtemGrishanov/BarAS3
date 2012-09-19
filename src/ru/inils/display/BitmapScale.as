package ru.inils.display {
	/**
	* @author	iNils
	* @version	1.0
	*
	* Расширяет класс Bitmap, позволяя задавать сетку масштабирования (scale9Grid) для объекта, с решением проблемы <a href="http://groups.google.com/group/ruFlash/browse_thread/thread/1ea6d9b09d979336/4d23244c565af814" target="_blank">"0x2K"</a>.
	*
	* Изменения:
	*	[+]	...
	* 	1.1 (27.01.09) - Изменена логика свойств работающих с BitmapData. Роль геттера bitmapDataOriginal перенесена в геттер bitmapData. А роль геттера bitmapData выполняет геттер bitmapDataScale.
	* 	1.0 (19.09.08 10:55)
	*/
	/*    IMPORT             *///{ /
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.PixelSnapping;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	//}
	public class BitmapScale extends Bitmap {
		/*  - VAR PRIVATE        *///{ /
		/// Оригинальное изображение из которого строится изображение с учетом сетки масштабирования.
		private var _bmp:BitmapData = null;
		/// Активная сетка масштабирования.
		private var _scale9Grid:Rectangle = null;
		//}
		/*  * CONSTRUCTOR *      *///{ /
		/**
		 * Инициализирует объект BitmapScale для ссылки на заданный объект BitmapData.
		 * @param	bmp - Объект BitmapData, указанный в ссылке.
		 * @param	pixelSnapping - Определяет, должен ли объект BitmapScale быть привязанным к ближайшему пикселу. 
		 * @param	smoothing - Определяет, следует ли смягчать растровое изображение при масштабировании.
		 */
		public function BitmapScale (bmp:BitmapData = null, scale9:Rectangle = null, pixelSnapping:String = 'auto', smoothing:Boolean = false) {
			super (bmp, pixelSnapping, smoothing);
			_bmp = bmp.clone ();
			_scale9Grid = scale9;
		}
		//}
		/*  + METHOD PUBLIC      *///{ /
		/**
		 * Создает экземпляр BitmapScale из внедренных с помощью метатега Embed внешних ресурсов.
		 * @param	embed - Класс связанный с внедренным графическим ресурсом.
		 * @return	Экземпляр BitmapScale с объектом BitmapData из внедренного графического ресурса.
		 */
		public static function createFromEmbed (embed:Class, scale9:Rectangle = null):BitmapScale {
			var bitmap:Bitmap = new embed ();
			var bitmapScale:BitmapScale = new BitmapScale (bitmap.bitmapData, scale9);
			return bitmapScale;
		}
		/**
		 * Меняет размеры изображения.
		 * @param	w - Широта изображения.
		 * @param	h - Высота изображения.
		 */
		public function setSize (w:Number, h:Number):void {
			if (_scale9Grid == null) {
				super.width = w;
				super.height = h;
			} else {
				w = Math.max (w, _bmp.width - _bmp.width);
				h = Math.max (h, _bmp.height - _bmp.height);
				resize (w, h);
			}
		}
		//}
		/*  - METHOD PRIVATE     *///{ /
		/**
		 * Задает в качестве bitmapData новый объект.
		 * @param	bmp - Новый объект BitmapData.
		 */
		private function assignBitmapData (bmp:BitmapData):void {
			super.bitmapData.dispose ();
			super.bitmapData = bmp;
		}
		/**
		 * Метод перерисовывает объект BitmapData под новые размеры.
		 * @param	w - Ширина в пикселах.
		 * @param	h - Высота в пикселях.
		 */
		private function resize (w:Number, h:Number):void {
			var bmp:BitmapData = new BitmapData (w, h, true, 0x0);
 
			var rows:Array = [0, _scale9Grid.top, _scale9Grid.bottom, _bmp.height];
			var cols:Array = [0, _scale9Grid.left, _scale9Grid.right, _bmp.width];
 
			var dRows:Array = [0, _scale9Grid.top, h - (_bmp.height - _scale9Grid.bottom), h];
			var dCols:Array = [0, _scale9Grid.left, w - (_bmp.width - _scale9Grid.right), w];
 
			var rectIn:Rectangle;
			var rectOut:Rectangle;
			var matrix:Matrix = new Matrix();
			for (var i:int = 0; i < 3; i++) {
				for (var j:int = 0; j < 3; j++) {
					rectIn = new Rectangle (cols[i], rows[j], cols[i + 1] - cols[i], rows[j + 1] - rows[j]);
					rectOut = new Rectangle (dCols[i], dRows[j], dCols[i + 1] - dCols[i], dRows[j + 1] - dRows[j]);
					matrix.identity ();
					matrix.a = rectOut.width / rectIn.width;
					matrix.d = rectOut.height / rectIn.height;
					matrix.tx = rectOut.x - rectIn.x * matrix.a;
					matrix.ty = rectOut.y - rectIn.y * matrix.d;
 
					/// Решаем проблему "0x2K". Ее описание: http://groups.google.com/group/ruFla...23244c565af814
					if (_bmp.width * matrix.a > 8192 || _bmp.height * matrix.d > 8192) {
						var bmpTemp:BitmapData = new BitmapData (rectIn.width, rectIn.height, true, 0x0)
						bmpTemp.copyPixels (_bmp, rectIn, new Point (0, 0));
 
						/// сдвиги частей
						if (i == 1) {
							matrix.tx = rectOut.x;
						} else if (i == 2) {
							matrix.tx = rectOut.left;
						}
						if (j == 1) {
							matrix.ty = rectOut.y;
						} else if (j == 2) {
							matrix.ty = rectOut.top;
						}
 
						bmp.draw (bmpTemp, matrix, null, null, null, smoothing);
						bmpTemp.dispose ();
					} else {
						bmp.draw (_bmp, matrix, null, null, rectOut, smoothing);
					}
				}
			}
			assignBitmapData (bmp);
		}
		/**
		 * Проверка на вхождения области Rectangle, задаваемой параметром rect, в область объекта BitmapData.
		 * @param	rect - Проверенный объект Rectangle.
		 * @return	Возвращается значение true, если заданный объект Rectangle не выходит за пределы объекта BitmapData; в противном случае возвращается false.
		 */
		private function validGrid (rect:Rectangle):Boolean {
			return rect.right <= _bmp.width && rect.bottom <= _bmp.height;
		}
		//}
		/*    GETTER / SETTER    *///{ /
		/**
		 * Объект BitmapData, указанный в ссылке. Функция записи будет масштабировать задаваемое изображение учитываю текущую сетку масштабирования, а функция чтения возвращает исходное изображение без учета сетки масштабирования.
		 */
		public override function get bitmapData ():BitmapData {
			return _bmp;
		}
		public override function set bitmapData	(value:BitmapData):void {
			_bmp = value.clone ();
			if (_scale9Grid == null) {
				assignBitmapData (_bmp.clone ());
			} else {
				if (!validGrid(_scale9Grid)) {
					_scale9Grid = null;
				}
				setSize (_bmp.width, _bmp.height);
			}
		}
		/**
		 * Объект BitmapData с учетом сетки масштабирования.
		 */
		public function get bitmapDataScale ():BitmapData {
			return super.bitmapData;
		}
//		/**
//		 * Задает в качестве объекта BitmapData класс ассоциированный с метатегом Embed внешнего ресурса.
//		 */
//		public function set bitmapEmbed (value:Class):void {
//			_bmp.dispose ();
//			_bmp = BitmapEmbed.getBitmapData (value);
// 
//			super.bitmapData.dispose();
//			super.bitmapData = _bmp.clone ();
//			//setSize (_bmp.width, _bmp.height);
//		}
		/**
		 * Указывает высоту экранного объекта в пикселах.
		 */
		public override function set height (value:Number):void {
			if (value != height) {
				setSize (width, value);
			}
		}
		/**
		 * Текущая активная сетка масштабирования.
		 */
		public override function get scale9Grid ():Rectangle {
			return _scale9Grid;
		}
		public override function set scale9Grid (value:Rectangle):void {
			if ((_scale9Grid == null && value != null) || (_scale9Grid != null && !_scale9Grid.equals (value))) {
				if (value == null) {
					var w:Number = width;
					var h:Number = height;
					_scale9Grid = null;
					assignBitmapData (_bmp.clone ());
					setSize (w, h);
				} else {
					if (!validGrid (value)) {
						throw (new Error ('#001 - The _scale9Grid does not match the original BitmapData'));
						return;
					}
 
					_scale9Grid = value.clone ();
					resize (width, height);
					scaleX = 1;
					scaleY = 1;
				}
			}
		}
		/**
		 * Указывает ширину экранного объекта в пикселах.
		 */
		public override function set width (value:Number):void {
			if (value != width) {
				setSize (value, height);
			}
		}
		//}
	}
}