--CORRUPTELLA, Written by ViTi95

function fuckDomain(count, domain)
	local size = memory.getmemorydomainsize(domain)
	for i = 0, count - 1 do
		local byte = math.random(0, 255)
		local address = math.random(0, size - 1)
		memory.writebyte(address, byte, domain)
	end
end

function backupDomain(filename, domain)
	local domainSize = memory.getmemorydomainsize(domain)
	local data = memory.readbyterange(0, domainSize, domain)
	local file = io.open(filename, "w+b")

	local keys = {}

	for i = 0, domainSize - 1 do
		file:write(string.char(data[i]))
	end

	io.close(file)
end

function restoreDomain(filename, domain)
	local domainSize = memory.getmemorydomainsize(domain)
	local file = io.open(filename, "rb")

	local data = file:read(domainSize)

	for i = 0, domainSize - 1 do
		local posData = i + 1
		local byte = data:byte(posData, posData)
		memory.writebyte(i, byte, domain)
	end

	io.close(file)
end

function fuckVideo()
	--gui.text(0, 0, "Video")

	local sys = emu.getsystemid()

	if sys == "GEN" then
		fuckDomain(16, "CRAM")
		fuckDomain(2, "VSRAM")
		fuckDomain(16, "VRAM")
	elseif sys == "SMS" then
		fuckDomain(2, "Video RAM")
	elseif sys == "GB" then
		fuckDomain(16, "VRAM")
		fuckDomain(2, "OAM")
		fuckDomain(16, "HRAM")
	elseif sys == "GBC" then
		fuckDomain(16, "VRAM")
		fuckDomain(2, "OAM")
		fuckDomain(16, "HRAM")
	elseif sys == "SNES" then
		fuckDomain(16, "VRAM")
		fuckDomain(2, "OAM")
		fuckDomain(16, "CGRAM")
	elseif sys == "A26" then
		fuckDomain(1, "TIA")
	elseif sys == "NES" then
		fuckDomain(2, "CIRAM (nametables)")
		fuckDomain(2, "OAM")
		fuckDomain(2, "CHR VROM")
	elseif sys == "PSX" then
		fuckDomain(1024, "GPURAM")
	elseif sys == "GBA" then
		fuckDomain(16, "VRAM")
		fuckDomain(1, "OAM")
		fuckDomain(1, "PALRAM")
	elseif sys == "INTV" then
		fuckDomain(1, "Graphics RAM")
	end
end

function fuckSound()
	--gui.text(0, 0, "Sound")

	local sys = emu.getsystemid()

	if sys == "GEN" then
		fuckDomain(1, "Z80 RAM")
	elseif sys == "SNES" then
		fuckDomain(2, "APURAM")
	elseif sys == "PSX" then
		fuckDomain(128, "SPURAM")
	end
end

function fuckRAM()
	--gui.text(0, 0, "RAM")

	local sys = emu.getsystemid()

	if sys == "N64" then
		fuckDomain(64, "RDRAM")
	elseif sys == "GEN" then
		fuckDomain(8, "68K RAM")
	elseif sys == "SMS" then
		fuckDomain(2, "Main RAM")
	elseif sys == "GB" then
		fuckDomain(16, "WRAM")
	elseif sys == "GBC" then
		fuckDomain(16, "WRAM")
	elseif sys == "SNES" then
		fuckDomain(16, "WRAM")
	elseif sys == "A26" then
		fuckDomain(1, "Main RAM")
	elseif sys == "NES" then
		fuckDomain(2, "RAM")
	elseif sys == "PSX" then
		fuckDomain(8, "MainRAM")
	elseif sys == "GBA" then
		fuckDomain(8, "EWRAM")
		fuckDomain(2, "IWRAM")
	elseif sys == "PCE" then
		fuckDomain(8, "Main Memory")
	elseif sys == "WSWAN" then
		fuckDomain(4, "RAM")
	elseif sys == "INTV" then
		fuckDomain(1, "Main RAM")
	end
end

