# Best In Slot

A WOW addon shows the BIS info on the gear tooltip

This project modified from `ExoLink` and `ExoLink_BIS (@俏俏制作)`

If you want to custom BIS info, please edit the `Data/{class}.lua`, and modify the Item regists info.

```lua
local bis = BIS:RegisterClass("Druid", "熊德")  -- Class Info

...

BIS:BISItem(bis, "29098", "Head", "", "P1")  -- Item info
```
