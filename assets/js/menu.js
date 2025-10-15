 document.addEventListener('DOMContentLoaded', function () {
            // Obtener el botón de toggle y el body
            var sidebarToggle = document.getElementById('sidebarToggle');
            var body = document.querySelector('body');

            if (sidebarToggle) {
                sidebarToggle.addEventListener('click', function (event) {
                    event.preventDefault();
                    // Alternar la clase 'toggled' en el body
                    body.classList.toggle('toggled');
                });
            }
        });