function fuckROM()
	--gui.text(0, 0, "ROM")

	local sys = emu.getsystemid()

	if sys == "N64" then
		fuckDomain(512, "ROM")
	elseif sys == "GEN" then
		fuckDomain(8, "MD CART")
	elseif sys == "SMS" then
		fuckDomain(2, "ROM")
	elseif sys == "GB" then
		fuckDomain(8, "ROM")
	elseif sys == "GBC" then
		fuckDomain(8, "ROM")
	elseif sys == "SNES" then
		fuckDomain(16, "CARTROM")
	elseif sys == "NES" then
		fuckDomain(2, "PRG ROM")
	elseif sys == "GBA" then
		fuckDomain(16, "ROM")
	elseif sys == "PCE" then
		fuckDomain(8, "ROM")
	elseif sys == "WSWAN" then
		fuckDomain(16, "ROM")
	elseif sys == "INTV" then
		fuckDomain(2, "Executive Rom")
	end
end

local romdump = "corruptella.dmp"

function saveState(slot)
	client.SetSoundOn(false)
	client.pause()

	local sys = emu.getsystemid()

	if sys == "N64" then
		backupDomain(romdump, "ROM")
	elseif sys == "SMS" then
		backupDomain(romdump, "ROM")
	elseif sys == "GEN" then
		backupDomain(romdump, "MD CART")
	elseif sys == "GB" then
		backupDomain(romdump, "ROM")
	elseif sys == "GBC" then
		backupDomain(romdump, "ROM")
	elseif sys == "SNES" then
		backupDomain(romdump, "CARTROM")
	elseif sys == "NES" then
		backupDomain(romdump, "PRG ROM")
	elseif sys == "GBA" then
		backupDomain(romdump, "ROM")
	elseif sys == "PCE" then
		backupDomain(romdump, "ROM")
	elseif sys == "WSWAN" then
		backupDomain(romdump, "ROM")
	elseif sys == "INTV" then
		backupDomain(romdump, "Executive Rom")
	end

	savestate.saveslot(slot, true)

	client.unpause()
	client.SetSoundOn(true)
end

function loadState(slot)
	client.SetSoundOn(false)
	client.pause()

	local sys = emu.getsystemid()

	if sys == "N64" then
		restoreDomain(romdump, "ROM")
	elseif sys == "SMS" then
		restoreDomain(romdump, "ROM")
	elseif sys == "GEN" then
		restoreDomain(romdump, "MD CART")
	elseif sys == "GB" then
		restoreDomain(romdump, "ROM")
	elseif sys == "GBC" then
		restoreDomain(romdump, "ROM")
	elseif sys == "SNES" then
		restoreDomain(romdump, "CARTROM")
	elseif sys == "NES" then
		restoreDomain(romdump, "PRG ROM")
	elseif sys == "GBA" then
		restoreDomain(romdump, "ROM")
	elseif sys == "PCE" then
		restoreDomain(romdump, "ROM")
	elseif sys == "WSWAN" then
		restoreDomain(romdump, "ROM")
	elseif sys == "INTV" then
		restoreDomain(romdump, "Executive Rom")
	end

	savestate.loadslot(0, true)

	client.unpause()
	client.SetSoundOn(true)
end

function printInfo()
	local y = 0
	local sys = emu.getsystemid()
	gui.text(0, y, "SYSTEM: " .. sys)
	y = y + 16
	for key, domain in pairs(memory.getmemorydomainlist()) do
		local memSize = memory.getmemorydomainsize(domain)
		gui.text(0, y, domain .. ": " .. memSize)
		y = y + 16
	end
end

local lastPress = ""

while true do
	local input = input.get()
	if (input.I == true) then
		printInfo()
	elseif (input.Y == true and lastPress ~= "Y") then
		fuckROM()
		lastPress = "Y"
	elseif (input.U == true and lastPress ~= "U") then
		fuckRAM()
		lastPress = "U"
	elseif (input.R == true and lastPress ~= "R") then
		fuckSound()
		lastPress = "Y"
	elseif (input.T == true and lastPress ~= "T") then
		fuckVideo()
		lastPress = "U"
	elseif (input.O == true and lastPress ~= "O") then
		saveState(0)
		lastPress = "O"
	elseif (input.P == true and lastPress ~= "P") then
		loadState(0)
		lastPress = "P"
	else
		lastPress = ""
	end

	emu.frameadvance()
end
