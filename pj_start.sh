#このシェルを使用する前に
#mkdirで開発ディレクトリを作成してください
#作成したらcd でそのディレクトリに入りnode_containerという
#別のシェルをWSLから流し開発コンテナ立ち上げてからこちらを使用

#!/bin/bash
PJ_DIR=$(pwd)
read -p "Enter your project name: " PJ_NAME

sudo chown -R $(whoami) $PJ_DIR
npm create vite@latest "frontend_${PJ_NAME}" -- --template react-ts -y
cd "front_${PJ_NAME}end"
npm install

#vite.config.tsのにcompilerOptionの追加とポートの割り振り
cat <<EOL > vite.config.ts
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react()],
  server: {
    host: true,
    port: 3000, // 好きなポート番号に設定してください
  },
  resolve: {
    alias: {
      '@styles': '/src/styles',
    },
  },
})
EOL

#Tailwind依存関係追加
npm install tailwindcss-animate class-variance-authority clsx tailwind-merge
npm install lucide-react
npm install @radix-ui/react-icons


#tsconfig.jsonにコンパイラオプションを記述
cat <<EOL > tsconfig.json

{
  "files": [],
  "references": [
    { "path": "./tsconfig.app.json" },
    { "path": "./tsconfig.node.json" }
  ],
  "compilerOptions": {
    "baseUrl": ".",
    "paths": {
      "@/*": ["./*"]
    }
  }
}
EOL

#tailwind.config.js の作成
npx tailwindcss init
cat <<EOL > tailwind.config.js

const { fontFamily } = require("tailwindcss/defaultTheme")

