package com.bar.model.essences
{
	import flash.display.Bitmap;
	
	public class DecorType
	{
		public var type: String = '';
		public var name: String = '';
		/**
		 * Категория. Декор одной категории и разного типа заменяется при установке.
		 */
		public var category: String = '';
		public var accessLevel: uint;
		public var expCount: Number = 1;
		public var loveCount: Number = 1;
		public var tipProbCount: Number = 0.05;
		public var priceCent: Number;
		public var priceEuro: Number;
		/**
		 * Иконка, которая показывается в магазине.
		 * Если иконка не задана, декор не показывается в магазине.
		 */
		public var iconBitmap: Bitmap;
		
		public var parts: Array;
		
		public function DecorType(_type: String,
								_name: String,
								_category: String = null,
								_accessLevel: uint = 0,
								_expCount: Number = 1,
								_loveCount: Number = 1,
								_tipProbCount: Number = 0.05,
								_priceCent: Number = 10,
								_priceEuro: Number = 0,
								_iconBitmap: Bitmap = null)
		{
			type = _type;
			name = _name;
			category = _category;
			accessLevel = _accessLevel;
			expCount = _expCount;
			loveCount = _loveCount;
			tipProbCount = _tipProbCount;
			priceCent = _priceCent;
			priceEuro = _priceEuro;
			iconBitmap = _iconBitmap;
			parts = new Array();
		}
		
		public function getPart(index: int): DecorPart {
			if (parts && (parts.length > index)) {
				return (DecorPart)(parts[index]);
			}
			return null;
		}
	}
}