--[[
    Copyright (C) 2015 Panagiotis Roubatsis

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License along
    with this program; if not, write to the Free Software Foundation, Inc.,
    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
--]]

dofile("lua/lib/vectors.lua")

--Building functions
baseIndex = 0
function createQuad(x,y,z,upX,upY,upZ,rightX,rightY,rightZ)
	normalX,normalY,normalZ = normalize(crossProduct(upX,upY,upZ,rightX,rightY,rightZ))
	
	addVertex(x,y,z)
	addUV(0,0)
	addNormal(normalX,normalY,normalZ)
	
	addVertex(x+rightX,y+rightY,z+rightZ)
	addUV(1,0)
	addNormal(normalX,normalY,normalZ)
	
	addVertex(x+rightX+upX,y+rightY+upY,z+rightZ+upZ)
	addUV(1,1)
	addNormal(normalX,normalY,normalZ)
	
	addVertex(x+upX,y+upY,z+upZ)
	addUV(0,1)
	addNormal(normalX,normalY,normalZ)
	
	addTriangle(baseIndex + 0, baseIndex + 1, baseIndex + 2)
	addTriangle(baseIndex + 2, baseIndex + 3, baseIndex + 0)
	
	baseIndex = baseIndex + 4
end

function createQuadUV(x,y,z,upX,upY,upZ,rightX,rightY,rightZ,uvX,uvY)
	normalX,normalY,normalZ = normalize(crossProduct(upX,upY,upZ,rightX,rightY,rightZ))
	
	addVertex(x,y,z)
	addUV(0,0)
	addNormal(normalX,normalY,normalZ)
	
	addVertex(x+rightX,y+rightY,z+rightZ)
	addUV(uvX,0)
	addNormal(normalX,normalY,normalZ)
	
	addVertex(x+rightX+upX,y+rightY+upY,z+rightZ+upZ)
	addUV(uvX,uvY)
	addNormal(normalX,normalY,normalZ)
	
	addVertex(x+upX,y+upY,z+upZ)
	addUV(0,uvY)
	addNormal(normalX,normalY,normalZ)
	
	addTriangle(baseIndex + 0, baseIndex + 1, baseIndex + 2)
	addTriangle(baseIndex + 2, baseIndex + 3, baseIndex + 0)
	
	baseIndex = baseIndex + 4
end

--Create 4 walls
createNode()
baseIndex = 0
setTexture("bricks.red.tex")

createQuadUV(-15,0,15, 0,50,0, 30,0,0, 1,2)	--Front
createQuadUV(15,0,-15, 0,50,0, -30,0,0, 1,2)--Back

createQuadUV(-15,0,-15, 0,50,0, 0,0,30, 1,2)	--Left
createQuadUV(15,0,15, 0,50,0, 0,0,-30, 1,2)	--Right

--Roof (Generally Won't be seen)
createQuad(-15, 50, 15, 0,0,-30, 30,0,0)

--Windows
createNode()
baseIndex = 0
setTexture("windows.apartment.tex")

for x = -14, 12, 5 do 
	for y = 3, 45, 8 do
		createQuad(x,y,15.01, 0,4,0, 2,0,0)	--Front
		createQuad(-x,y,-15.01, 0,4,0, -2,0,0)--Back
		
		createQuad(-15.01,y,x, 0,4,0, 0,0,2)	--Left
		createQuad(15.01,y,-x, 0,4,0, 0,0,-2)	--Right
	end
end