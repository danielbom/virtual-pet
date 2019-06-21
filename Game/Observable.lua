

Observable = {}
Observable.__index = Observable

function Observable.New()
    local self = {}

    function self.register(observer, method)
        table.insert(self, {
            o = observer,
            m = method
        })
    end

    function self.deregister(observer, method)
        local n = #self
        for i = n, 1, -1 do
            if (not observer or self[i].o == observer) and (not method or self[i].m == method) then
                table.remove(self, i)
            end
        end
    end

    function self.notify(...)
        local n = #self
        for i = 1, n do
            self[i].m(self[i].o, ...)
        end
    end

    return self
end

return Observable
