enum ScreenSizes {
  Small,
  Medium,
  Large,
}

int _screenSizeSmall = 600;
int _screenSizeMedium = 1000;

ScreenSizes resolveScreenSize(double height) {
  if (height < _screenSizeSmall) {
    return ScreenSizes.Small;
  } else if (height < _screenSizeMedium) {
    return ScreenSizes.Medium;
  } else {
    return ScreenSizes.Large;
  }
}
