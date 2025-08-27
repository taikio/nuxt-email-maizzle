import { render } from "@vue-email/render";
import { applyInlineStyles } from "../utils/email-inline";
import { sanitize } from "../utils/sanitize-html";
import EmailTemplate from "@/pages/email-template.vue";

export default defineEventHandler(async (event) => {
  const props = getQuery(event);

  // obtém o template através de import do arquivo compilado
  // let html = (await $fetch("/email-template", {
  //   responseType: "text",
  //   method: "GET",
  // })) as string;

  let html = await render(EmailTemplate, {
    name: props.nome as string,
  });

  html = sanitize(html);
  html = (await applyInlineStyles(html)) as string;

  setHeader(event, "Content-Type", "text/html; charset=utf-8");
  return html;
});
