import { load } from "cheerio";

export function sanitize(html: string) {
  const $ = load(html, { decodeEntities: false });

  $('link[rel="stylesheet"]').remove();
  // Se você realmente não quer nenhum <style> original:
  $("style").remove();

  // remova tags que não queremos em e-mail
  $("script, link, meta, noscript").remove();

  // elimine id/data-* residuais de nuxt/devtools
  $('[id^="__nuxt"], [data-nuxt-], [data-v-]').each((_, el) => {
    const $el = $(el);
    $el.removeAttr("id");
    Object.keys($el.attr() || {})
      .filter((k) => k.startsWith("data-"))
      .forEach((k) => $el.removeAttr(k));
  });

  return $.html();
}
