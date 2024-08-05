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
        <h1>Wiki de Táctica Pixel</h1>
        <nav>
            <ul>
                <li><a href="../index.html">Home</a></li>
                <li><a href="personajes.html">Personajes</a></li>
                <li><a href="mapas.html">General</a></li>
                <li><a href="../contacto/contacto.html">Contacto</a></li>
                <li><a href="../Registro/registro.html">Registro</a></li>
            </ul>
        </nav>
    `;

    // Crear el contenido del footer
    const footerContent = `
        <p>&copy; 2024 Wiki de Táctica Pixel. Todos los derechos reservados.</p>
        <nav>
            <ul>
                <li><a href="privacidad.html">Privacidad</a></li>
                <li><a href="terminos.html">Términos</a></li>
                <li><a href="contacto.html">Contacto</a></li>
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