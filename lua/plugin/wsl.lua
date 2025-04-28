if vim.fn.executable("wl-copy") == 0 then
	print("wl-clipboard not found, clipboard integration won't work")
else
	vim.g.clipboard = {
		name = "wl-clipboard (wsl)",
		copy = {
			["+"] = 'wl-copy --foreground --type text/plain',
			["*"] = 'wl-copy --foreground --primary --type text/plain',
		},
		paste = {
			["+"] = (function()
				return vim.fn.systemlist('wl-paste --no-newline|sed -e "s/\r$//"', { '' }, 1) -- '1' keeps empty lines
			end),
			["*"] = (function()
				return vim.fn.systemlist('wl-paste --primary --no-newline|sed -e "s/\r$//"', { '' }, 1)
			end),
		},
		cache_enabled = true
	}
end
