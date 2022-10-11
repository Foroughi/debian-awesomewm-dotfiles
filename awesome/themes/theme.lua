--  ██████╗ ███╗   ██╗███████╗    ██████╗  █████╗ ██████╗ ██╗  ██╗
-- ██╔═══██╗████╗  ██║██╔════╝    ██╔══██╗██╔══██╗██╔══██╗██║ ██╔╝
-- ██║   ██║██╔██╗ ██║█████╗█████╗██║  ██║███████║██████╔╝█████╔╝
-- ██║   ██║██║╚██╗██║██╔══╝╚════╝██║  ██║██╔══██║██╔══██╗██╔═██╗
-- ╚██████╔╝██║ ╚████║███████╗    ██████╔╝██║  ██║██║  ██║██║  ██╗
--  ╚═════╝ ╚═╝  ╚═══╝╚══════╝    ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝  ╚═╝

local gears = require("gears")
local lain  = require("lain")
local awful = require("awful")
local wibox = require("wibox")
local dpi   = require("beautiful.xresources").apply_dpi

local os = os
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

local wallpaper_dir = "/mnt/extras/Wallpapers"

local theme     = {}
theme.wallpaper = wallpaper_dir .. "/eos_astronaut.png"

theme.font      = "Comic Sans MS bold 7"
theme.iconsize  = 19
theme.siconfont = "Font Awesome 6 Free-Solid-900 14"
theme.biconfont = "Font Awesome 6 Brands-Regular-400 7"
--theme.iconfont               = "Font Awesome 6 Free-Regular-400 19
--theme.iconfont               = "Font Awesome 6 Free-Solid-900 19"

--theme.brand_iconfont               = "Font Awesome  Free-Brand-900 9"
theme.notification_font      = "Comic Sans MS bold 10"
theme.notification_max_width = 800
theme.taglist_font           = "Iosevka Comfy 6"

theme.white       = "#ffffff"
theme.dark        = "#000000"
theme.darker      = "#1E222A"
theme.transparent = "#E6000000"

theme.black         = theme.dark
theme.grey          = "#5c6370"
theme.red           = "#efa6a2"
theme.red_bright    = "#D04232"
theme.orange        = "#d19a66"
theme.green         = "#98c379"
theme.green_bright  = "#B8BB26"
theme.yellow        = "#c8c874"
theme.yellow_bright = "#FFC12F"
theme.blue          = "#61afef"
theme.blue_bright   = "#83A598"
theme.purple        = "#c678dd"
theme.purple_bright = "#D3869B"

theme.accent = theme.green

theme.fg_normal     = "#D7D7D7"
theme.fg_focus      = theme.accent
theme.bg_normal     = theme.dark
theme.bg_focus      = theme.dark
theme.fg_urgent     = "#CC9393"
theme.bg_urgent     = "#2A1F1E"
theme.border_width  = dpi(2)
theme.border_normal = theme.darker
theme.border_focus  = theme.blue

theme.bg1 = "#3d4059"
theme.bg2 = "#313449"
theme.bg3 = "#2c2e3e"
-- theme.bg4                                       = "#20202a"
theme.bg4 = theme.dark

theme.taglist_fg_focus    = theme.blue
theme.taglist_bg_focus    = theme.bg3
theme.taglist_fg_occupied = theme.purple
theme.taglist_fg_empty    = theme.grey
theme.taglist_fg_urgent   = theme.red

theme.tasklist_fg_focus        = "#F6784F"
theme.tasklist_bg_focus        = "#060606"
theme.bg_systray               = theme.dark
theme.menu_height              = dpi(14)
theme.menu_width               = dpi(130)
theme.tasklist_plain_task_name = true
theme.tasklist_disable_icon    = true
theme.useless_gap              = dpi(2)


awful.util.tagnames = {
    { "dev", "www", "term", "misc" },
    { "www", "misc" }
}

