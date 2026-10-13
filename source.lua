
local Nexora = {}

Nexora.Version = "0.1.0"
Nexora.Name = "Nexora UI"

function Nexora:CreateWindow(options)
    options = options or {}

    local Window = {
        Name = options.Name or "Nexora UI"
    }

    return Window
end

return Nexora
