import { applyInlineStyles } from "../utils/email-inline";
import { sanitize } from "../utils/sanitize-html";

export default defineEventHandler(async (event) => {
  const props = getQuery(event);

  // obtém o template através de import do arquivo compilado
  let html = (await $fetch("/email-template", {
    responseType: "text",
    method: "GET",
  })) as string;

  html = sanitize(html);
  html = (await applyInlineStyles(html)) as string;

  setHeader(event, "Content-Type", "text/html; charset=utf-8");
  return html;
});
