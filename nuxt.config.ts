// https://nuxt.com/docs/api/configuration/nuxt-config
import vue from "@vitejs/plugin-vue";

export default defineNuxtConfig({
  compatibilityDate: "2025-07-15",
  devtools: { enabled: true },
  css: ["@/assets/css/tailwind.css"],
  nitro: {
    rollupConfig: {
      plugins: [vue()],
    },
  },
});
