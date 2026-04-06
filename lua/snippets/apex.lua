-- apex.lua
-- LuaSnip snippets for Salesforce Apex (with uppercase placeholders + debug)

local ls  = require("luasnip")
local s   = ls.snippet
local t   = ls.text_node
local i   = ls.insert_node
local rep = require("luasnip.extras").rep

-- Register for 'apex'
ls.add_snippets("apex", {
    -- if - simple if (expression) { ... }
    s("if", {
        t({ "if (" }), i(1, "CONDITION"), t({ ") {", "\t" }),
        i(0),
        t({ "", "}" })
    }),

    -- for - enhanced for (Type variableName : iterableVariableName) { ... }
    s("for", {
        t({ "for (" }), i(1, "TYPE"), t({ " " }), i(2, "ITEM"),
        t({ " : " }), i(3, "ITERABLE"),
        t({ ") {", "\t" }),
        i(0),
        t({ "", "}" })
    }),

    -- fori - for (Integer i = start; i < end; i++) { ... }
    s("fori", {
        t({ "for (Integer " }), i(1, "I"), t({ " = " }), i(2, "START"),
        t({ "; " }), rep(1), t({ " < " }), i(3, "END"),
        t({ "; " }), rep(1), t({ "++) {", "\t" }),
        i(0),
        t({ "", "}" })
    }),

    -- newList - List<Type> name = new List<Type>();
    s("newList", {
        t({ "List<" }), i(1, "TYPE"), t({ "> " }), i(2, "NAME"),
        t({ " = new List<" }), rep(1), t({ ">();" })
    }),

    -- newSet - Set<Type> name = new Set<Type>();
    s("newSet", {
        t({ "Set<" }), i(1, "TYPE"), t({ "> " }), i(2, "NAME"),
        t({ " = new Set<" }), rep(1), t({ ">();" })
    }),

    -- newMap - Map<KeyType, ValueType> name = new Map<KeyType, ValueType>();
    s("newMap", {
        t({ "Map<" }), i(1, "KEYTYPE"), t({ ", " }), i(2, "VALUETYPE"),
        t({ "> " }), i(3, "NAME"),
        t({ " = new Map<" }), rep(1), t({ ", " }), rep(2), t({ ">();" })
    }),

    -- debug - System.debug(TEXT);
    s("debug", {
        t({ "System.debug(" }), i(1, "TEXT"), t({ ");" })
    }),
})

-- Optional: also register the same snippets for 'apexcode' ft (some setups use this)
ls.add_snippets("apexcode", ls.get_snippets("apex"))
