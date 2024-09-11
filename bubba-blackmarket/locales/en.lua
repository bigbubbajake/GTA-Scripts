local Translations = {
    error = {
        incorrect_amount = "Incorrect amount",
        no_space = "Not enough space in inventory",
        no_slots = "Not enough slots in inventory",
        no_money = "Not enough money",
        cant_give = "Can't give item!",
    },
    target = {
        browse = "Browse Shop",
    },
    menu = {
        close = "❌ Close",
        cost = "Cost: $",
        weight = "Weight:",
        confirm = "Confirm Purchase",
        cpi = "Cost per item:",
        payment_type = "Payment Type",
        cash = "Cash",
        card = "Card",
        amount = "Amount to buy",
        submittext = "Pay",
        blackmoney = "Black Money",
        crypto = "Q-Bit",
     }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})
