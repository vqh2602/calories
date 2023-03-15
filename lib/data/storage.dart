class Storages{
  /* biến local lưu data storage */
  // chứa thông tin đối tượng user sau khi đăng nhập
  static const String dataUser = 'data_user';
// chứa tài khoản
  static const String dataEmail = 'data_email';
  static const String dataPassWord = 'data_password';
// chứa thời gian đăng nhập
  static const String dataLoginTime = 'data_login_time';
// đăng nhập sinh trắc học
  static const String dataBiometric = 'data_biometric';
// tự động phát video
  static const String dataPlayVideo = 'data_auto_play_video';
  // url hỉnh ảnh ng dùng
  static const String dataUrlAvatarUser = 'data_avatar_user';
}

class Config{
  // thời gian buộc đăng xuất (giờ)
  static const int dataLoginTimeOut = 168;
}
