type table__DARKLUA_TYPE_a = {[any]: any}
type FormatExtra__DARKLUA_TYPE_b = {NoVariables: boolean?, Indent: number?}
type table__DARKLUA_TYPE_c = {[any]: any}
type ParseTableIntoStringData__DARKLUA_TYPE_d = {Table: table__DARKLUA_TYPE_c, Indent: number?, NoBrackets: boolean?, NoVariables: boolean?}
type MakePathStringData__DARKLUA_TYPE_e = {Object: Instance, Parents: table__DARKLUA_TYPE_c?, NoVariables: boolean?}
type VariableData__DARKLUA_TYPE_f = {Name: string, Value: any, Order: number, Lookup: any?, Class: string?, Comment: string?}
type Table__DARKLUA_TYPE_g = {[any]: any}
type VariablesDict__DARKLUA_TYPE_h = {[any]: VariableData__DARKLUA_TYPE_f}
type ClassDict__DARKLUA_TYPE_i = {VariableCount: number, Variables: VariablesDict__DARKLUA_TYPE_h}
type Module__DARKLUA_TYPE_j = {VariablesDict: Table__DARKLUA_TYPE_g, VariableLookup: Table__DARKLUA_TYPE_g, InstanceQueue: Table__DARKLUA_TYPE_g, NoNameCount: number, VariableBase: string}

local a = {
    cache = {}::any,
}

