local Template = {}


function Template:open(file)
	print("Template:open")
end


function Template:render(file, params)
	print("Template:open", file, params)
end

return Template 
