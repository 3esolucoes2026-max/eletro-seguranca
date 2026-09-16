/* ============== MENU MOBILE ============== */
document.addEventListener('DOMContentLoaded', function () {
  var toggle = document.querySelector('.menu-toggle');
  var menu = document.querySelector('.nav-menu');

  toggle.addEventListener('click', function () {
    menu.classList.toggle('open');
  });

  // Fecha o menu ao clicar em um link
  menu.querySelectorAll('a').forEach(function (link) {
    link.addEventListener('click', function () {
      menu.classList.remove('open');
    });
  });

  // Reveal ao rolar
  var revealEls = document.querySelectorAll('.reveal');
  function checkReveal() {
    revealEls.forEach(function (el) {
      var rect = el.getBoundingClientRect();
      if (rect.top < window.innerHeight - 60) {
        el.classList.add('visible');
      }
    });
  }
  checkReveal();
  window.addEventListener('scroll', checkReveal);

  /* ============== FORMULÁRIO -> WHATSAPP ============== */
  var form = document.getElementById('orcamento-form');
  form.addEventListener('submit', function (e) {
    e.preventDefault();

    var nome = document.getElementById('nome').value.trim();
    var telefone = document.getElementById('telefone').value.trim();
    var email = document.getElementById('email').value.trim();
    var servico = document.getElementById('servico').value;
    var mensagem = document.getElementById('mensagem').value.trim();

    if (!nome || !telefone || !servico) {
      alert('Preencha os campos obrigatórios (Nome, WhatsApp e Tipo de serviço).');
      return;
    }

    var texto =
      'Olá! Gostaria de solicitar um orçamento com a 3E - Instalação e Manutenção Elétrica.\n\n' +
      '*Nome:* ' + nome + '\n' +
      '*WhatsApp:* ' + telefone + '\n' +
      (email ? '*E-mail:* ' + email + '\n' : '') +
      '*Serviço:* ' + servico + '\n' +
      (mensagem ? '*Mensagem:* ' + mensagem + '\n' : '');

    var url = 'https://wa.me/5583982234468?text=' + encodeURIComponent(texto);
    window.open(url, '_blank');
  });
});
