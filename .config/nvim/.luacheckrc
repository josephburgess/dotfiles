-- Global objects
globals = {
  "vim",
  "LazyVim",
}

-- Don't report unused self arguments of methods
self = false

-- Rerun tests only if their modification time changed
cache = true

-- Don't report unused variables/values/functions
unused = false

-- Don't check global variables
ignore = {
  "113", -- Accessing undefined variable
}