do
    do
        local function __modImpl()
            local b = {}

            b.__index = b

            local c = TweenInfo.new()
            local d = workspace.GetServerTimeNow

            b.ClassNameStrings = {
                DataModel = 'game',
                Workspace = 'workspace',
                Stats = 'stats()',
                GlobalSettings = 'settings()',
                PluginManagerInterface = 'PluginManager()',
                UserSettings = 'UserSettings()',
                DebuggerManager = 'DebuggerManager()',
            }
            b.Formats = {
                CFrame = function(e, f)
                    local g = e:FormatVectorValues(f, false, true)

                    return `CFrame.new({g})`
                end,
                Vector3 = function(e, f)
                    local g = e:FormatVectorValues(f)

                    return `Vector3.new({g})`
                end,
                Vector2 = function(e, f)
                    local g = e:FormatVectorValues(f, true)

                    return `Vector2.new({g})`
                end,
                Vector2int16 = function(e, f)
                    local g = e:FormatVectorValues(f, true)

                    return `Vector2int16.new({g})`
                end,
                Vector3int16 = function(e, f)
                    local g = e:FormatVectorValues(f)

                    return `Vector3int16.new({g})`
                end,
                Color3 = function(e, f)
                    return `Color3.fromRGB({f.R * 255}, {f.G * 255}, {f.B * 255})`
                end,
                NumberRange = function(e, f)
                    local g = e:Format(f.Min)
                    local h = e:Format(f.Max)

                    return `NumberRange.new({g}, {h})`
                end,
                NumberSequenceKeypoint = function(e, f)
                    return `NumberSequenceKeypoint.new({f.Time}, {f.Value}, {f.Envelope})`
                end,
                ColorSequenceKeypoint = function(e, f)
                    return `ColorSequenceKeypoint.new({f.Time}, {f.Value})`
                end,
                PathWaypoint = function(e, f)
                    local g = e:Format(f.Position)
                    local h = `Enum.PathWaypointAction.{f.Action.Name}`

                    return `PathWaypoint.new({g}, {h}, "{f.Label}")`
                end,
                PhysicalProperties = function(e, f)
                    return `PhysicalProperties.new("{f.Density}, {f.Friction}, {f.Elasticity}, {f.FrictionWeight}, {f.ElasticityWeight}`
                end,
                Ray = function(e, f)
                    local g = e:Format(f.Origin)
                    local h = e:Format(f.Direction)

                    return `Ray.new({g}, {h})`
                end,
                UDim2 = function(e, f)
                    return `UDim2.new({f.X.Scale},{f.X.Offset},{f.Y.Scale},{f.Y.Offset})`
                end,
                UDim = function(e, f)
                    return `UDim2.new({f.Scale},{f.Offset})`
                end,
                BrickColor = function(e, f)
                    return `BrickColor.new("{f.Name}")`
                end,
                buffer = function(e, f)
                    local g = buffer.tostring(f)

                    g = e:Format(g)

                    return `buffer.fromstring({g}) --[[{f}]]`
                end,
                DateTime = function(e, f)
                    return `DateTime.fromUnixTimestampMillis({f.UnixTimestampMillis})`
                end,
                Font = function(e, f)
                    local g = e:Format(f.Family)

                    return `Font.new({g}, {f.Weight}, {f.Style.Name})`
                end,
                Enum = `%*`,
                string = function(e, f)
                    local g = e:MakePrintable(f)
                    local h = `"%*"`
                    local i = g:find'%[%[=*[[]'
                    local j = g:find'[\n\r]'

                    if not i and j then
                        h = '[[%*]]'
                    end

                    return h:format(g)
                end,
                number = `%*`,
                TweenInfo = function(e, f)
                    local g = `Enum.EasingStyle.{f.EasingStyle.Name}`
                    local h = `Enum.EasingDirection.{f.EasingDirection.Name}`
                    local i = f.EasingStyle == c.EasingStyle
                    local j = f.EasingDirection == c.EasingDirection
                    local k = math.round(f.Time * 100) / 100

                    if i and j then
                        return `TweenInfo.new({k})`
                    end

                    return `TweenInfo.new({k}, {g}, {h})`
                end,
                boolean = `%*`,
                Instance = function(e, f: Instance)
                    local g, h = e.Parser:MakePathString{Object = f}

                    return g, h > 2
                end,
                ['function'] = function(e, f)
                    local g = debug.info(f, 'n')
                    local h = ''

                    if #g <= 0 then
                        h = `{f}`
                    else
                        h = `function {g}`
                    end

                    return `function() end --[[{h}]]`
                end,
                table = function(e, f, g)
                    local h = g.Indent or 0
                    local i = e.Parser:ParseTableIntoString{
                        NoBrackets = false,
                        Indent = h + 1,
                        Table = f,
                    }

                    return i
                end,
                RBXScriptSignal = function(e, f, g)
                    local h = tostring(f):match' (%a+)'

                    return `nil --[[Signal: {h}]]`
                end,
            }

            function b.IsPrintable(e, f: string, g: boolean)
                if g then
                    return f:match'[%g ]'
                end

                return f:match'[\n\r%g ]'
            end
            function b.MakePrintable(e, f: string, g: boolean): string
                local h = f:gsub('"', '\\"')

                return h:gsub('.', function(i: string)
                    if g then
                        i = i:gsub('\n', '\\n')
                        i = i:gsub('\r', '\\r')
                    end
                    if e:IsPrintable(i, g) then
                        return i
                    end

                    return `\\{i:byte()}`
                end)
            end
            function b.FormatVectorValues(e, f, ...): string
                local g = {
                    e:RoundVector(f, ...),
                }

                return table.concat(g, ', ')
            end
            function b.RoundValues(e, f: table__DARKLUA_TYPE_a): table__DARKLUA_TYPE_a
                local g = {}

                for h, i in next, f do
                    local j = math.round(i)

                    table.insert(g, j)
                end

                return g
            end
            function b.RoundVector(e, f, g: boolean?, h: boolean?): (number,number,number?)
                local i, j, k = f.X, f.Y, not g and f.Z or 0

                if h then
                    local l = {
                        f:GetComponents(),
                    }

                    return unpack(e:RoundValues(l))
                end

                return math.round(i), math.round(j), not g and math.round(k) or nil
            end
            function b.GetServerTimeNow(e): number
                return d(workspace)
            end
            function b.MakeReplacements(e, f: number): table__DARKLUA_TYPE_a
                local g = tick() - (f or tick())
                local h = math.round(e:GetServerTimeNow() - g)
                local i = math.round(workspace.DistributedGameTime - g)
                local j = {}

                local function AddReplacement(k, l)
                    if typeof(k) == 'number' then
                        j[-k] = `-{l}`
                    end

                    j[k] = l
                end

                AddReplacement(Vector2.one, 'Vector2.one')
                AddReplacement(Vector2.zero, 'Vector2.zero')
                AddReplacement(Vector3.one, 'Vector3.one')
                AddReplacement(Vector3.zero, 'Vector3.zero')
                AddReplacement(math.huge, 'math.huge')
                AddReplacement(math.pi, 'math.pi')
                AddReplacement(workspace.Gravity, 'workspace.Gravity')
                AddReplacement(workspace.AirDensity, 'workspace.AirDensity')
                AddReplacement(workspace.CurrentCamera.CFrame, 'workspace.CurrentCamera.CFrame')
                AddReplacement(i, 'workspace.DistributedGameTime')
                AddReplacement(h, 'workspace:GetServerTimeNow()')

                return j
            end
            function b.SetValueSwaps(e, f: table__DARKLUA_TYPE_a)
                e.ValueSwaps = f
            end
            function b.FindStringIntSwap(e, f: string)
                local g = tonumber(f)

                if not g then
                    return
                end

                local h = e:FindValueSwap(g)

                return h
            end
            function b.FindValueSwap(e, f)
                local g = e.ValueSwaps
                local h = g[f]

                if h then
                    return h
                end
                if typeof(f) == 'string' then
                    local i = e:FindStringIntSwap(f)

                    if i then
                        return `tostring({i})`
                    end
                end

                local i = typeof(f) == 'number'

                if not i then
                    return
                end

                local j = math.round(f)

                return g[j]
            end
            function b.NeedsBrackets(e, f: string)
                if not f then
                    return
                end
                if typeof(f) ~= 'string' then
                    return true
                end

                return not f:match'^[%a_][%w_]*$'
            end
            function b.MakeName(e, f): string?
                local g = e:ObjectToString(f)

                g = g:gsub('[./ #%@$%\u{a3}+-()\n\r]', '')
                g = e:MakePrintable(g, true)

                if e:NeedsBrackets(g) then
                    return
                end
                if #g < 1 or #g > 30 then
                    return
                end

                return g
            end
            function b.new(e: table__DARKLUA_TYPE_a): table__DARKLUA_TYPE_a
                local f = {}
                local g = setmetatable(f, b)

                g.ValueSwaps = g:MakeReplacements()

                return g
            end
            function b.Format(e, f, g)
                local h = e.Formats
                local i = e.Variables

                g = g or {}

                local j = e.NoVariables or g.NoVariables
                local k = e:FindValueSwap(f)

                if k then
                    return k
                end

                local l = typeof(f)
                local m = h[l]
                local n

                if typeof(f) == 'Instance' then
                    n = e:MakeName(f)
                end
                if typeof(m) == 'function' then
                    local o, p = m(e, f, g)

                    if p and not j then
                        o = i:MakeVariable{
                            Name = n,
                            Lookup = f,
                            Value = o,
                        }
                    end

                    return o
                end
                if not m then
                    return `{f} --[[{l} not supported]]`
                end

                return m:format(f)
            end
            function b.ObjectToString(e, f: Instance): string
                local g = e.Swaps
                local h = e.IndexFunc
                local i = e.ClassNameStrings
                local j = h(f, 'Name')
                local k = h(f, 'ClassName')
                local l = i[k]
                local m = l or j

                m = e:MakePrintable(m, true)

                if g then
                    local n = g[f]

                    if n then
                        m = n.String
                    end
                end

                return m
            end

            return b
        end

        function a.a(): typeof(__modImpl())
            local b = a.cache.a

            if not b then
                b = {
                    c = __modImpl(),
                }
                a.cache.a = b
            end

            return b.c
        end
    end
    do
        local function __modImpl()
            local b = {}

            b.__index = b

            function GetDictSize(c: table__DARKLUA_TYPE_c): number
                local d = 0

                for e in next, c do
                    d += 1
                end

                return d
            end
            function b.new(c)
                local d = {}

                return setmetatable(d, b)
            end
            function b.FormatTableKey(c, d): string?
                local e = c.Formatter

                if typeof(d) ~= 'string' then
                    return
                end

                local f = e:NeedsBrackets(d)

                if f then
                    return
                end

                return `{d} = `
            end
            function b.ParseTableIntoString(c, d: ParseTableIntoStringData__DARKLUA_TYPE_d): (string,number,boolean)
                local e = c.Formatter
                local f = d.Indent or 0
                local g = d.Table
                local h = d.NoBrackets
                local i = GetDictSize(g)
                local j = true

                if i == 0 then
                    return h and '' or '{}', i, true
                end

                local k = string.rep('\t', f)
                local l = `{not h and '{' or ''}\n`
                local m = 0

                for n, o in next, g do
                    m += 1

                    local p = e:Format(o, d)
                    local q = n == m
                    local r = ''
                    local s = ''

                    if typeof(n) ~= 'number' or not q then
                        s = c:FormatTableKey(n)
                        j = false

                        if not s then
                            local t = e:Format(n, d)

                            s = `[{t}] = `
                        end
                    end
                    if m < i then
                        r = ','
                    end

                    l ..= `{k}\t{s}{p}{r}\n`
                end

                l ..= `{k}{not h and '}' or ''}`

                return l, i, j
            end
            function b.MakeVariableCodeLine(c, d: table__DARKLUA_TYPE_c): string
                local e = d.Name
                local f = d.Value
                local g = d.Comment
                local h = `local {e} = {f}`
                local i = g and ` -- {g}` or ''

                return `{h}{i}`
            end
            function b.MakeVariableCodeLines(c, d: table__DARKLUA_TYPE_c): string
                local e = c.Variables
                local f = d.Variables
                local g = e:OrderVariables(f)
                local h = ''

                for i, j in g do
                    local k = c:MakeVariableCodeLine(j)

                    h ..= `{k}\n`
                end

                return h
            end
            function b.MakeVariableCode(c, d: table__DARKLUA_TYPE_c, e: boolean?): string
                local f = c.Variables
                local g = f.VariablesDict
                local h = ''
                local i = 0

                for j, k in next, d do
                    local l = g[k]

                    if not l then
                        continue
                    end

                    i += 1
                    h ..= i > 1 and '\n' or ''
                    h ..= e and '' or `-- {k}\n`
                    h ..= c:MakeVariableCodeLines(l)
                end

                return h
            end
            function b.MakePathString(c, d: table__DARKLUA_TYPE_c): (string,number)
                local e = c.Variables
                local f = c.Formatter
                local g = d.Object
                local h = d.Parents
                local i = c.NoVariables or d.NoVariables
                local j = ''
                local k = 0

                h = h or e:MakeParentsTable(g, i)

                local function ServiceCheck(l: Instance, m: string): boolean?
                    local n = e:IsService(l)

                    if not n then
                        return
                    end

                    local o = `game:GetService("{n}")`

                    if i then
                        j = o

                        return true
                    end

                    local p = e:MakeVariable{
                        Name = n,
                        Class = 'Services',
                        Value = o,
                    }

                    j = p

                    return true
                end

                for l, m in next, h do
                    local n = f:ObjectToString(m)
                    local o = e:GetVariable(m)

                    if o and not i then
                        n = o.Name
                    end
                    if l == 2 and h[1] == game then
                        if ServiceCheck(m, n) then
                            continue
                        end
                    end

                    local p = f:NeedsBrackets(n)
                    local q = l > 1 and '.' or ''

                    k += 1
                    j ..= p and `["{n}"]` or `{q}{n}`
                end

                return j, k
            end

            return b
        end

        function a.b(): typeof(__modImpl())
            local b = a.cache.b

            if not b then
                b = {
                    c = __modImpl(),
                }
                a.cache.b = b
            end

            return b.c
        end
    end
    do
        local function __modImpl()
            local b = {
                VariableBase = 'Jit',
            }

            b.__index = b

            local c = getfenv(1)
            local d = {
                Instance = function(d, e: Table__DARKLUA_TYPE_g)
                    local f = d.Parser
                    local g = d.Formatter
                    local h = d:BulkCollectParents(e)
                    local i = d:FindDuplicates(h)

                    for j, k: Instance in next, i do
                        local l, m = f:MakePathString{Object = k}

                        if m < 3 then
                            continue
                        end

                        local n = g:MakeName(k)

                        d:MakeVariable{
                            Lookup = k,
                            Name = n,
                            Value = l,
                        }
                    end
                end,
            }

            local function MultiInsert(e: Table__DARKLUA_TYPE_g, f: Table__DARKLUA_TYPE_g)
                for g, h in next, f do
                    table.insert(e, h)
                end
            end

            function b.new(e)
                local f = {
                    VariablesDict = {},
                    VariableLookup = {},
                    InstanceQueue = {},
                    VariableNames = {},
                    NoNameCount = 0,
                }

                return setmetatable(f, b)
            end
            function b.GetNoNameCount(e): number
                return e.NoNameCount
            end
            function b.AddVariableToClass(e, f: ClassDict__DARKLUA_TYPE_i, g: VariableData__DARKLUA_TYPE_f)
                local h = g.Value
                local i = g.Lookup or h

                f.VariableCount += 1

                local j = f.VariableCount
                local k = f.Variables

                g.Order = j
                k[i] = g
            end
            function b.GetClassDict(e, f: string): ClassDict__DARKLUA_TYPE_i
                local g = e.VariablesDict
                local h = g[f]

                if h then
                    return h
                end

                h = {
                    VariableCount = 0,
                    Variables = {},
                }
                g[f] = h

                return h
            end
            function b.IsGlobal(e, f: (string | Instance)): (string | boolean)
                local g = e.IndexFunc

                if typeof(f) == 'Instance' then
                    local h = g(f, 'Name')

                    return c[h] == f
                end

                return c[f] and f or false
            end
            function b.IsService(e, f: Instance): (string | boolean)
                local g = e.IndexFunc
                local h = g(f, 'ClassName')
                local i = pcall(function()
                    return game:GetService(h)
                end)

                return i and h or false
            end
            function b.IncreaseNameUseCount(e, f: string): number
                if not f then
                    return 0
                end

                local g = e.VariableNames
                local h = g[f]

                if not h then
                    h = 0
                    g[f] = h
                end

                g[f] += 1

                return h
            end
            function b.IncreaseNoNameCount(e): number
                e.NoNameCount += 1

                return e.NoNameCount
            end
            function b.CheckName(e, f): string
                local g = f.Name
                local h = e:IncreaseNameUseCount(g)

                if g then
                    if h <= 0 then
                        return g
                    else
                        return `{g}{h}`
                    end
                end

                local i = e:IncreaseNoNameCount()
                local j = e.VariableBase

                return j:format(i)
            end
            function b.GetVariable(e, f): VariableData__DARKLUA_TYPE_f?
                local g = e.VariableLookup

                return g[f]
            end
            function b.OrderVariables(e, f: VariablesDict__DARKLUA_TYPE_h): Table__DARKLUA_TYPE_g
                local g = {}

                for h, i in next, f do
                    local j = i.Order

                    table.insert(g, j, i)
                end

                return g
            end
            function b.MakeVariable(e, f: VariableData__DARKLUA_TYPE_f): string
                local g = e.VariableLookup
                local h = e.InstanceQueue
                local i = f.Value
                local j = f.Lookup or i
                local k = f.Class or 'Variables'
                local l = e:GetVariable(j)

                if l then
                    return l.Name
                end

                local m = e:IsGlobal(i)

                if m then
                    return m
                end
                if not f.Name and typeof(i) == 'Instance' then
                    h[i] = f
                end

                local n = e:CheckName(f)

                f.Name = n

                local o = e:GetClassDict(k)

                e:AddVariableToClass(o, f)

                g[j] = f

                return n
            end
            function b.CollectTableItems(e, f: Table__DARKLUA_TYPE_g, g: (Value:any) -> nil)
                local function Process(h)
                    local i = typeof(h)

                    if i == 'table' then
                        e:CollectTableItems(h, g)

                        return
                    end

                    g(h)
                end

                for h, i in next, f do
                    Process(h)
                    Process(i)
                end
            end
            function b.FindDuplicates(e, f: Table__DARKLUA_TYPE_g): Table__DARKLUA_TYPE_g
                local g = {}
                local h = {}

                for i, j in next, f do
                    local k = h[j]

                    if k == 1 then
                        h[j] = 2

                        table.insert(g, j)

                        continue
                    end

                    h[j] = 1
                end

                table.clear(h)

                return g
            end
            function b.CollectTableTypes(e, f: Table__DARKLUA_TYPE_g, g: Table__DARKLUA_TYPE_g): Table__DARKLUA_TYPE_g
                local h = {}

                local function Process(i)
                    local j = typeof(i)

                    if not table.find(g, j) then
                        return
                    end

                    local k = h[j]

                    if not k then
                        k = {}
                        h[j] = k
                    end

                    table.insert(k, i)
                end

                e:CollectTableItems(f, Process)

                return h
            end
            function b.MakeParentsTable(e, f: Instance, g: boolean?): Table__DARKLUA_TYPE_g
                local h = e.IndexFunc
                local i = e.Swaps
                local j = e.Variables

                g = e.NoVariables or g

                local k = {}
                local l = f::Instance?

                while true do
                    local m = l

                    l = h(l, 'Parent')

                    if l == game and e:IsGlobal(m) then
                        l = nil
                    end
                    if i then
                        local n = i[m]

                        if n and n.NextParent then
                            l = n.NextParent
                        end
                    end

                    local n = j:GetVariable(m)

                    if not g and n and l then
                        l = nil
                    end

                    table.insert(k, 1, m)

                    if not l then
                        break
                    end
                end

                return k
            end
            function b.BulkCollectParents(e, f: Table__DARKLUA_TYPE_g): (Table__DARKLUA_TYPE_g,Table__DARKLUA_TYPE_g)
                local g = {}
                local h = {}

                for i, j in next, f do
                    if typeof(j) ~= 'Instance' then
                        continue
                    end

                    local k = e:MakeParentsTable(j)

                    MultiInsert(g, k)

                    h[j] = k
                end

                return g, h
            end
            function b.PrerenderVariables(e, f: Table__DARKLUA_TYPE_g, g: Table__DARKLUA_TYPE_g)
                if e.NoVariables then
                    return
                end

                local h = e:CollectTableTypes(f, g)

                for i, j in next, h do
                    local k = d[i]

                    if k then
                        k(e, j)
                    end
                end
            end

            return b
        end

        function a.c(): typeof(__modImpl())
            local b = a.cache.c

            if not b then
                b = {
                    c = __modImpl(),
                }
                a.cache.c = b
            end

            return b.c
        end
    end
end

type Table = {[any]: any}

local b = {
    Version = '1.0.8',
    Author = 'Depso',
    License = 'GNU-GPLv3',
    Repository = 'https://github.com/sobakadep/Roblox-parser',
    ImportUrl = 
[[https://raw.githubusercontent.com/sobakadep/Roblox-parser/refs/heads/main]],
    Modules = {
        Formatter = a.a(),
        Parser = a.b(),
        Variables = a.c(),
    },
}

local function MergeDict(c: Table, d: Table)
    for e, f in next, d do
        c[e] = f
    end
end

function b.New(c, d: Table): Table
    local e = c.Modules
    local f = {
        Variables = e.Variables.new(),
        Formatter = e.Formatter.new(),
        Parser = e.Parser.new(),
    }

    if d then
        MergeDict(f, d)
    end

    for g, h in next, f do
        if typeof(h) ~= 'table' then
            continue
        end
        if h.new then
            MergeDict(h, f)
        end
    end

    return f
end

return b
