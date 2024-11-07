#!/bin/bash
PJ_DIR=$(pwd)
read -p "Enter your project name: " PJ_NAME

sudo chown -R $(whoami) $PJ_DIR
npm create vite@latest "frontend_${PJ_NAME}" -- --template react-ts
cd "frontend_${PJ_NAME}"
npm install

#vite.config.tsの作成
cat <<EOL > vite.config.ts
import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [react()],
  server: {
    host: true,
    port: 3000, 
  },
  resolve: {
    alias: {
      '@styles': '/src/styles',
    },
  },
})
EOL

# Tailwind依存関係の追加
npm install tailwindcss-animate class-variance-authority clsx tailwind-merge
npm install lucide-react
npm install @radix-ui/react-icons

# tsconfig.jsonの作成
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

# postcss.config.cjsの作成
cat <<EOL > postcss.config.cjs
module.exports = {
  plugins: {
    tailwindcss: {},
    autoprefixer: {},
  }
};
EOL

# Tailwindの設定ファイル作成
npx tailwindcss init
cat <<EOL > tailwind.config.js
const { fontFamily } = require("tailwindcss/defaultTheme")

/** @type {import('tailwindcss').Config} */
module.exports = {
  darkMode: ["class"],
  content: [
    "./index.html",
    "./src/**/*.{js,ts,jsx,tsx}",
    "app/**/*.{ts,tsx}",
    "components/**/*.{ts,tsx}"
  ],
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

# stylesディレクトリとglobals.css作成
mkdir -p src/styles
cat <<EOL > src/styles/globals.css
@tailwind base;
@tailwind components;
@tailwind utilities;

@layer base {
  :root {
    --background: 0 0% 100%;
    --foreground: 222.2 47.4% 11.2%;
    --primary: 222.2 47.4% 11.2%;
    --primary-foreground: 210 40% 98%;
  }
}

@layer base {
  body {
    @apply bg-background text-foreground;
  }
}
EOL

# main.tsxにCSSインポート
if ! grep -q 'import "./styles/globals.css";' src/main.tsx; then
  sed -i '' '5 a\
import "./styles/globals.css";
' src/main.tsx
fi

# フロントエンドのセットアップ終了
echo "フロントエンドのセットアップが完了しました。"

# backendディレクトリの作成
cd $PJ_DIR
mkdir "backend_${PJ_NAME}"
cd "backend_${PJ_NAME}"
npm init -y
npm i graphql apollo-server -D

cat <<EOL > server.js
const { ApolloServer, gql } = require("apollo-server");

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

# バックエンドのセットアップ終了
echo "バックエンドのセットアップが完了しました。"