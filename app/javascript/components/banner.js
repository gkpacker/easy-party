import Typed from 'typed.js';

function loadDynamicBannerText() {
  new Typed('.field_search', {
    strings: ["Procurando Garçom?", "Procurando Dançarina?", "Procurando Palhaço?"],
    typeSpeed: 50,
    attr: 'placeholder',
    loop: true,
    smartBackspace: true,
    backSpeed: 80,
  });
}

export { loadDynamicBannerText };
