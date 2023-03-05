const commentListPath = process.argv[2]

const commentList = require(`../${commentListPath}`)

const Type = {
    BOT: "Bot"
}

const {BOT} = Type

const filteredByAuthorName = commentList.filter(comment => comment.user.type === BOT)

const sortedByCreatedAt = [...filteredByAuthorName]
    .sort((left, right) => new Date(left.created_at) - new Date(right.created_at))

console.log(JSON.stringify(sortedByCreatedAt.at(-1)))