awful.util.tagicons = {
    {
        {
            text = "dev",
            icon = "\u{f120}",
            font = theme.siconfont
        },
        {
            text = "www",
            icon = "\u{f121}",
            font = theme.siconfont
        },
        {
            text = "term",
            icon = "\u{f268}",
            font = theme.biconfont
        },
        {
            text = "misc",
            icon = "\u{f085}",
            font = theme.siconfont
        }
    },
    {
        {
            text = "www",
            icon = "\u{f013}",
            font = theme.siconfont
        },
        {
            text = "misc",
            icon = "\u{f013}",
            font = theme.siconfont
        }
    }

}

local markup     = lain.util.markup
local separators = lain.util.separators
local gray       = "#9E9C9A"


local function make_fa_icon(code, font)
    if font == nil then
        font = theme.siconfont
    end

    return markup.font(font, code)
end

local function underligingDrawer(cr, width, height, degree)
    cr:move_to(0, 0)
    cr:line_to(500, 0)
    cr:close_path()
end

theme.time = wibox.widget {
    awful.widget.watch(
        "date +'%I:%M '", 10,
        function(widget, stdout)

            widget:set_markup(markup(theme.purple_bright, make_fa_icon('\u{f017}', theme.biconfont) ..
                ' ' .. markup.font(theme.font, stdout)))

        end
    ),
    {
        shape         = underligingDrawer,
        border_width  = 3,
        border_color  = theme.purple_bright,
        forced_height = 3,
        forced_width  = 20,
        widget        = wibox.widget.separator,
    },
    layout = wibox.layout.fixed.vertical
}



theme.date = wibox.widget {
    awful.widget.watch(
        "date +'%d %b'", 10,
        function(widget, stdout)

            widget:set_markup(markup(theme.green, make_fa_icon('\u{f133}', theme.biconfont) ..
                ' ' .. markup.font(theme.font, stdout)))

        end
    ),
    {
        shape         = underligingDrawer,
        border_width  = 3,
        border_color  = theme.green,
        forced_height = 3,
        forced_width  = 20,
        widget        = wibox.widget.separator,
    },
    layout = wibox.layout.fixed.vertical

}

theme.volumnWidge = wibox.widget {
    {
        lain.widget.alsa({
            --togglechannel = "IEC958,3",
            settings = function()

                local header = '\u{f028}'
                if volume_now.status == 'on' then

                    if volume_now.level > 60 then
                        header = '\u{f028}'
                    elseif volume_now.level > 30 then
                        header = '\u{f027}'
                    else
                        header = '\u{f026}'
                    end

                else
                    header = '\u{f026}'
                end

                widget:set_markup(markup(theme.blue, make_fa_icon(header, theme.biconfont) .. ' '))
            end
        }).widget,
        lain.widget.alsa({
            --togglechannel = "IEC958,3",
            settings = function()

                local header = '\u{f028}'
                local vlevel = volume_now.level .. " "

                widget:set_markup(markup.font(theme.font, markup(theme.blue, vlevel)))
            end
        }).widget,
        forced_height = 21,
        layout = wibox.layout.fixed.horizontal
    },
    {
        shape         = underligingDrawer,
        border_width  = 3,
        border_color  = theme.blue,
        forced_height = 3,
        forced_width  = 20,
        widget        = wibox.widget.separator,
    },
    layout = wibox.layout.fixed.vertical
}

theme.cpu = wibox.widget {
    {

        lain.widget.cpu {
            settings = function()
                widget:set_markup(markup(theme.yellow_bright, make_fa_icon('\u{f2db}', theme.biconfont) .. ' '));
            end
        }.widget,



        lain.widget.cpu {
            settings = function()
                widget:set_markup(markup(theme.yellow_bright, markup.font(theme.font, cpu_now.usage .. '%')));
            end
        }.widget,
        forced_height = 21,
        layout = wibox.layout.fixed.horizontal
    },
    {
        shape         = underligingDrawer,
        border_width  = 3,
        border_color  = theme.yellow_bright,
        forced_height = 3,
        forced_width  = 20,
        widget        = wibox.widget.separator,
    },
    layout = wibox.layout.fixed.vertical

}

