return {
  "nvumi",
  dir = "~/Projects/nvumi/",
  dependencies = { "folke/snacks.nvim" },
  opts = {
    virtual_text = "newline",
    prefix = " 🚀 ",
    custom_conversions = {
      {
        id = "kmh",
        phrases = "kmh, kmph, khm, kph, klicks, kilometers per hour",
        base_unit = "second",
        format = "km/h",
        ratio = 1, -- base ratio
      },
      {
        id = "mph",
        phrases = "mph, miles per hour",
        base_unit = "second",
        format = "mph",
        ratio = 1.609344, -- 1 mph equals 1.609344 km/h
      },
      {
        id = "meterspersecond",
        phrases = "mps, meters per second",
        base_unit = "second",
        format = "m/s",
        ratio = 0.27778, -- approximately, since 1 km/h ≈ 0.27778 m/s
      },
      {
        id = "feetpersecond",
        phrases = "fps, ftps, ft per sec, ft per second, feet per second",
        base_unit = "second",
        format = "ft/s",
        ratio = 0.911344, -- roughly, for example
      },
      {
        id = "knots",
        phrases = "kts, knots",
        base_unit = "second",
        format = "kt",
        ratio = 1.852, -- 1 knot = 1.852 km/h
      },
      {
        id = "liters",
        phrases = "l, liter, liters",
        base_unit = "volume", -- group for volume units
        format = "L",
        ratio = 1, -- let liter be the canonical unit for volume
      },
      {
        id = "gallons",
        phrases = "gal, gallon, gallons",
        base_unit = "volume",
        format = "gal",
        ratio = 3.78541, -- 1 gallon = 3.78541 liters
      },
    },
    custom_functions = {

      {
        def = { phrases = "factorial, fact" },
        fn = function(args)
          if #args < 1 then
            return { error = "factorial() expects 1 argument" }
          end
          local function factorial(n)
            if n > 100 then
              return math.huge
            end
            if n <= 1 then
              return 1
            end
            return n * factorial(n - 1)
          end
          return { result = factorial(math.floor(args[1])) }
        end,
      },
      {
        def = { phrases = "log" },
        fn = function(args)
          if #args < 1 or type(args[1]) ~= "number" then
            return { error = "log requires at least one numeric argument" }
          end
          local base = args[2] and args[2] or 2
          if base <= 0 or args[1] <= 0 then
            return { error = "logarithm is undefined for non-positive numbers" }
          end

          return { result = math.log(args[1]) / math.log(base) }
        end,
      },
      {
        def = { id = "vat", phrases = "vat, tax, nett" }, -- e.g. for calculating sales tax
        fn = function(values)
          local vat = values[2] and values[2] or 20 -- default 20% or use second arg as p/c amount
          return { result = (values[1] / (vat + 100)) * 100 } -- apply calculation and return
        end,
      },

      {
        def = { phrases = "pokemon, poke" },
        fn = function()
          local id = math.random(1, 151) -- Pokémon IDs go from 1 to 898 (Gen 1 - Gen 8)

          -- Make API request using curl
          local response = vim.fn.system("curl -s https://pokeapi.co/api/v2/pokemon/" .. id)

          -- Parse JSON response
          local ok, data = pcall(vim.fn.json_decode, response)
          if not ok or not data or not data.name or not data.types then
            return { error = "Failed to fetch Pokémon data" }
          end

          -- Get Pokémon name & type(s)
          local name = data.name:gsub("^%l", string.upper) -- Capitalize name
          local types = vim.tbl_map(function(t)
            return t.type.name
          end, data.types)
          local type_str = table.concat(types, ", ")

          return { result = name .. " (" .. type_str .. ")" }
        end,
      },
      {
        def = { phrases = "square, sqr" },
        fn = function(args)
          if not args[1] then
            return "?"
          end
          return { result = args[1].double * args[1].double }
        end,
      },
      {
        def = { phrases = "coinflip, flip" },
        fn = function()
          return { result = (math.random() > 0.5) and "Heads" or "Tails" }
        end,
      },
      {
        def = { id = "stddev", phrases = "stddev, sd" },
        fn = function(values)
          local function sum(arr)
            local total = 0
            for _, v in ipairs(arr) do
              total = total + v.double
            end
            return total
          end

          local function average(arr)
            return sum(arr) / #arr
          end

          local function squared_dist(a, b)
            return (a - b) ^ 2
          end

          local function variance(arr)
            local mean = average(arr)
            local total_var = 0
            for _, v in ipairs(arr) do
              total_var = total_var + squared_dist(v.double, mean)
            end
            return total_var / #arr
          end

          return { result = math.sqrt(variance(values)) }
        end,
      },
      {
        def = { id = "pc", phrases = "pc" },
        fn = function(values)
          if #values ~= 2 then
            return nil
          end
          local initial, final = values[1].double, values[2].double
          if initial == 0 then
            return nil
          end
          return { result = ((final - initial) / initial) * 100 }
        end,
      },
    },
  },
}
