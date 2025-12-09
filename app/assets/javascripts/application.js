

// Підтримка підтвердження видалення
document.addEventListener('DOMContentLoaded', function() {
  const deleteButtons = document.querySelectorAll('[data-confirm]');
  deleteButtons.forEach(function(button) {
    button.addEventListener('click', function(e) {
      if (!confirm(this.getAttribute('data-confirm'))) {
        e.preventDefault();
        return false;
      }
    });
  });
});

