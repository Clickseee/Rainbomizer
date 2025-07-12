local oldplaysound = play_sound
function play_sound(sound_code, per, vol)
    if card and card.children and card.children.center then sound_code = pseudorandom_element(SMODS.Sound.obj_buffer, "seed") end
    return oldplaysound(sound_code, per, vol)
end

local gcui = generate_card_ui
function generate_card_ui(_c,full_UI_table,specific_vars,card_type,badges,hide_desc,main_start,main_end,card)
    local tab = gcui(_c, full_UI_table, specific_vars, card_type, badges, hide_desc, main_start, main_end, card)
    local center = G.P_CENTERS[_c.key]


    if card and card.children and card.children.center then
        local a = 0.1
        local rnd1 = (math.random()*a)-(a*0.5)
        local rnd2 = (math.random()*a)-(a*0.5)
        card.children.center:set_sprite_pos({x=card.children.center.sprite_pos.x+rnd1, y=card.children.center.sprite_pos.y+rnd2})
    end
    for i,t in ipairs(tab.main) do
        for j,k in ipairs(tab.main[i]) do
            if k.config.text then
                k.config.text = k.config.text .. (tab.main[i][j-1] and tab.main[i][j-1].config.text or "") .. (tab.main[i][j+1] and tab.main[i][j+1].config.text or "")
                k.config.colour = {math.random(), math.random(), math.random(), 1}
                k.config.scale = math.random()*0.7
            end
        end
    end

  return tab
end