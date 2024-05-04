# howler

## 0.3.0

- Added `playSound`, enabling sounds to be played without UI element (#19)
- Added `changeHowlSpeed` to allow server-side control of the rate of the track
- Added `deleteTrack` to remove a track within a given `howler` object (#17)
- Fixed issue where `renderHowler` wouldn't play a sound if no `howler` object existed in UI (#20)

## 0.2.1

- Fixed issue where adding tracks with names failed (#12)
- Included server side toggle play/pause (#13 - thanks @antoine-sachet) 

## 0.2.0

- Converted from single JS script to `{htmlwidgets}` widget
- Track correctly shown when only 1 track (#11)
- Empty player can be generated (#7)

## 0.1.0

- Initial creation of package
