
enum AppTheme{
  lightRed, darkBlue, system, dark, light;
  static AppTheme getTheme(String? theme){
    switch(theme){
      case 'lightRed':
        return AppTheme.lightRed;
      case 'darkBlue':
        return AppTheme.darkBlue;
      case 'dark':
        return AppTheme.dark;
      case 'light':
        return AppTheme.light;
      default:
        return AppTheme.system;
    }
  }

  String getThemeVal(){
    switch(this){
      case AppTheme.lightRed:
        return 'lightRed';
      case AppTheme.darkBlue:
        return 'darkBlue';
      case AppTheme.light:
        return 'light';
      case AppTheme.dark:
        return 'dark';
      default:
        return 'system';
    }
  }

}

enum Status { COMPLETED, WAITING, ERROR }