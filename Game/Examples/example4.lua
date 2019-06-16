
local Pet = require("Pet")

p1 = Pet.New()
p2 = Pet.New()

print(p1.health)
print(p2.health)
p1.setX(1)
print(p1.health)


print("Hello world!")