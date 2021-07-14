vector.offset = function ( pos, x, y, z )
        return { x = pos.x + x, y = pos.y + y, z = pos.z + z }
end

vector.offset_y = function ( pos, y )
        return { x = pos.x, y = pos.y + ( y or 1 ), z = pos.z }
end

vector.origin = { x = 0, y = 0, z = 0 }