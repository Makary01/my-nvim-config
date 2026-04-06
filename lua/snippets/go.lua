local luasnip = require('luasnip')
local snippet = luasnip.snippet
local textNode = luasnip.text_node
local insertNode = luasnip.insert_node

luasnip.add_snippets("go", {
    snippet("ie", {
        textNode({ "if err != nil {", "\t" }),
        insertNode(1),
        textNode({ "", "}" }),
    })
})
