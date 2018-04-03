import Typed from 'typed.js';

function loadDynamicBannerText() {
  new Typed('.field_search', {
    strings: ["Procurando garçom?", "Procurando dançarinas?", "Procurando palhaço?"],
    typeSpeed: 50,
    attr: 'placeholder',
    loop: true,
    smartBackspace: true,
    backSpeed: 80,
  });
}

export { loadDynamicBannerText };
