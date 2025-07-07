local npairs = require("nvim-autopairs")
local Rule = require("nvim-autopairs.rule")

npairs.setup({
    check_ts = true, -- optional: enables Treesitter integration
})
npairs.add_rule(Rule("|","|","rust"))
-- npairs.add_rule(Rule("<",">","rust"))
npairs.add_rule(Rule("$$","$$","tex"))
