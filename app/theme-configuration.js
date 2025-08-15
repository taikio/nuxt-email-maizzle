/** @type {import('tailwindcss').Config} */
import tailwindcssPresetEmail from "tailwindcss-preset-email";

export default {
  content: [],
  presets: [tailwindcssPresetEmail],
  theme: {
    extend: {
      colors: {
        "off-white": "#fafafa",
      },
    },
  },
};
