-- ---------------------------------------------------------------------------
-- Extra plugins: testing, zen, language support, toys
-- ---------------------------------------------------------------------------
return {
	-- testing
	{
		"nvim-neotest/neotest",
		dependencies = { "haydenmeade/neotest-jest", "nvim-neotest/nvim-nio" },
		opts = function(_, opts)
			opts.adapters = opts.adapters or {}
			table.insert(
				opts.adapters,
				require("neotest-jest")({
					jestCommand = "npm run test -- --silent=false",
					jestConfigFile = "custom.jest.config.ts",
					cwd = function()
						return vim.fn.getcwd()
					end,
				})
			)
			opts.discovery = { enabled = false, concurrent = 1 }
			opts.running = { concurrent = true }
			opts.summary = { animated = false }
		end,
	},

	-- Zen mode
	{ "folke/zen-mode.nvim", opts = {} },

	-- Zig
	{ "ziglang/zig.vim" },

	-- typing practice
	{ "nvzone/typr", dependencies = "nvzone/volt", opts = {}, cmd = { "Typr", "TyprStats" } },

	-- vim motion training
	{ "ThePrimeagen/vim-be-good" },

	-- nvumi - my own util
	{
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
					ratio = 1,
				},
				{
					id = "mph",
					phrases = "mph, miles per hour",
					base_unit = "second",
					format = "mph",
					ratio = 1.609344,
				},
				{
					id = "meterspersecond",
					phrases = "mps, meters per second",
					base_unit = "second",
					format = "m/s",
					ratio = 0.27778,
				},
				{
					id = "feetpersecond",
					phrases = "fps, ftps, ft per sec, ft per second, feet per second",
					base_unit = "second",
					format = "ft/s",
					ratio = 0.911344,
				},
				{
					id = "knots",
					phrases = "kts, knots",
					base_unit = "second",
					format = "kt",
					ratio = 1.852,
				},
				{
					id = "liters",
					phrases = "l, liter, liters",
					base_unit = "volume",
					format = "L",
					ratio = 1,
				},
				{
					id = "gallons",
					phrases = "gal, gallon, gallons",
					base_unit = "volume",
					format = "gal",
					ratio = 3.78541,
				},
			},
			custom_functions = {
				{
					def = { phrases = "factorial, fact" },
					fn = function(args)
						if #args < 1 then
							return { error = "factorial() expects 1 argument" }
						end
						local function fact(n)
							if n > 100 then
								return math.huge
							end
							return n <= 1 and 1 or n * fact(n - 1)
						end
						return { result = fact(math.floor(args[1])) }
					end,
				},
				{
					def = { phrases = "log" },
					fn = function(args)
						if #args < 1 or type(args[1]) ~= "number" then
							return { error = "log requires at least one numeric argument" }
						end
						local base = args[2] or 2
						if base <= 0 or args[1] <= 0 then
							return { error = "logarithm undefined for non-positive numbers" }
						end
						return { result = math.log(args[1]) / math.log(base) }
					end,
				},
				{
					def = { id = "vat", phrases = "vat, tax, nett" },
					fn = function(v)
						local rate = v[2] and v[2] or 20
						return { result = (v[1] / (rate + 100)) * 100 }
					end,
				},
				{
					def = { id = "stddev", phrases = "stddev, sd" },
					fn = function(values)
						local function avg(t)
							local s = 0
							for _, v in ipairs(t) do
								s = s + v.double
							end
							return s / #t
						end
						local mean = avg(values)
						local var = 0
						for _, v in ipairs(values) do
							var = var + (v.double - mean) ^ 2
						end
						return { result = math.sqrt(var / #values) }
					end,
				},
				{
					def = { id = "pc", phrases = "pc" },
					fn = function(v)
						if #v ~= 2 or v[1].double == 0 then
							return nil
						end
						return { result = ((v[2].double - v[1].double) / v[1].double) * 100 }
					end,
				},
				{
					def = { phrases = "coinflip, flip" },
					fn = function()
						return { result = (math.random() > 0.5) and "Heads" or "Tails" }
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
			},
		},
	},
}
