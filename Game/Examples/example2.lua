
function f(a, b)
    return a or b
end

function f2(arg)
    return f(arg.a, arg.b)
end

function Args(...)
    local kargs = {...}
    for k,v in ipairs(kargs) do
        print(k, v)
    end
end

a = {1,2,3,4,5,6}
local i = 1
print()
print("While...")
while a[i] do
    print(a[i])
    i = i + 1
end

print()
print("For...")
for key, value in ipairs(a) do
    print(key, value)
end

local i = 1
print()
print("While...")
while i < 10 do 
    print(i)
    i = i + 1
end

revDay = {
    Sunday = 2,
    ["Tuesday"] = 1
}

print()
print "Dict..."
for k in pairs(revDay) do
    print(k)
end

print()
print [[ Heelllo
Muuultline
World]]
print()

var = f2{b=1, a=3}
print(var)
print("ARGS")
Args(10, 100, 1000)

print()
print("Select obj['attr'] or obj.attr")
print(revDay["Sunday"])
print(revDay.Sunday)
