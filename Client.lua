local DefaultParticle = {}

for i,v in pairs(workspace:GetDescendants()) do
	if v:IsA("ParticleEmitter") then
		local EmitterRealRate = v.Rate
		table.insert(DefaultParticle, {
			Particle = v,
			Default = v.Rate
		})
	end
end

function getParticle(particle)
	for i,v in pairs(DefaultParticle) do
		if v.Particle == particle then
			return i
		end
	end
	return false
end


function ParticleGraphics()
	for i,v in pairs(workspace:GetDescendants()) do
		if v:IsA("ParticleEmitter") then
			local GraphicsLevel = UserSettings().GameSettings.SavedQualityLevel.Value
			local index = getParticle(v)
			if index then
				local Emitter = DefaultParticle[index]
				if GraphicsLevel == 0 then
					v.Rate = Emitter.Default * 10 / 1
					return
				end
				v.Rate = Emitter.Default * 10 / GraphicsLevel
			end
		end
	end
end
ParticleGraphics()
UserSettings().GameSettings:GetPropertyChangedSignal("SavedQualityLevel"):Connect(ParticleGraphics)
