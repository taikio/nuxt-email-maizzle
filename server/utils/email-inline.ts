import { render } from "@maizzle/framework";
import { load } from "cheerio";
// import tailwindcssPresetEmail from "tailwindcss-preset-email";
// import tailwindConfig from "../../tailwind.config.json";
import tailwindConfig from "@/theme-configuration";

export const applyInlineStyles = async (input: string) => {
  const $ = load(input, { decodeEntities: false });

  $("head").append("<style>@tailwind components; @tailwind utilities;</style>");
  // console.log("-- html 1 --");
  // console.log();

  const { html } = await render($.html(), {
    css: {
      inline: { attributeToStyle: true },
      purge: { removeCSSComments: true, removeHTMLComments: true },
      shorthand: true,
      tailwind: {
        ...tailwindConfig,

        content: [{ raw: input, extension: "html" }],
      },
    },
  });

  return html;
};
