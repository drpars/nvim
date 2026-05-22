return {
	"tree-sitter-grammars/tree-sitter-yuck",
	name = "tree-sitter-yuck",
	lazy = true,
	build = function()
		local repo_dir = vim.fn.stdpath("data") .. "/lazy/tree-sitter-yuck"
		local parser_path = vim.fn.stdpath("data") .. "/site/parser/yuck.so"

		vim.fn.system("cd " .. vim.fn.shellescape(repo_dir) .. " && tree-sitter build")
		os.execute("mkdir -p " .. vim.fn.shellescape(vim.fn.fnamemodify(parser_path, ":h")))
		os.execute("cp " .. vim.fn.shellescape(repo_dir .. "/yuck.so") .. " " .. vim.fn.shellescape(parser_path))
	end,
}
