(() => {
  'use strict';
  document.documentElement.classList.add('js');

  const nav = document.getElementById('site-nav');
  const menu = document.querySelector('.menu-toggle');
  function setMenu(open) {
    nav.classList.toggle('is-open', open);
    menu.setAttribute('aria-expanded', String(open));
    menu.querySelector('span').textContent = open ? '−' : '+';
  }
  menu.addEventListener('click', () => setMenu(menu.getAttribute('aria-expanded') !== 'true'));
  nav.querySelectorAll('a').forEach(link => link.addEventListener('click', () => setMenu(false)));
  document.addEventListener('keydown', event => {
    if (event.key === 'Escape' && menu.getAttribute('aria-expanded') === 'true') {
      setMenu(false);
      menu.focus();
    }
  });
  const desktop = window.matchMedia('(min-width: 761px)');
  desktop.addEventListener('change', event => { if (event.matches) setMenu(false); });

  document.querySelectorAll('input[name="screenshot-view"]').forEach(input => {
    input.addEventListener('change', () => {
      const mode = input.value;
      const label = mode === 'runtime' ? 'Runtime with dummy data' : 'RAD Studio Designer hierarchy';
      document.querySelectorAll('.result-image').forEach(img => {
        const href = img.dataset[mode];
        img.src = href;
        img.width = mode === 'runtime' ? 360 : 794;
        img.height = 1002;
        img.alt = `${img.dataset.methodTitle} / ${label}`;
        const link = img.closest('[data-lightbox]');
        link.href = href;
        link.dataset.caption = `${img.dataset.methodTitle} / ${label}`;
      });
    });
  });

  const dialog = document.querySelector('.image-dialog');
  const dialogImage = document.getElementById('dialog-image');
  const caption = document.getElementById('image-dialog-caption');
  const original = document.getElementById('image-original');
  if (typeof dialog.showModal === 'function') {
    document.querySelectorAll('[data-lightbox]').forEach(link => {
      link.addEventListener('click', event => {
        if (event.ctrlKey || event.metaKey || event.shiftKey || event.altKey) return;
        event.preventDefault();
        dialogImage.src = link.href;
        dialogImage.alt = link.querySelector('img').alt;
        caption.textContent = link.dataset.caption;
        original.href = link.href;
        dialog.showModal();
        document.body.classList.add('modal-open');
      });
    });
    dialog.querySelector('.dialog-close').addEventListener('click', () => dialog.close());
    dialog.addEventListener('click', event => { if (event.target === dialog) dialog.close(); });
    dialog.addEventListener('close', () => document.body.classList.remove('modal-open'));
  }

  const live = document.querySelector('.live-message');
  async function copyText(text) {
    if (navigator.clipboard && window.isSecureContext) {
      try { await navigator.clipboard.writeText(text); return true; } catch (_) { /* Use local-file fallback. */ }
    }
    const field = document.createElement('textarea');
    field.value = text;
    field.setAttribute('aria-label', 'Prompt text');
    field.style.position = 'fixed';
    field.style.top = '0';
    field.style.left = '-9999px';
    document.body.appendChild(field);
    field.focus();
    field.select();
    let success = false;
    try { success = document.execCommand('copy'); } catch (_) { /* Report and leave source selectable. */ }
    field.remove();
    return success;
  }
  document.querySelectorAll('[data-copy]').forEach(button => {
    const label = button.textContent;
    button.addEventListener('click', async () => {
      const target = document.getElementById(button.dataset.copy);
      const success = await copyText(target.textContent.trim());
      button.focus({ preventScroll: true });
      button.textContent = success ? 'Copied ✓' : 'Select text to copy';
      live.textContent = success ? 'Prompt copied to clipboard.' : 'Clipboard access is unavailable. Select and copy the prompt text.';
      window.setTimeout(() => { button.textContent = label; }, 2400);
    });
  });
})();
