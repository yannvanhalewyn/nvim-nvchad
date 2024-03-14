-- Examples:
-- https://github.com/L3MON4D3/LuaSnip/blob/master/Examples/snippets.lua

return {
  s("cl", fmt("(js/console.log {})", { i(1) })),
  s("pp", fmt("(clojure.pprint/pprint {})", { i(1) })),
  s("spy", fmt("(sc.api/spy {})", { i(1) })),
  s("ds", fmt("(sc.api/defsc {})", { i(1, "spypoint") })),
  s("ls", fmt("(sc.api/letsc {} {})", { i(1, "spypoint"), i(2, "body") })),
  s("req", fmt("(require '[{} :as {}])", { i(1, "example.ns"), i(2, "alias")})),
  s("unalias", fmt("(ns-unalias *ns* '{})", { i(1, "alias") })),
  s("unmap", fmt("(ns-unmap *ns* {})", { i(1, "symbol") })),
  s("wor", t("(set! *warn-on-reflection* true)")),
  s("pnm", t("(set! *print-namespace-maps* false)")),
  s(
    "write-edn",
    fmt([[(binding [*print-namespace-maps* false]
  (clojure.pprint/pprint {} (clojure.java.io/writer "{}")))
    ]], {
        i(1, "data"),
        i(2, "data.edn"),
      }
    )
  ),
  s(
    "read-csv",
    fmt([[(with-open [rdr (io/reader (io/file {}))]
  (into [] (csv/read-csv rdr :separator \{})))
    ]], { i(1, "file"), i(2, "separator"), }
    )
  ),
  s(
    "write-csv",
    fmt([[(with-open [writer (io/writer (io/file {}))]
  (csv/write-csv writer {}))
]], { i(1, "file"), i(2, "csv-rows") }
    )
  ),
  s("ra", t("(clojure.tools.namespace.repl/refresh-all)"), {}),
  s(
    "middleware",
    fmt([[(defn wrap-{} [handler {}]
  (fn [req]
    (handler req)))
]], { i(1, "name"), i(2, "args") }
    )
  )
}
