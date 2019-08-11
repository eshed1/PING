function [out] = toOneHot(curr,vocab,defaultidx,varargin)
Nv = length(vocab);
out = zeros(1,Nv);
vocab = lower(vocab);
%Break into individual
C = strsplit(curr);

if(~isempty(varargin) && varargin{1} == 1)
    rangei = 1; %:length(C);
else
    rangei = 1:length(C);
end

for i = rangei
    idx = strcmp(lower(C{i}),vocab);
    out = out+idx;
end

out(out>1) = 1;

if(sum(out) == 0)
    out(defaultidx) = 1;
end
%If all 0, just put misc. 

end

