%% (Internal) Reshape a matrix into a row vector
% Return x as a row vector. This function is useful when a function returns a
% column vector or matrix and you want to immediately reshape it in a functional
% way. Suppose f(a,b,c) returns a column vector, matlab will not let you write
% f(a,b,c)(:)' - you would have to first store the result. With this function you
% can write rowvec(f(a,b,c)) and be assured that the result is a row vector.   
% 
%    x = colvec(x)
% 
% Arguments:
% 
%      + x: data
% 
% Output:
% 
%      + x: columnized data
% 
% Example:
% 
% See also colvec
% 
% This file is from pmtk3.googlecode.com
%
% 
% This program is free software; you can redistribute it and/or
% modify it under the terms of the GNU General Public License
% as published by the Free Software Foundation; either version 2
% of the License, or (at your option) any later version.
%
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
%
% You should have received a copy of the GNU General Public License
% along with this program; if not, write to the Free Software Foundation, Inc., 
% 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.
%
% Copyright 2008-2015
% 
function x = rowvec(x)
    x = x(:)';
end
