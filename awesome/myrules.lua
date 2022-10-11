local awful = require("awful")
local beautiful = require("beautiful")

myrules = {

  { rule = {},
    properties = {

      keys = clientkeys,
      buttons = clientbuttons

    }
  },

  { rule_any = { type = { "normal", "dialog" } },
    properties = { titlebars_enabled = true , floating =true }
  },

  { rule = { class = "Google-chrome" }, properties = { screen = 2, tag = "www", floating = false } },
  { rule = { class = "Code" }, properties = { screen = 1, tag = "dev", floating = false } },
  { rule = { class = "kitty" }, properties = { screen = 1, tag = "term", floating = false } },



}

return myrules
