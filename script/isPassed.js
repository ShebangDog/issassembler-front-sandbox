const arg = process.argv[2]
const json = require(arg)

const keys = ["newItems", "deletedItems", "diffItems"]

const has = (json) => (key) => !!json[key]
const jsonHas = has(json)

const hasAllKey = keys.map(jsonHas).every(Boolean)

if (!hasAllKey) throw Error("expect result of reg-cli")

const count = Object.entries(json)
    .filter(([key]) => keys.includes(key))
    .reduce((res, [_, value]) => value.length + res, 0)

const isPassed = count === 0

process.exit(isPassed ? 0 : 1)
