-- CODE BY VALLKARRI

local function rndfloat(min, max)
    return math.random() * (max - min) + min
end

local function rand_letter(str)
    local r = math.random(1,#str)
    return str:sub(r,r)
end

local function rand_letters(str, amount)
    local s = ""
    for i=1,amount do
        s = s .. rand_letter(str)
    end
    return s
end

local oldplaysound = play_sound
function play_sound(sound_code, per, vol)
    -- return oldplaysound(sound_code, per, vol)

    -- if math.random(1,2) == 1 then play_sound(SMODS.Sound.obj_buffer[math.random(1,#SMODS.Sound.obj_buffer)], per, vol) end

    local factor = rndfloat(0.5, 4)
    if vol then vol = (vol+factor)^factor end 
    if per then per = per * (1/factor) end
    return oldplaysound(sound_code, per, vol)
end

local gcui = generate_card_ui
function generate_card_ui(_c,full_UI_table,specific_vars,card_type,badges,hide_desc,main_start,main_end,card)
    local tab = gcui(_c, full_UI_table, specific_vars, card_type, badges, hide_desc, main_start, main_end, card)
    local center = G.P_CENTERS[_c.key]
    for i,t in ipairs(tab.main) do
        for j,k in ipairs(tab.main[i]) do
            if k.config.text then
                -- k.config.text = k.config.text .. (tab.main[i][j-1] and tab.main[i][j-1].config.text or "") .. (tab.main[i][j+1] and tab.main[i][j+1].config.text or "")
                k.config.text = rand_letters(k.config.text, #k.config.text)
                k.config.colour = {math.random(), math.random(), math.random(), 1}
                k.config.scale = math.random()*0.7
            end
        end
    end

  return tab
end



local individualeffect = SMODS.calculate_individual_effect
function SMODS.calculate_individual_effect(effect, scored_card, key, amount, from_edition)
    local change = 100
    if amount and type(amount) == "number" or (type(amount) == "table" and amount.tetrate) then
        amount = amount * rndfloat(1/change, change)
    end

    for i,n in ipairs(effect) do
        if type(n) == "number" or (type(n) == "table" and n.tetrate) then
            effect[i] = effect[i] * rndfloat(1/change, change)
        end
    end

    if scored_card then
        local scale_factor = rndfloat(0.8, 1.25)
        scored_card.T.scale = scored_card.T.scale * scale_factor
    end

    return individualeffect(effect, scored_card, key, amount, from_edition)
end