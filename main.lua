--you need to test on devices
local ibeacon = require( "plugin.ibeacon" )
local bg = display.newRect( display.contentCenterX, display.contentCenterY, display.actualContentWidth, display.actualContentHeight )
local logo = display.newText( "iBeacon Plugin", 0, 0, native.systemFontBold, 20 )
logo.x, logo.y = display.contentCenterX, 50
bg:setFillColor( .5,.09,.2 )
local widget = require("widget")
local uuid = "00000000-0000-0000-0000-000000000000"
local function iBeaconLis( e )
    print( "Beacon Found" )
    print( "--------------" )
    print( "accuracy:"..e.accuracy )
    print( "uuid:"..e.uuid )
    print( "accuracy:"..e.accuracy )
    print( "major:"..e.major )
    print( "minor:"..e.minor )
    print( "--------------" )
end

local broadcast
broadcast = widget.newButton( {
	label = "Start Broadcast",
	id = "broadcast",
	onEvent = function( e )
        print(broadcast:getLabel( ))
		if (broadcast:getLabel( ) == "Start Broadcast") then
			if (e.phase == "began") then
				broadcast.alpha = .3
			else
				broadcast.alpha = 1
				ibeacon.startTransmitting(uuid, 10001, 69)
				broadcast:setLabel( "Stop Broadcast" )
			end
		elseif (broadcast:getLabel( ) == "Stop Broadcast") then
			if (e.phase == "began") then
				broadcast.alpha = .3
			else
				broadcast.alpha = 1
				ibeacon.stopTransmitting()
				broadcast:setLabel( "Start Broadcast" )
			end
		end
	end
} )
broadcast.x, broadcast.y = display.contentCenterX, display.contentCenterY-100

local search
search = widget.newButton( {
	label = "Start Search",
	id = "search",
	onEvent = function( e )
		if (search:getLabel( ) == "Start Search") then
			if (e.phase == "began") then
				search.alpha = .3
			else
				ibeacon.setTimer(5)
				ibeacon.search({uuid}, iBeaconLis)
				search.alpha = 1
				search:setLabel( "Stop Search" )
			end
		elseif (search:getLabel( ) == "Stop Search") then
			if (e.phase == "began") then
				search.alpha = .3
			else
				ibeacon.stopAll()
				search.alpha = 1
				search:setLabel( "Start Search" )
			end
		end
	end
} )
search.x, search.y = display.contentCenterX, display.contentCenterY-20