theme.mem = wibox.widget {
    {

        lain.widget.mem {
            settings = function()
                widget:set_markup(markup(theme.purple, make_fa_icon('\u{f1c0}', theme.biconfont) .. ' '));
            end
        }.widget,



        lain.widget.mem {
            settings = function()
                widget:set_markup(markup(theme.purple, markup.font(theme.font, mem_now.perc .. '%')));
            end
        }.widget,
        forced_height = 21,
        layout = wibox.layout.fixed.horizontal
    },
    {
        shape         = underligingDrawer,
        border_width  = 3,
        border_color  = theme.purple,
        forced_height = 3,
        forced_width  = 20,
        widget        = wibox.widget.separator,
    },
    layout = wibox.layout.fixed.vertical

}

theme.lan = wibox.widget {
    {

        lain.widget.net {
            notify = "on",
            wifi_state = "on",
            eth_state = "on",
            settings = function()

                local icon = "No connection";

                local lan = net_now.devices.enp2s0
                

                if lan and lan.state == 'up' then

                    icon = "\u{f6ff}";
                    widget:set_markup(markup(theme.fg_normal, make_fa_icon(icon, theme.siconfont)));

              

                else
                    widget:set_markup(markup(theme.fg_normal, icon));
                end


            end
        }.widget,
        forced_height = 21,
        layout = wibox.layout.fixed.horizontal
    },
    {
        shape         = underligingDrawer,
        border_width  = 3,
        border_color  = theme.fg_normal,
        forced_height = 3,
        forced_width  = 10,
        widget        = wibox.widget.separator,
    },
    layout = wibox.layout.fixed.vertical

}


theme.wan = wibox.widget {
    {

        lain.widget.net {
            notify = "on",
            wifi_state = "on",
            eth_state = "on",
            settings = function()

                local icon = "No connection";                
                local wan = net_now.devices.wlp3s0

                if wan and wan.state == 'up' then

                    icon = "\u{f1eb}";
                    widget:set_markup(markup(theme.fg_normal, make_fa_icon(icon, theme.biconfont)));

                else
                    widget:set_markup(markup(theme.fg_normal, icon));
                end


            end
        }.widget,
        forced_height = 21,
        layout = wibox.layout.fixed.horizontal
    },
    {
        shape         = underligingDrawer,
        border_width  = 3,
        border_color  = theme.fg_normal,
        forced_height = 3,
        forced_width  = 10,
        widget        = wibox.widget.separator,
    },
    layout = wibox.layout.fixed.vertical

}

-- Separators
local seperator = wibox.widget.textbox('<span font="Iosevka Comfy 3">  </span>')

function right_tri(cr, width, height, degree)
    cr:move_to(18, 0)
    cr:line_to(0, 18)
    cr:line_to(18, 18)
    cr:close_path()
end

function left_tri(cr, width, height, degree)
    cr:move_to(0, 0)
    cr:line_to(0, 18)
    cr:line_to(18, 18)
    cr:close_path()
end

local function mysep(shape)
    return wibox.widget {
        shape        = shape,
        color        = color,
        border_width = 0,
        forced_width = 18,
        widget       = wibox.widget.separator,
    }
end

local barheight = dpi(18)
local barcolor  = gears.color({
    type  = "linear",
    from  = { barheight, 0 },
    to    = { barheight, barheight },
    stops = { { 0, theme.dark }, { 1, theme.dark }, { 1, theme.dark } }
})

theme.titlebar_bg = barcolor

theme.titlebar_bg_focus = gears.color({
    type  = "linear",
    from  = { barheight, 0 },
    to    = { barheight, barheight },
    stops = { { 0, theme.bg_normal }, { 0.5, theme.border_normal }, { 1, "#492417" } }
})

