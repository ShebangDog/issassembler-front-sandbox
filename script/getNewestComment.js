const commentListPath = process.argv[2]

const commentList = require(`../${commentListPath}`)

const Type = {
    BOT: "Bot"
}

const {BOT} = Type

const filteredByAuthorName = commentList.filter(comment => comment.user.type === BOT)

const sortedByUpdatedAt = [...filteredByAuthorName]
    .sort((left, right) => new Date(left.updated_at) - new Date(right.updated_at))

console.log(sortedByUpdatedAt[0])
