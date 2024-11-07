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
