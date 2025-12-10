-- Build Lightroom hierarchical keyword string for taxonomy.
-- Target structure when full taxonomy is available:
--   Birds|<order>|<family>|<scientific name>|<common name>
-- Current callers only provide (nom_fr, nom_latin); order/family are optional.
local function buildHierarchicalKeyword(nom_fr, nom_latin, order_name, family_name)
	local parts = {}

	-- Top-level group for all birds
	table.insert(parts, "Birds")

	-- Optional taxonomic ranks if available
	if order_name and order_name ~= "" then
		table.insert(parts, order_name)
	end
	if family_name and family_name ~= "" then
		table.insert(parts, family_name)
	end

	-- Scientific name node
	if nom_latin and nom_latin ~= "" then
		table.insert(parts, nom_latin)
	end

	-- Common name leaf (skip "Unknown")
	if nom_fr and nom_fr ~= "" and nom_fr ~= "Unknown" then
		table.insert(parts, nom_fr)
	end

	return table.concat(parts, "|")
end
