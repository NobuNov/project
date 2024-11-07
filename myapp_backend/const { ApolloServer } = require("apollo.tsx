const { ApolloServer } = require("apollo-server");

const books = {
    title: "吾輩は猫である",
    author: "夏目漱石",
}

const books = {
    title: "走れメロス",
    author: "太宰治",
}

const typeDefs = gql`
    type Book {
        title: String
        author: String
    }

    type Query {
        test: [Book]
    }
`;

const resolvers = {
    Query: {
        test: () => Books,
    },
}

const server = new ApolloServer({ typeDefs, resolvers });

server.liseten().then(({ url }) => {
    console.log(`Server ready at ${url}`);
});