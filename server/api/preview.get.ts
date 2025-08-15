import { applyInlineStyles } from "../utils/email-inline";
import { sanitize } from "../utils/sanitize-html";

export default defineEventHandler(async (event) => {
  setHeader(event, "Content-Type", "text/html; charset=utf-8");

  const props = getQuery(event);

  const templatePath = props.template as string;

  if (!templatePath) {
    return "forneça um caminho de template válido. Ex: APP_DOMAIN/api/preview?template=/email/template-default";
  }

  try {
    // obtém o template através de import do arquivo compilado
    let html = (await $fetch(templatePath, {
      responseType: "text",
      method: "GET",
    })) as string;

    html = sanitize(html);
    html = (await applyInlineStyles(html)) as string;

    return html;
  } catch (error) {
    return `não existe nenum template com o caminho fornecido: template=${templatePath}`;
  }
});
