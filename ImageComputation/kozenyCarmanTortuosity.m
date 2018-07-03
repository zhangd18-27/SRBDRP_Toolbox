function [ tortuosity ] = ...
    kozenyCarmanTortuosity( geomFactor, phi, ssa, ...
                            permeability, dl )
%kozenyCarmanTortuosity computes tortuosity using Kozeny-Carman Eq.
%   permeability = geomFactor .* phi.^3 ./ (ssa.^2 .* tortuosity.^2);
%
%   Input Arguments
%   - geomFactor   : a double, geometric factor (unitless)
%                    0.5   for pipe with circle or ellipse cross-section
%                    0.562 for pipe with square cross-section
%                    0.6   for pipe with equilateral triangle cross-section
%                    for any other shapes, 0.5 is typically assumed.
%   - phi          : a double, porosity (unitless)
%   - ssa          : a double, specific surface area (unit: 1/pixel length
%                    or 1/meter if dl = 1)
%   - permeability : a double, permeability in mD (millidarcy)
%   - dl           : a double, the length of one pixel in meter
%                    (dx = 0.002 mm -> dl = 0.002.* 0.001 m). dl = 1 is
%                    there's no correction needed
%
%   Output Arguments
%   - tortuosity   : a double, length of flow path over length of frame
%                    (unitless)
%
%   Example
%     R = 4; nx = 100; nz = 100; L = 200; l = 200;
%     phi = pi.*R.^2./(nx*nz);
%     ssa = 2.*pi.*R.*l./(nx.*L.*nz);
%     dl  = 0.002.*0.001; %m;
%     geomFactor = 0.5;
%     permeability = 40; %mD
%     kozenyCarmanTortuosity( geomFactor, phi, ssa, ...
%                             permeability, dl )

%   Revision 1: July   2015 Nattavadee Srisutthiyakorn
%   Stanford Rock Physics and Borehole Geophysics Project (SRB)



%%
% Convert unit m^2 to millidarcy
m2tomD = 1 ./ 0.986923 ./ 10.^-12 .* 1000;

% Change the scale
ssa = ssa ./ dl;

% Calculate geometrical Factor
tortuosity = sqrt(m2tomD .* geomFactor .* ...
               phi.^3 ./ ((ssa).^2 .* permeability));

           
           
end
