package com.bar.util
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.LoaderInfo;
	import flash.utils.getDefinitionByName;
	
	public class Images
	{
		/**
		 * Используемые класса для компиляции
		 */
		private static var forceClass1: client1;
		private static var forceClass2: client2;
		private static var forceClass3: client3;
		private static var forceClass4: client4;
		private static var forceClass5: client5;
		private static var forceClass6: client6;
		
		private static var forceClass7: ABK;
		private static var forceClass8: absent;
		private static var forceClass9: absent_bull;
		private static var forceClass10: apelsinoviy;
		private static var forceClass11: apelsinoviy_liker;
		private static var forceClass12: b_52;
		private static var forceClass13: beileys;
		private static var forceClass15: belaya_ledi;
		private static var forceClass16: black_russian;
		private static var forceClass17: blood_mary;
		private static var forceClass18: blue_curasao;
		private static var forceClass19: blue_lagoon;
		private static var forceClass20: blue_margarita;
		private static var forceClass21: coffe;
		private static var forceClass22: coffe_liker;
		private static var forceClass23: energetic;
		private static var forceClass24: ersh;
		private static var forceClass25: french_mohito;
		private static var forceClass26: gin;
		private static var forceClass27: gin_tonic;
		private static var forceClass28: granatovyi_mix;
		private static var forceClass29: irish_coffe;
		private static var forceClass30: jameson_viski_sayer;
		private static var forceClass31: konjak;
		private static var forceClass32: magnum44;
		private static var forceClass33: mai_tai;
		private static var forceClass34: margarita;
		private static var forceClass35: millionair;
		private static var forceClass36: mohito;
		private static var forceClass37: Oblaka;
		private static var forceClass38: otvertka;
		private static var forceClass39: paradizo;
		private static var forceClass40: pivo;
		private static var forceClass41: posle_shesti;
		private static var forceClass42: roketnoe_toplivo;
		private static var forceClass43: rom;
		private static var forceClass44: sambuka;
		private static var forceClass45: sex_in_the_beach;
		private static var forceClass46: side_car;
		private static var forceClass47: sladkaya_havanna;
		private static var forceClass48: sodovaya;
		private static var forceClass49: tekila;
		private static var forceClass50: tekila_sunrise;
		private static var forceClass51: tomatniy;
		private static var forceClass52: vanila_ice;
		private static var forceClass53: viski;
		private static var forceClass54: vodka;
		private static var forceClass55: vodka_bull;
		private static var forceClass56: vodka_tonic;
		
		private static var forceClass57: apelsinoviy_sok;
		private static var forceClass58: beer;
		private static var forceClass59: blue_kyrasao;
		private static var forceClass60: coffeiniy_liker;
		private static var forceClass61: ice;
		private static var forceClass62: limon_cap;
		private static var forceClass63: mint_cap;
		private static var forceClass64: p_absent;
		private static var forceClass65: p_apelsinoviy_liker;
		private static var forceClass66: p_beileys;
		private static var forceClass67: p_coffe;
		private static var forceClass68: p_energetic;
		private static var forceClass69: p_jin;
		private static var forceClass70: p_konjak;
		private static var forceClass71: p_rom;
		private static var forceClass72: p_sambuka;
		private static var forceClass73: p_sodovaya;
		private static var forceClass74: p_tekila;
		private static var forceClass75: p_viski;
		private static var forceClass76: p_vodka;
		private static var forceClass77: sirop;
		private static var forceClass78: sirop_grenadin;
		private static var forceClass79: slivki;
		private static var forceClass80: tomatniy_sok;
		
		private static var forceClass81: di_bartable1;
		private static var forceClass82: di_bartable2;
		private static var forceClass83: di_lamp1;
		private static var forceClass84: di_lamp2;
		private static var forceClass85: di_lamp3;
		private static var forceClass86: di_picture1;
		private static var forceClass87: di_picture2;
		private static var forceClass88: di_picture3;
		private static var forceClass89: di_shkaf1;
		private static var forceClass90: di_shkaf2;
		private static var forceClass91: di_shkaf3;
		private static var forceClass92: di_stul1;
		private static var forceClass93: di_stul2;
		private static var forceClass94: di_wall1;
		private static var forceClass95: di_wall2;
		private static var forceClass96: di_wall3;
		private static var forceClass97: di_wall4;
		private static var forceClass98: di_wall5;
		
		private static var forceClass99: mm_back;
		private static var forceClass100: mm_ico_addfr;
		private static var forceClass101: mm_ico_barmenu;
		private static var forceClass102: mm_ico_bestbar;
		private static var forceClass103: mm_ico_catalog;
		private static var forceClass104: mm_ico_intshop;
		private static var forceClass105: mm_ico_money;
		private static var forceClass106: mm_ico_news;
		private static var forceClass107: mm_ico_wineshop;
		private static var forceClass108: mm_invitefriend;
		private static var forceClass109: mm_left1;
		private static var forceClass110: mm_leftbegin;
		private static var forceClass111: mm_leftpage;
		private static var forceClass112: mm_lentaback;
		private static var forceClass113: mm_right1;
		private static var forceClass114: mm_rightbegin;
		private static var forceClass115: mm_rightpage;
		
		private static var forceClass116: btn_cancel;
		private static var forceClass117: btn_close;
		private static var forceClass118: btn_invite;
		private static var forceClass119: btn_next;
		private static var forceClass120: btn_ok;
		private static var forceClass121: btn_play;
		private static var forceClass122: btn_serve;
		
		private static var forceClass123: toolbar_back;
		private static var forceClass124: toolbar_barman_change;
		private static var forceClass125: toolbar_cents;
		private static var forceClass126: toolbar_euro;
		private static var forceClass127: toolbar_heart;
		private static var forceClass128: toolbar_lev_back;
		private static var forceClass129: toolbar_lev_blick;
		private static var forceClass130: toolbar_lev_ico;
		private static var forceClass131: toolbar_pencil;
		
		private static var forceClass132: shop_cents;
		private static var forceClass133: shop_euro;
		private static var forceClass134: shop_lev_ico;
		private static var forceClass135: shop_lev_plus;
		private static var forceClass136: shop_license;
		private static var forceClass137: shop_love;
		private static var forceClass138: shop_panel;
		private static var forceClass139: shop_panel_gray;
		private static var forceClass140: shop_portion;
		private static var forceClass141: shop_tips;
		
		/**
		 * Возвращает имидж из дизайна по имени класса
		 */
		public static function getImage($className: String): Bitmap {
			try {
//				var c: Class = client1;
				var c: Class = getDefinitionByName($className) as Class;
				return new Bitmap(new c() as BitmapData);
			}
			catch(e: Error) {
			}
			return null;
		}
		
		public static const QUESTION_A:String = 'question_a.gif';
		
//		public static const BARTABLE_BACK1:String = 'http://www.fcapi.ru/images_bar/bartable_back1.png';
		public static const BARTABLE1:String = 'bartable1.png';
//		public static const CLIENT1:String = 'clients/client1.png';
//		public static const CLIENT2:String = 'clients/client2.png';
//		public static const CLIENT3:String = 'clients/client3.png';
//		public static const CLIENT4:String = 'clients/client4.png';
//		public static const CLIENT5:String = 'clients/client5.png';
//		public static const CLIENT6:String = 'clients/client6.png';
		public static const CLIENT1:String = 'client1';
		public static const CLIENT2:String = 'client2';
		public static const CLIENT3:String = 'client3';
		public static const CLIENT4:String = 'client4';
		public static const CLIENT5:String = 'client5';
		public static const CLIENT6:String = 'client6';
		public static const LAMP1:String = 'lamp1.png';
		public static const PICTURE1:String = 'picture1.png';
		public static const PICTURE2:String = 'picture2.png';
		public static const PICTURE3:String = 'picture3.png';
		public static const SHKAF1:String = 'shkaf1.png';
		public static const STUL1_BACK:String = 'stul1_back.png';
		public static const STUL1_FOREWARD:String = 'stul1_forward.png';
		public static const WALL1:String = 'wall1.png';
		public static const WOMAN_BODY:String = 'barman_woman/woman_body.png';
		public static const WOMAN_BUST1:String = 'barman_woman/woman_bust1.png';
		public static const WOMAN_PANTS1:String = 'barman_woman/woman_pants1.png';
		public static const WOMAN_SKIRT1:String = 'barman_woman/woman_skirt1.png';
		public static const WOMAN_TSHIRT1:String = 'barman_woman/woman_tshirt1.png';
		public static const WALL2:String = 'wall2.png';
		public static const WALL3:String = 'wall3.png';
		public static const WALL4:String = 'interior/wall4.png';
		public static const WALL5:String = 'interior/wall5.png';
		public static const BARTABLE2:String = 'interior/bartable2.png';
		public static const LAMP2:String = 'interior/lamp2.png';
		public static const LAMP3:String = 'interior/lamp3.png';
		public static const SHKAF2:String = 'interior/shkaf2.png';
		public static const SHKAF3:String = 'interior/shkaf3.png';
		public static const STUL2_BACK:String = 'interior/stul2_back.png';
		public static const STUL2_FOREWARD:String = 'interior/stul2_forward.png';
		
//		public static const PROD_VODKA:String = 'prod/vodka.png';
//		public static const PROD_BEER:String = 'prod/beer.png';
//		public static const PROD_ORANGE:String = 'prod/apelsinoviy_sok.png';
//		public static const PROD_SODA:String = 'prod/sodovaya.png';
//		public static const PROD_VISKI:String = 'prod/viski.png';
//		public static const PROD_SIROP:String = 'prod/sirop.png';
//		public static const PROD_ICE:String = 'prod/ice.png';
//		public static const PROD_LIMON:String = 'prod/limon_cap.png';
//		public static const PROD_ABSENT:String = 'prod/absent.png';
//		public static const PROD_ORANGE_LIKER:String = 'prod/apelsinoviy_liker.png';
//		public static const PROD_BEILEYS:String = 'prod/beileys.png';
//		public static const PROD_BLUE_KUROSAO:String = 'prod/blue_kyrasao.png';
//		public static const PROD_COFFEE:String = 'prod/coffe.png';
//		public static const PROD_COFFEE_LIKER:String = 'prod/coffeiniy_liker.png';
//		public static const PROD_ENERGETIC:String = 'prod/energetic.png';
//		public static const PROD_JIN:String = 'prod/jin.png';
//		public static const PROD_MINT_CAP:String = 'prod/mint_cap.png';
//		public static const PROD_ROM:String = 'prod/rom.png';
//		public static const PROD_SAMBUKA:String = 'prod/sambuka.png';
//		public static const PROD_SIROP_GRENADIN:String = 'prod/sirop_grenadin.png';
//		public static const PROD_SLIVKI:String = 'prod/slivki.png';
//		public static const PROD_TEKILA:String = 'prod/tekila.png';
//		public static const PROD_TOMATO:String = 'prod/tomatniy_sok.png';
//		public static const PROD_KONJAK:String = 'prod/konjak.png';
		
		public static const PROD_VODKA:String = 'p_vodka';
		public static const PROD_BEER:String = 'beer';
		public static const PROD_ORANGE:String = 'apelsinoviy_sok';
		public static const PROD_SODA:String = 'p_sodovaya';
		public static const PROD_VISKI:String = 'p_viski';
		public static const PROD_SIROP:String = 'sirop';
		public static const PROD_ICE:String = 'ice';
		public static const PROD_LIMON:String = 'limon_cap';
		public static const PROD_ABSENT:String = 'p_absent';
		public static const PROD_ORANGE_LIKER:String = 'apelsinoviy_liker';
		public static const PROD_BEILEYS:String = 'p_beileys';
		public static const PROD_BLUE_KUROSAO:String = 'blue_kyrasao';
		public static const PROD_COFFEE:String = 'p_coffe';
		public static const PROD_COFFEE_LIKER:String = 'coffeiniy_liker';
		public static const PROD_ENERGETIC:String = 'p_energetic';
		public static const PROD_JIN:String = 'p_jin';
		public static const PROD_MINT_CAP:String = 'mint_cap';
		public static const PROD_ROM:String = 'p_rom';
		public static const PROD_SAMBUKA:String = 'p_sambuka';
		public static const PROD_SIROP_GRENADIN:String = 'sirop_grenadin';
		public static const PROD_SLIVKI:String = 'slivki';
		public static const PROD_TEKILA:String = 'p_tekila';
		public static const PROD_TOMATO:String = 'tomatniy_sok';
		public static const PROD_KONJAK:String = 'p_konjak';
		
//		public static const GOODS_VODKA:String = 'goods/vodka.png';
//		public static const GOODS_BEER:String = 'goods/pivo.png';
//		public static const GOODS_ERSH:String = 'goods/ersh.png';
//		public static const GOODS_ORANGE:String = 'goods/apelsinoviy.png';
//		public static const GOODS_SODA:String = 'goods/sodovaya.png';
//		public static const GOODS_OTVERTKA:String = 'goods/otvertka.png';
//		public static const GOODS_JAMESON_VISKI_SAYER:String = 'goods/jameson_viski_sayer.png';
//		public static const GOODS_MILLIONAIR:String = 'goods/millionair.png';
//		public static const GOODS_VISKI:String = 'goods/viski.png';
//		public static const GOODS_VODKA_TONIC:String = 'goods/vodka-tonic.png';
//		public static const GOODS_GIN:String = 'goods/gin.png';
//		public static const GOODS_SEX_BEACH:String = 'goods/sex_in_the_beach.png';
//		public static const GOODS_GIN_TONIC:String = 'goods/gin_tonic.png';
//		public static const GOODS_PARADIZO:String = 'goods/paradizo.png';
//		public static const GOODS_VANILA_ICE:String = 'goods/vanila_ice.png';
//		public static const GOODS_COFFEE:String = 'goods/coffe.png';
//		public static const GOODS_ORANGE_LIKER:String = 'goods/apelsinoviy_liker.png';
//		public static const GOODS_IRISH_COFFEE:String = 'goods/irish_coffe.png';
//		public static const GOODS_WHITE_LEDY:String = 'goods/belaya_ledi.png';
//		public static const GOODS_TEKILA:String = 'goods/tekila.png';
//		public static const GOODS_TEKILA_SUNRISE:String = 'goods/tekila_sunrise.png';
//		public static const GOODS_MARGARITA:String = 'goods/margarita.png';
//		public static const GOODS_GRANAT_MIX:String = 'goods/granatovyi_mix.png';
//		public static const GOODS_ROM:String = 'goods/rom.png';
//		public static const GOODS_MAI_TAI:String = 'goods/mai-tai.png';
//		public static const GOODS_MOHITO:String = 'goods/mohito.png';
//		public static const GOODS_GAVANA:String = 'goods/sladkaya_havanna.png';
//		public static const GOODS_TOMATO:String = 'goods/tomatniy.png';
//		public static const GOODS_COFFEE_LIKER:String = 'goods/coffe_liker.png';
//		public static const GOODS_ROCKET:String = 'goods/roketnoe_toplivo.png';
//		public static const GOODS_BLOOD_MARY:String = 'goods/blood_mary.png';
//		public static const GOODS_ENERGETIC:String = 'goods/energetic.png';
//		public static const GOODS_BLUE:String = 'goods/blue_curasao.png';
//		public static const GOODS_MARGARITA_BLUE:String = 'goods/blue_margarita.png';
//		public static const GOODS_VODKA_BULL:String = 'goods/vodka_bull.png';
//		public static const GOODS_SAMBUKA:String = 'goods/sambuka.png';
//		public static const GOODS_BLACK_RUS:String = 'goods/black_russian.png';
//		public static const GOODS_BLUE_LAGUNA:String = 'goods/blue_lagoon.png';
//		public static const GOODS_BALEIYS:String = 'goods/beileys.png';
//		public static const GOODS_B52:String = 'goods/b-52.png';
//		public static const GOODS_POSLE6:String = 'goods/posle_shesti.png';
//		public static const GOODS_KONJAK:String = 'goods/konjak.png';
//		public static const GOODS_SIDE_CAR:String = 'goods/side_car.png';
//		public static const GOODS_ABK:String = 'goods/ABK.png';
//		public static const GOODS_FRENCH_MOHITO:String = 'goods/french_mohito.png';
//		public static const GOODS_ABSENT:String = 'goods/absent.png';
//		public static const GOODS_MAGNUM44:String = 'goods/magnum44.png';
//		public static const GOODS_ABSENT_BULL:String = 'goods/absent_bull.png';
//		public static const GOODS_OBLAKA:String = 'goods/Oblaka.png';
//		
		
		public static const GOODS_VODKA:String = 'vodka';
		public static const GOODS_BEER:String = 'pivo';
		public static const GOODS_ERSH:String = 'ersh';
		public static const GOODS_ORANGE:String = 'apelsinoviy';
		public static const GOODS_SODA:String = 'sodovaya';
		public static const GOODS_OTVERTKA:String = 'otvertka';
		public static const GOODS_JAMESON_VISKI_SAYER:String = 'jameson_viski_sayer';
		public static const GOODS_MILLIONAIR:String = 'millionair';
		public static const GOODS_VISKI:String = 'viski';
		public static const GOODS_VODKA_TONIC:String = 'vodka-tonic';
		public static const GOODS_GIN:String = 'gin';
		public static const GOODS_SEX_BEACH:String = 'sex_in_the_beach';
		public static const GOODS_GIN_TONIC:String = 'gin_tonic';
		public static const GOODS_PARADIZO:String = 'paradizo';
		public static const GOODS_VANILA_ICE:String = 'vanila_ice';
		public static const GOODS_COFFEE:String = 'coffe';
		public static const GOODS_ORANGE_LIKER:String = 'apelsinoviy_liker';
		public static const GOODS_IRISH_COFFEE:String = 'irish_coffe';
		public static const GOODS_WHITE_LEDY:String = 'belaya_ledi';
		public static const GOODS_TEKILA:String = 'tekila';
		public static const GOODS_TEKILA_SUNRISE:String = 'tekila_sunrise';
		public static const GOODS_MARGARITA:String = 'margarita';
		public static const GOODS_GRANAT_MIX:String = 'granatovyi_mix';
		public static const GOODS_ROM:String = 'rom';
		public static const GOODS_MAI_TAI:String = 'mai-tai';
		public static const GOODS_MOHITO:String = 'mohito';
		public static const GOODS_GAVANA:String = 'sladkaya_havanna';
		public static const GOODS_TOMATO:String = 'tomatniy';
		public static const GOODS_COFFEE_LIKER:String = 'coffe_liker';
		public static const GOODS_ROCKET:String = 'roketnoe_toplivo';
		public static const GOODS_BLOOD_MARY:String = 'blood_mary';
		public static const GOODS_ENERGETIC:String = 'energetic';
		public static const GOODS_BLUE:String = 'blue_curasao';
		public static const GOODS_MARGARITA_BLUE:String = 'blue_margarita';
		public static const GOODS_VODKA_BULL:String = 'vodka_bull';
		public static const GOODS_SAMBUKA:String = 'sambuka';
		public static const GOODS_BLACK_RUS:String = 'black_russian';
		public static const GOODS_BLUE_LAGUNA:String = 'blue_lagoon';
		public static const GOODS_BALEIYS:String = 'beileys';
		public static const GOODS_B52:String = 'b-52';
		public static const GOODS_POSLE6:String = 'posle_shesti';
		public static const GOODS_KONJAK:String = 'konjak';
		public static const GOODS_SIDE_CAR:String = 'side_car';
		public static const GOODS_ABK:String = 'ABK';
		public static const GOODS_FRENCH_MOHITO:String = 'french_mohito';
		public static const GOODS_ABSENT:String = 'absent';
		public static const GOODS_MAGNUM44:String = 'magnum44';
		public static const GOODS_ABSENT_BULL:String = 'absent_bull';
		public static const GOODS_OBLAKA:String = 'Oblaka';
		
		
		public static const TOOLBAR_BACK:String = 'toolbar_back';
		public static const TOOLBAR_BARMAN_CHANGE:String = 'toolbar_barman_change';
		public static const TOOLBAR_CENTS:String = 'toolbar_cents';
		public static const TOOLBAR_EURO:String = 'toolbar_euro';
		public static const TOOLBAR_HEART:String = 'toolbar_heart';
		public static const TOOLBAR_LEV_BACK:String = 'toolbar_lev_back';
		public static const TOOLBAR_LEV_BLICK:String = 'toolbar_lev_blick';
		public static const TOOLBAR_LEV_ICO:String = 'toolbar_lev_ico';
		public static const TOOLBAR_PENCIL:String = 'toolbar_pencil';
		
//		public static const MM_BACK:String = 'mm/mm_back.png';
//		public static const MM_ICO_ADDFR:String = 'mm/mm_ico_addfr.png';
//		public static const MM_ICO_BARMENU:String = 'mm/mm_ico_barmenu.png';
//		public static const MM_ICO_BESTBAR:String = 'mm/mm_ico_bestbar.png';
//		public static const MM_ICO_CATALOG:String = 'mm/mm_ico_catalog.png';
//		public static const MM_ICO_INTSHOP:String = 'mm/mm_ico_intshop.png';
//		public static const MM_ICO_MONEY:String = 'mm/mm_ico_money.png';
//		public static const MM_ICO_NEWS:String = 'mm/mm_ico_news.png';
//		public static const MM_ICO_WINESHOP:String = 'mm/mm_ico_wineshop.png';
//		public static const MM_INVITEFRIEND:String = 'mm/mm_invitefriend.png';
//		public static const MM_LEFT1:String = 'mm/mm_left1.png';
////		public static const MM_LEFTBEGIN:String = 'mm/mm_leftbegin.png';
////		public static const MM_LEFTPAGE:String = 'mm/mm_leftpage.png';
//		public static const MM_LENTABACK:String = 'mm/mm_lentaback.png';
//		public static const MM_RIGHT1:String = 'mm/mm_right1.png';
////		public static const MM_RIGHTBEGIN:String = 'mm/mm_rightbegin.png';
////		public static const MM_RIGHTPAGE:String = 'mm/mm_rightpage.png';
		public static const MM_BACKGROUND:String = 'mm_back';
		public static const MM_ICO_ADDFR:String = 'mm_ico_addfr';
		public static const MM_ICO_BARMENU:String = 'mm_ico_barmenu';
		public static const MM_ICO_BESTBAR:String = 'mm_ico_bestbar';
		public static const MM_ICO_CATALOG:String = 'mm_ico_catalog';
		public static const MM_ICO_INTSHOP:String = 'mm_ico_intshop';
		public static const MM_ICO_MONEY:String = 'mm_ico_money';
		public static const MM_ICO_NEWS:String = 'mm_ico_news';
		public static const MM_ICO_WINESHOP:String = 'mm_ico_wineshop';
		public static const MM_INVITEFRIEND:String = 'mm_invitefriend';
		public static const MM_LEFT1:String = 'mm_left1';
		public static const MM_LENTABACK:String = 'mm_lentaback';
		public static const MM_RIGHT1:String = 'mm_right1';
		
		public static const SHOP_LICENSE:String = 'shop_license';
		public static const SHOP_PANEL:String = 'shop_panel';
		public static const SHOP_PANEL_GRAY:String = 'shop_panel_gray';
		public static const SHOP_PORTION:String = 'shop_portion';
		public static const SHOP_LEV_ICO:String = 'shop_lev_ico';
		public static const SHOP_CENTS:String = 'shop_cents';
		public static const SHOP_EURO:String = 'shop_euro';
		public static const SHOP_LOVE:String = 'shop_love';
		public static const SHOP_TIPS:String = 'shop_tips';
		public static const SHOP_LEV_PLUS:String = 'shop_lev_plus';

		public static const BTN_NEXT:String = 'btn_next';
		public static const BTN_PLAY:String = 'btn_play';
		public static const BTN_CLOSE:String = 'btn_close';
		public static const BTN_SERVE:String = 'btn_serve';
		public static const BTN_INVITE:String = 'btn_invite';
		public static const BTN_OK:String = 'btn_ok';
		public static const BTN_CANCEL:String = 'btn_cancel';
		
		public static const TIPS:String = 'tips.png';
		public static const WINDOW:String = 'window.png';
		public static const EXCH_PANEL:String = 'exch_panel.png';
		public static const HINT_UP:String = 'hint_up.png';
		public static const HINT_UP1:String = 'hint_up1.png';
		public static const HINT_DOWN:String = 'hint_down.png';
		public static const TUTORIAL_ARROW:String = 'tutorial_arrow.png';
		public static const ALCO_ICON:String = 'alco_icon.png';
		public static const LEFT_ARROW:String = 'left_arrow.png';
		public static const RIGHT_ARROW:String = 'right_arrow.png';
		
//		public static const DECICO_STUL1:String = 'decor_ico/stul1.png';
//		public static const DECICO_BARTABLE1:String = 'decor_ico/bartable1.png';
//		public static const DECICO_LAMP1:String = 'decor_ico/lamp1.png';
//		public static const DECICO_PICTURE1:String = 'decor_ico/picture1.png';
//		public static const DECICO_PICTURE2:String = 'decor_ico/picture2.png';
//		public static const DECICO_PICTURE3:String = 'decor_ico/picture3.png';
//		public static const DECICO_SHKAF1:String = 'decor_ico/shkaf1.png';
//		public static const DECICO_WALL1:String = 'decor_ico/wall1.png';
//		public static const DECICO_WALL2:String = 'decor_ico/wall2.png';
//		public static const DECICO_WALL3:String = 'decor_ico/wall3.png';
//		public static const DECICO_WALL4:String = 'decor_ico/wall4.png';
//		public static const DECICO_WALL5:String = 'decor_ico/wall5.png';
//		public static const DECICO_SHKAF2:String = 'decor_ico/shkaf2.png';
//		public static const DECICO_SHKAF3:String = 'decor_ico/shkaf3.png';
//		public static const DECICO_BARTABLE2:String = 'decor_ico/bartable2.png';
//		public static const DECICO_LAMP2:String = 'decor_ico/lamp2.png';
//		public static const DECICO_LAMP3:String = 'decor_ico/lamp3.png';
//		public static const DECICO_STUL2:String = 'decor_ico/stul2.png';
		public static const DECICO_STUL1:String = 'di_stul1';
		public static const DECICO_BARTABLE1:String = 'di_bartable1';
		public static const DECICO_LAMP1:String = 'di_lamp1';
		public static const DECICO_PICTURE1:String = 'di_picture1';
		public static const DECICO_PICTURE2:String = 'di_picture2';
		public static const DECICO_PICTURE3:String = 'di_picture3';
		public static const DECICO_SHKAF1:String = 'di_shkaf1';
		public static const DECICO_WALL1:String = 'di_wall1';
		public static const DECICO_WALL2:String = 'di_wall2';
		public static const DECICO_WALL3:String = 'di_wall3';
		public static const DECICO_WALL4:String = 'di_wall4';
		public static const DECICO_WALL5:String = 'di_wall5';
		public static const DECICO_SHKAF2:String = 'di_shkaf2';
		public static const DECICO_SHKAF3:String = 'di_shkaf3';
		public static const DECICO_BARTABLE2:String = 'di_bartable2';
		public static const DECICO_LAMP2:String = 'di_lamp2';
		public static const DECICO_LAMP3:String = 'di_lamp3';
		public static const DECICO_STUL2:String = 'di_stul2';
		
		public static const LOAD_BACK:String = 'load_back.png';
		public static const LOAD_ACTIVE:String = 'load_active.png';
		public static const LOAD_MASK:String = 'load_mask.png';
		public static const SPLASH:String = 'splash.jpg';
//		public static const PRELOADER_ANIM1:String = 'http://www.fcapi.ru/images/preloader/01.png';
//		public static const PRELOADER_ANIM2:String = 'http://www.fcapi.ru/images/preloader/02.png';
//		public static const PRELOADER_ANIM3:String = 'http://www.fcapi.ru/images/preloader/03.png';
//		public static const PRELOADER_ANIM4:String = 'http://www.fcapi.ru/images/preloader/04.png';
//		public static const PRELOADER_ANIM5:String = 'http://www.fcapi.ru/images/preloader/05.png';
//		public static const PRELOADER_ANIM6:String = 'http://www.fcapi.ru/images/preloader/06.png';
//		public static const PRELOADER_ANIM7:String = 'http://www.fcapi.ru/images/preloader/07.png';
//		public static const PRELOADER_ANIM8:String = 'http://www.fcapi.ru/images/preloader/08.png';

		
		public static const PRE_IMAGES: Array = new Array(
			LOAD_BACK,
			LOAD_ACTIVE,
			LOAD_MASK,
			SPLASH
		);
		
		public static const IMAGES:Array = new Array(
			QUESTION_A,
//			BARTABLE_BACK1,
			BARTABLE1,
			LAMP1,
			PICTURE1,
			PICTURE2,
			PICTURE3,
			SHKAF1,
			STUL1_BACK,
			STUL1_FOREWARD,
			WALL1,
			WOMAN_BODY,
			WOMAN_BUST1,
			WOMAN_PANTS1,
			WOMAN_SKIRT1,
			WOMAN_TSHIRT1,
			WALL2,
			WALL3,
			WALL4,
			WALL5,
			BARTABLE2,
			LAMP2,
			LAMP3,
			SHKAF2,
			SHKAF3,
			STUL2_BACK,
			STUL2_FOREWARD,
			
			TIPS,
			WINDOW,
			EXCH_PANEL,
			HINT_UP,
			HINT_UP1,
			HINT_DOWN,
			TUTORIAL_ARROW,
			ALCO_ICON,
			RIGHT_ARROW,
			LEFT_ARROW
		);
	}
}