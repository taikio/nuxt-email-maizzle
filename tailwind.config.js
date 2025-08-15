import tailwindConfig from "./app/theme-configuration";

module.exports = {
  ...tailwindConfig,
  content: ["./app/pages/**/*.vue", "./app/components/**/*.vue"],
};
