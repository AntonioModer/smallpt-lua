--[[
	Copyright (c) 2012 Roland Yonaba

	Permission is hereby granted, free of charge, to any person obtaining a
	copy of this software and associated documentation files (the
	"Software"), to deal in the Software without restriction, including
	without limitation the rights to use, copy, modify, merge, publish,
	distribute, sublicense, and/or sell copies of the Software, and to
	permit persons to whom the Software is furnished to do so, subject to
	the following conditions:

	The above copyright notice and this permission notice shall be included
	in all copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
	OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
	MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
	IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
	CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
	TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
	SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
--]]

if (...) then
  local ROOT_PATH = (...):match('^(.*[%./])[^%.%/]+[%./][^%.%/]+$')  or ''
  local Ray = require (ROOT_PATH .. ('core.ray'))
  local radiance = require (ROOT_PATH .. ('core.radiance'))
  
  -- Evaluates specular (mirror) reflection
  return function (scene, ray, hitPoint, n, color, emColor, inclEmColor, depth, MAX_DEPTH)
    local newRay = Ray(hitPoint, ray.direction - n * (2 * n:dot(ray.direction)))
    local newRadiance = radiance(scene, newRay, nil, depth, MAX_DEPTH)
    return emColor + color:mul(newRadiance)
  end
end
