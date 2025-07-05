local M = {}

local function eval_clojure_code(code)
  local conjure_client = require("conjure.client")
  local conjure_eval = require("conjure.eval")
  
  local result = nil
  local completed = false
  
  conjure_client["with-filetype"]("clojure", function()
    conjure_eval["eval-str"]({
      origin = "scope_capture.lua",
      context = "user", 
      code = code,
      on_result = function(res)
        if res.out then
          result = res.out
        elseif res.value then
          result = res.value
        end
        completed = true
      end
    })
  end)
  
  local timeout = 5000
  local start_time = vim.loop.hrtime()
  
  while not completed and (vim.loop.hrtime() - start_time) / 1000000 < timeout do
    vim.wait(10)
  end
  
  return result
end

M.get_latest_captures = function()
  local code = [[
    (try
      (require 'sc.impl.db)
      (->> @sc.impl.db/db
        :execution-points
        vals
        (map (juxt :sc.ep/id :sc.ep/value)))
      (catch Exception e
        (str "Error: " (.getMessage e))))
  ]]
  
  local result = eval_clojure_code(code)
  return result
end

M.list_captures = function()
  local captures = M.get_latest_captures()
  if captures then
    print("Latest Scope Capture SPY events:")
    print(captures)
  else
    print("No captures found or error occurred")
  end
end

M.get_capture_by_id = function(spy_id)
  local code = string.format([[
    (try
      (require 'sc.api)
      (sc.api/spy %s)
      (catch Exception e
        (str "Error: " (.getMessage e))))
  ]], spy_id)
  
  local result = eval_clojure_code(code)
  return result
end

return M