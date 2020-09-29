function path = road(IRI, numSteps)
step = normrnd(IRI, (IRI/10), [1,numSteps]);

save path
end