local taglist_buttons = gears.table.join(
-- awful.button({}, 1, function(t) t:view_only() end),
-- awful.button({ modkey }, 1, function(t)
--     if client.focus then
--         client.focus:move_to_tag(t)
--     end
-- end),
-- awful.button({}, 3, awful.tag.viewtoggle),
-- awful.button({ modkey }, 3, function(t)
--     if client.focus then
--         client.focus:toggle_tag(t)
--     end
-- end),
-- awful.button({}, 4, function(t) awful.tag.viewnext(t.screen) end),
--awful.button({ modkey }, 1, function(t) t:view_only() end),
--awful.button({ modkey , "Shift" }, 1, function(t) client.focus:move_to_tag(t) end)
)

-- local function systemTrayWidgesLayout(arg)

--     local l = wibox.layout {
--         layout  = wibox.layout.manual
--     }

--     l:add(arg);
--     return l

-- end

theme.cpu:buttons(gears.table.join(
    theme.cpu:buttons(),
    awful.button({}, 1, nil, function()
        awful.spawn("kitty htop")
    end)
))

theme.volumnWidge:buttons(gears.table.join(
    theme.volumnWidge:buttons(),
    awful.button({}, 1, nil, function()
        awful.spawn("kitty alsamixer")
    end)
))

local new_shape = function(cr, width, height)

    gears.shape.transform(gears.shape.infobubble):translate(0, 20):rotate_at(35, 35, math.pi)(cr, width, height)
end