/** @type {import('tailwindcss').Config} */
module.exports = {
  darkMode: ["class"],
  content: ["app/**/*.{ts,tsx}", "components/**/*.{ts,tsx}"],
  theme: {
    container: {
      center: true,
      padding: "2rem",
      screens: {
        "2xl": "1400px",
      },
    },
    extend: {
      colors: {
        border: "hsl(var(--border))",
        input: "hsl(var(--input))",
        ring: "hsl(var(--ring))",
        background: "hsl(var(--background))",
        foreground: "hsl(var(--foreground))",
        primary: {
          DEFAULT: "hsl(var(--primary))",
          foreground: "hsl(var(--primary-foreground))",
        },
        secondary: {
          DEFAULT: "hsl(var(--secondary))",
          foreground: "hsl(var(--secondary-foreground))",
        },
        destructive: {
          DEFAULT: "hsl(var(--destructive))",
          foreground: "hsl(var(--destructive-foreground))",
        },
        muted: {
          DEFAULT: "hsl(var(--muted))",
          foreground: "hsl(var(--muted-foreground))",
        },
        accent: {
          DEFAULT: "hsl(var(--accent))",
          foreground: "hsl(var(--accent-foreground))",
        },
        popover: {
          DEFAULT: "hsl(var(--popover))",
          foreground: "hsl(var(--popover-foreground))",
        },
        card: {
          DEFAULT: "hsl(var(--card))",
          foreground: "hsl(var(--card-foreground))",
        },
      },
      borderRadius: {
        lg: \`var(--radius)\`,
        md: \`calc(var(--radius) - 2px)\`,
        sm: "calc(var(--radius) - 4px)",
      },
      fontFamily: {
        sans: ["var(--font-sans)", ...fontFamily.sans],
      },
      keyframes: {
        "accordion-down": {
          from: { height: "0" },
          to: { height: "var(--radix-accordion-content-height)" },
        },
        "accordion-up": {
          from: { height: "var(--radix-accordion-content-height)" },
          to: { height: "0" },
        },
      },
      animation: {
        "accordion-down": "accordion-down 0.2s ease-out",
        "accordion-up": "accordion-up 0.2s ease-out",
      },
    },
  },
  plugins: [require("tailwindcss-animate")],
}
EOL

#stylesディレクトリとglobals.cssの追加
mkdir -p src/styles
cat <<EOL > src/styles/globals.css
@tailwind base;
@tailwind components;
@tailwind utilities;

@layer base {
  :root {
    --background: 0 0% 100%;
    --foreground: 222.2 47.4% 11.2%;

    --muted: 210 40% 96.1%;
    --muted-foreground: 215.4 16.3% 46.9%;

    --popover: 0 0% 100%;
    --popover-foreground: 222.2 47.4% 11.2%;

    --border: 214.3 31.8% 91.4%;
    --input: 214.3 31.8% 91.4%;

    --card: 0 0% 100%;
    --card-foreground: 222.2 47.4% 11.2%;

    --primary: 222.2 47.4% 11.2%;
    --primary-foreground: 210 40% 98%;

    --secondary: 210 40% 96.1%;
    --secondary-foreground: 222.2 47.4% 11.2%;

    --accent: 210 40% 96.1%;
    --accent-foreground: 222.2 47.4% 11.2%;

    --destructive: 0 100% 50%;
    --destructive-foreground: 210 40% 98%;

    --ring: 215 20.2% 65.1%;

    --radius: 0.5rem;
  }

  .dark {
    --background: 224 71% 4%;
    --foreground: 213 31% 91%;

    --muted: 223 47% 11%;
    --muted-foreground: 215.4 16.3% 56.9%;

    --accent: 216 34% 17%;
    --accent-foreground: 210 40% 98%;

    --popover: 224 71% 4%;
    --popover-foreground: 215 20.2% 65.1%;

    --border: 216 34% 17%;
    --input: 216 34% 17%;

    --card: 224 71% 4%;
    --card-foreground: 213 31% 91%;

    --primary: 210 40% 98%;
    --primary-foreground: 222.2 47.4% 1.2%;

    --secondary: 222.2 47.4% 11.2%;
    --secondary-foreground: 210 40% 98%;

    --destructive: 0 63% 31%;
    --destructive-foreground: 210 40% 98%;

    --ring: 216 34% 17%;

    --radius: 0.5rem;
  }
}

@layer base {
  * {
    @apply border-border;
  }
  body {
    @apply bg-background text-foreground;
    font-feature-settings: "rlig" 1, "calt" 1;
  }
}
EOL

#main.tsxにglobasl.cssのimport
if ! grep -q 'import "./styles/globals.css";' src/main.tsx; then
  sed -i '' '5 a\
import "./styles/globals.css";
' src/main.tsx
fi

#Tailwind CSS クラスを条件付きで簡単に追加できるようにutils.ts作成
mkdir -p lib
cat <<EOL > lib/utils.ts
import { clsx, type ClassValue } from "clsx"
import { twMerge } from "tailwind-merge"

export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs))
}
EOL

npm i axios @apollo/client @apollo/react-hooks apollo-boost graphql

# #server 立ち上げるか聞く
# read -p "設定が終わりました。サーバー起動しますか? (y/n) " START
# if [ "$START" == "y" ]; then
#     npm run dev
# else
#     echo "server is standby..."
# fi


cd $PJ_DIR
mkdir "backend_${PJ_NAME}"
cd "backend_${PJ_NAME}"
npm init -y
npm i graphql apollo-server -D

cat <<EOL > package.json
{
  "name": "mypro_backend",
  "version": "1.0.0",
  "main": "server.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1",
    "dev" : "node server.js"
  },
  "keywords": [],
  "author": "",
  "license": "ISC",
  "description": "",
  "devDependencies": {
    "apollo-server": "^3.13.0",
    "graphql": "^16.9.0"
  }
}
EOL

cat <<EOL > server.js
const { ApolloServer } = require("apollo-server");

const books = [
    {
        title: "吾輩は猫である",
        author: "夏目漱石",
    },
    {
        title: "走れメロス",
        author: "太宰治",
    }
];

const typeDefs = gql\`
    type Book {
        title: String
        author: String
    }

    type Query {
        test: [Book]
    }
\`;

const resolvers = {
    Query: {
        test: () => books,
    },
};

const server = new ApolloServer({ typeDefs, resolvers });

server.listen().then(({ url }) => {
    console.log(\`Server ready at \${url}\`);
});
EOL

mv -r /workspaces/project_x/frontend_${PJ_NAME}/backend_${PJ_NAME} /workspaces/project_x/backend_${PJ_NAME}