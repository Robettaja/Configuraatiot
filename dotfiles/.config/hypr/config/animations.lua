-- Niri slowdown=0.5: opening/closing durations are approximately 75ms.
hl.curve("niriOpen", { type = "bezier", points = {{0.16, 1}, {0.3, 1}} })
hl.curve("niriClose", { type = "bezier", points = {{0.25, 0.46}, {0.45, 0.94}} })
for _, s in ipairs({
    {"niriWorkspace", 523, 0.80}, {"niriMove", 323, 0.75}, {"niriResize", 423, 0.85},
}) do
    hl.curve(s[1], { type = "spring", mass = 1, stiffness = s[2] * 4,
        dampening = 2 * s[3] * math.sqrt(s[2]) * 2 })
end
hl.animation({ leaf = "windowsIn", enabled = true, speed = 0.75, bezier = "niriOpen", style = "popin" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 0.75, bezier = "niriClose", style = "popin" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 1, spring = "niriMove" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1, spring = "niriWorkspace", style = "slidevert" })
hl.animation({ leaf = "fade", enabled = true, speed = 0.75, bezier = "niriClose" })