function theme.at_screen_connect(s)
    -- Quake application
    --s.quake = lain.util.quake({ app = awful.util.terminal })

    -- If wallpaper is a function, call it with the screen
    -- local wallpaper = theme.wallpaper
    -- if type(wallpaper) == "function" then
    --     wallpaper = wallpaper(s)
    -- end
    -- gears.wallpaper.maximized(wallpaper, s, true)

    if s.index == 1 then
        awful.tag(awful.util.tagnames[s.index], s, awful.layout.layouts[1])
    else
        awful.tag(awful.util.tagnames[s.index], s, awful.layout.layouts[2])
    end

    s.mypromptbox = awful.widget.prompt()

    s.mytaglist = awful.widget.taglist {
        screen          = s,
        filter          = awful.widget.taglist.filter.all,
        layout          = {
            spacing = 0,
            layout  = wibox.layout.fixed.horizontal
        },
        widget_template = {
            {
                {
                    {
                        id     = 'index',
                        widget = wibox.widget.textbox,
                    },
                    left = 5,
                    right = 5,
                    widget = wibox.container.margin,
                },

                {
                    id            = 'border',
                    shape         = underligingDrawer,
                    border_width  = 3,
                    border_color  = theme.blue,
                    forced_height = 3,
                    forced_width  = 20,
                    widget        = wibox.widget.separator,
                },
                layout = wibox.layout.fixed.vertical
            },
            widget = wibox.container.background,
            shape  = gears.shape.rounded_rect,


            create_callback = function(self, tag, index, tags)

                self:get_children_by_id('border')[1].visible = true;
                if index == s.selected_tag.index then
                    self.fg = theme.taglist_bg_focus
                    self.bg = theme.taglist_fg_focus
                    self:get_children_by_id('border')[1].border_color = theme.taglist_bg_focus
                    self:get_children_by_id('border')[1].visible = false;
                elseif #tag:clients() > 0 then
                    self.fg = theme.taglist_fg_occupied
                    self.bg = theme.bg_normal
                    self:get_children_by_id('border')[1].border_color = theme.taglist_fg_occupied
                else
                    self.bg = theme.bg_normal
                    self.fg = theme.taglist_fg_empty
                    self:get_children_by_id('border')[1].border_color = theme.taglist_fg_empty
                end

                self:get_children_by_id('index')[1].markup = awful.util.tagicons[s.index][index].text

                self:connect_signal('mouse::enter', function()
                    if index ~= s.selected_tag.index then
                        self.bg = theme.darker

                    end
                end)
                self:connect_signal('mouse::press', function()

                end)
                self:connect_signal('mouse::leave', function()
                    if index ~= s.selected_tag.index then
                        self.bg = theme.dark
                    end
                end)
            end,
            update_callback = function(self, tag, index, tags)

                self:get_children_by_id('border')[1].visible = true;
                if index == s.selected_tag.index then
                    self.fg = theme.taglist_bg_focus
                    self.bg = theme.taglist_fg_focus
                    self:get_children_by_id('border')[1].border_color = theme.taglist_bg_focus
                    self:get_children_by_id('border')[1].visible = false;
                elseif #tag:clients() > 0 then
                    self.fg = theme.taglist_fg_occupied
                    self.bg = theme.bg_normal
                    self:get_children_by_id('border')[1].border_color = theme.taglist_fg_occupied
                else
                    self.bg = theme.bg_normal
                    self.fg = theme.taglist_fg_empty
                    self:get_children_by_id('border')[1].border_color = theme.taglist_fg_empty
                end

                self:get_children_by_id('index')[1].markup = awful.util.tagicons[s.index][index].text

            end,
        },
        buttons         = taglist_buttons
    }

    -- Create the wibox
    s.mywibox = awful.wibox({ screen = s, height = dpi(26), bg = theme.transparent, opacity = 0.8 })

    --s.mywibox = awful.wibar({ screen = s, position = "top", width = 2540, stretch = false, margins = { top = 10 }, height = 18, border_width = 0, opacity = 1.0, bg = theme.tasklist_bg_normal, fg = theme.fg_normal, shape = function(cr, width, height) gears.shape.rounded_rect(cr, width, height, 0) end })

    if s.index == 1 then

        s.mywibox:setup {

            {
                widget = wibox.container.background,
                bg     = theme.black,
                radius = 1,
                shape  = gears.shape.rounded_rect,
                {
                    {
                        layout = wibox.layout.align.horizontal,
                        { -- Left widgets
                            layout = wibox.layout.fixed.horizontal,
                            s.mytaglist
                        },
                        nil,
                        { -- Right widgets
                            layout = wibox.layout.fixed.horizontal,
                            seperator,
                            wibox.widget.systray(),
                            seperator,
                            theme.lan,
                            seperator,
                            theme.wan,
                            seperator,
                            theme.mem,
                            seperator,
                            theme.cpu,
                            seperator,
                            theme.volumnWidge,
                            seperator,
                            theme.date,
                            seperator,
                            theme.time,
                            seperator
                        }
                    },
                    left = 5,
                    right = 5,
                    top = 5,
                    bottom = 5,
                    widget = wibox.container.margin

                }
            },
            left = 5,
            right = 5,
            top = 5,
            bottom = 0,
            widget = wibox.container.margin

        }
    else
        s.mywibox:setup {

            {
                widget = wibox.container.background,
                bg     = theme.black,
                radius = 1,
                shape  = gears.shape.rounded_rect,
                {
                    {
                        layout = wibox.layout.align.horizontal,
                        { -- Left widgets
                            layout = wibox.layout.fixed.horizontal,
                            s.mytaglist
                        },
                        nil,
                        { -- Right widgets
                            layout = wibox.layout.fixed.horizontal,
                            seperator,
                            wibox.widget.systray(),
                            theme.date,
                            seperator,
                            theme.time,
                            seperator
                        }
                    },
                    left = 5,
                    right = 5,
                    top = 5,
                    bottom = 5,
                    widget = wibox.container.margin

                }
            },
            left = 5,
            right = 5,
            top = 5,
            bottom = 0,
            widget = wibox.container.margin

        }
    end

end

return theme
