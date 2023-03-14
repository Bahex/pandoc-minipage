if not FORMAT:match("latex") then
	return {}
end

local function width_percent_to_linewidth(width)
	if width then
		local percent = width:match("^(%d+)%%$")
		if percent then
			return ("%s\\linewidth"):format(percent / 100)
		end
		return width
	end
end

local div_to_minipage = function(elem)
	if not elem.classes:includes("minipage") then
		return
	end
	local attrs = elem.attributes
	return {
		pandoc.RawBlock("latex", ("\\begin{minipage}[%s][%s][%s]{%s}"):format(
			attrs.align or "c",
			attrs.height or "",
			attrs.place or attrs.align or "c",
			width_percent_to_linewidth(attrs.width) or ""
		)),
		elem,
		pandoc.RawBlock("latex", "\\end{minipage}"),
	}
end

local stick_minipages = function(elem)
	if not elem.classes:includes("minipages") then
		return
	end

	local blocks = elem.content

	for i = #blocks - 1, 2, -1 do
		if blocks[i].t == "RawBlock" and blocks[i].text:match("end") and
			blocks[i + 1].t == "RawBlock" and blocks[i + 1].text:match("begin")
		then
			blocks[i].text = blocks[i].text .. "\n" .. blocks[i + 1].text
			blocks:remove(i + 1)
		end
	end

	return blocks
end

return {
	{ Div = div_to_minipage },
	{ Div = stick_minipages },
}
