const arg = process.argv[2]

const json = require(arg)

const keys = ["newItems", "deletedItems", "passedItems", "diffItems"]

const has = (json) => (key) => !!json[key]
const jsonHas = has(json)

const hasAllKey = keys.map(jsonHas).every(Boolean)

if (!hasAllKey) throw Error("expect result of reg-cli")

const count = Object.entries(json)
    .filter(([key]) => keys.includes(key))
    .reduce((res, [key, value]) => ({ ...res, [key]: value.length }), {})

const convertToIcon = (itemName) => {
    switch (itemName) {
        case "newItems":
            return "⚪"
        case "deletedItems":
            return "⚫"
        case "passedItems":
            return "🔵"
        case "diffItems":
            return "🔴"
        default:
            throw new Error("unknown item name")
    }
}

const message = Object.entries(count)
    .map(([key, value]) => `${key} ${convertToIcon(key)}  : ${value}`)
    .join("\n")

console.log(message)
