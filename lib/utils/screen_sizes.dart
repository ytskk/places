enum ScreenSizes {
  Small,
  Medium,
  Large,
}

int _screenSizeHeightSmall = 600;
int _screenSizeHeightMedium = 1000;

int _screenSizeWidthSmall = 340;
int _screenSizeWidthMedium = 400;

/// 23
ScreenSizes resolveScreenHeightSize(double height) {
  // some
  if (height < _screenSizeHeightSmall) {
    return ScreenSizes.Small;
  } else if (height < _screenSizeHeightMedium) {
    return ScreenSizes.Medium;
  } else {
    return ScreenSizes.Large;
  }
}

ScreenSizes resolveScreenWidthSize(double width) {
  print('screensize: $width');
  if (width < _screenSizeWidthSmall) {
    return ScreenSizes.Small;
  } else if (width < _screenSizeWidthMedium) {
    return ScreenSizes.Medium;
  } else {
    return ScreenSizes.Large;
  }
}
