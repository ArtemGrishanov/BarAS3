package com.flashmedia.socialnet
{
	public class SocialNetUser
	{
		public static const SEX_UNKNOWN: uint = 0;
		public static const SEX_FEMALE: uint = 1;
		public static const SEX_MALE: uint = 2;
		
		public var id: String;
		public var nickname: String;
		public var firstName: String;
		public var lastName: String;
		public var sex: uint;
		public var birthday: String;
		public var photoUrl: String;
		public var photoMediumUrl: String;
		public var photoBigUrl: String;
		
		public function SocialNetUser(_id: String, _nickname: String = null, _firstName: String = null, _lastName: String = null, _sex: uint = 0, _birthday: String = null)
		{
			id = _id;
			nickname = _nickname;
			firstName = _firstName;
			lastName = _lastName;
			sex = _sex;
			birthday = _birthday;
		}
		
		public function get fullName(): String {
			var n: String = '';
			n += (firstName) ? (firstName + ' '): '';
			n += (nickname) ?(nickname + ' '): '';
			n += (lastName) ? (lastName + ' '): '';
			return n;
		}

	}
}