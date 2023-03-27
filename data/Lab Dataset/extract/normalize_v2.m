function hold = normalize_v2(hold)
  	maxA = max(hold);
 	minA = min(hold);
	
  	m = (1 - (-1)) / (maxA - minA);
  	c = 1 - (m * maxA);
 	
 	hold = (m .* hold) + c;
end