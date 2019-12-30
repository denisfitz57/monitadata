function [npvi cv] = getNPVI(in)
%GETNPVI    Calculates nPVI and CV (see Grabe & Low, 2002).
%
%   [NPVI CV] = GETNPVI(IN) returns the Normalized Pairwise Variability 
%   Index NPVI (M*N or M*N*P) and Coefficient of Variation CV (M*N or M*N*P)
%   for input statement IN. IN is a matrix of syllable durations of size 
%   M*N or M*N*P.
%
%   Example: If IN = [1 2 3; 3 3 6; 4 6 8; 4 7 7];
%
%   then [npvi cv] = getNPVI(IN) is npvi = [53.3333; 33.3333; 34.2857; 27.2727]. 
%   cv is [0.5000; 0.4330; 0.3333; 0.2887]
%
%   Example: If IN(:,:,1) = [1 2 3; 3 3 6] and IN(:,:,2) = [4 6 8; 4 7 7]
%
%   then [npvi cv] = getNPVI(IN) is npvi(:,:,1) = [53.3333; 33.3333], and
%   npvi(:,:,2) = [34.2857; 27.2727]. cv(:,:,1) = [0.5000; 0.4330], and
%   cv(:,:,2) = [0.3333; 0.2887].
%
%   See also: http://vesicle.nsi.edu/users/patel/npvi_calculator.html
%
%   Grabe, E., & Low, E. L. (2002). Durational variability in speech and the
%   rhythm class hypothesis. In C. Gussenhoven & N. Warner (Eds.),
%   Papers in laboratory psychology (pp. 515–546). Cambridge.
%
%   Copyright 2011 Steven R. Livingstone 
%   steven dot livingstone at mcgill dot ca
%	Version 1.0
%   Date: 2011/09/30

% To calculate nPVI, statement must have 2 or more syllables
assert(size(in,2) > 1, 'Error, number of syllables must be greater than 1');
% Input must be an MxN or MxNxP matrix
assert(ndims(in) < 4, 'Error, input must 2d or 3d matrix of doubles');

% Calculate npvi & cv
npvi = 100*sum(abs(diff(in,1,2)./((in(:,1:end-1,:)+in(:,2:end,:))/2)),2)/(size(in,2)-1);
cv = std(in,0,2)./mean(in,2);

end