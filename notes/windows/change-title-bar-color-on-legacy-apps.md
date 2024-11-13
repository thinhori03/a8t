
# change title bar color on legacy apps.

### change `registry`
  1. open `registry editor`
  2 goto `HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\DWM`
  3. add `AccentColorInactive`
  - type `DWORD`
  - value is hex value of RGB 
    e.g `000000` for black.
