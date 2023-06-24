# PeepingTom
A quick and dirty prototype that uses Mac Accessibility API to make an app similar to Accessibility Inspector.

A showcase of macOS accessibility API capabilities.

#TODO
- Fix sandboxing issue.
- Support viewing and executing actions
- Implement path control
- Improve UI
    - double click
     - more interesting layout
     - scroll by keybioard bug
- improve value display, sometimes it's to'o technical
- show more sane labels for the elements so it is obvious what this element is before clicking on it.
- support sorting
- put some indicator to denote "openable" elements, or make it bold, etc. Would be easy to know what to open.
- prohibit opening elements other than AXUIElement and array of those (TBD: do we need to support some other elements?)
- column view would probably be better here.
- consider having "details" view to show element details.
- consider removing "AX" prefixes to make UI cleaner
- consider changing "CFArray", "CFBoolean", "AXUIElement" to a more obvious name in the UI. 

![ScreenShot](Screenshots/screenshot1.png)

![ScreenShot](Screenshots/screenshot2.png)
