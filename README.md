# Best In Slot

A WOW (Classic BBC) addon shows the BIS info on the gear tooltip

This project modified from `ExoLink` and `ExoLink_BIS (@俏俏制作)`

If you want to customize BIS info, please go to the `Data/{class_you_want_to_edit}.lua`, and modify the Item regists info.

Example
```lua
local bis = BIS:RegisterClass("Druid", "熊德")  -- Class Info

...

BIS:BISItem(bis, "29098", "Head", "", "P1")  -- Item info
```
