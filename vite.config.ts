import { defineConfig } from 'vite'
import { svelte } from '@sveltejs/vite-plugin-svelte'
import { resolve } from "path"

// https://vitejs.dev/config/
export default defineConfig({
  plugins: [svelte()],
  assetsInclude: ['**/*.fbx'],
  resolve: {
    alias: {
      $lib: resolve("./src/lib"),
      $assets: resolve("./src/assets")
    },
  },
})
