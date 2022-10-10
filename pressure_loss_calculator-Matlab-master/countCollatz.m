function countCollatz

count = collatzRecursive(1234567890)


end



function re = collatzRecursive(n)
f = @compute;
result = f(n)
if (result == 1) 
    re = 1;
else 
    re = 1 + collatzRecursive(result);
end

end

function y = compute(x) 
if (rem(x,2) == 0) 
    y = x/2;
else 
    y = 3*x+1;
end
end