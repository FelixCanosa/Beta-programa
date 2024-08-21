// Función para crear y añadir el header y footer
function createHeaderAndFooter() {
    // Crear un elemento link para el CSS
    const linkElement = document.createElement('link');
    linkElement.rel = 'stylesheet';
    linkElement.href = '/header_Footer_Global/header_footer.css'; 
    
    // Insertar el link en el head del documento
    document.head.appendChild(linkElement);

    // Crear el contenido del header
    const headerContent = `
    <div class="header-container">
        <h1>Orbiton</h1>
        <button class="menu-toggle" aria-label="Abrir menú">
            <div class="hamburger">
                <span></span>
                <span></span>
                <span></span>
            </div>
        </button>
        <nav>
            <ul>
                <li><a href="../index.html">Home</a></li>
                <li><a href="personajes.html">Personajes</a></li>
                <li><a href="../General/general.html">General</a></li>
                <li><a href="../ASITENTE/asistente.html">Asistente</a></li>
                <li><a href="../Registro/registro.html">Registro</a></li>
            </ul>
        </nav>
    </div>
`;

    // Crear el contenido del footer
    const footerContent = `
        <p>&copy; 2024 Wiki de Táctica Pixel. Todos los derechos reservados.</p>
        <nav>
            <ul>
                <li><a href="privacidad.html">Privacidad</a></li>
                <li><a href="terminos.html">Términos</a></li>
                <li><a href="../contacto/contacto.html">Contacto</a></li>
            </ul>
        </nav>
    `;

    // Insertar el contenido del header
    const headerElement = document.querySelector("header");
    if (headerElement) {
        headerElement.innerHTML = headerContent;
    } else {
        console.error("No se encontró el elemento header en el documento");
    }

    // Insertar el contenido del footer
    const footerElement = document.querySelector("footer");
    if (footerElement) {
        footerElement.innerHTML = footerContent;
    } else {
        console.error("No se encontró el elemento footer en el documento");
    }
}

// Función para manejar el evento de scroll
function handleScroll() {
    const header = document.querySelector('header');
    if (header) {
        if (window.scrollY > 50) {
            header.classList.add('scrolled');
        } else {
            header.classList.remove('scrolled');
        }
    }
}

// Esperar a que el DOM esté completamente cargado
document.addEventListener('DOMContentLoaded', function() {
    createHeaderAndFooter();
    
    // Añadir el evento de scroll
    window.addEventListener('scroll', handleScroll);
});


//manejar la funcionalidad del menú hamburguesa

document.addEventListener('DOMContentLoaded', () => {
    const menuToggle = document.querySelector('.menu-toggle');
    const nav = document.querySelector('header nav');
    const body = document.body;

    menuToggle.addEventListener('click', () => {
        nav.classList.toggle('active');
        menuToggle.classList.toggle('active');
        body.classList.toggle('menu-open');
        
        if (menuToggle.classList.contains('active')) {
            menuToggle.setAttribute('aria-expanded', 'true');
        } else {
            menuToggle.setAttribute('aria-expanded', 'false');
        }
    });

    // Cerrar el menú al hacer clic en un enlace
    const navLinks = document.querySelectorAll('header nav a');
    navLinks.forEach(link => {
        link.addEventListener('click', () => {
            nav.classList.remove('active');
            menuToggle.classList.remove('active');
            body.classList.remove('menu-open');
            menuToggle.setAttribute('aria-expanded', 'false');
        });
    });
});