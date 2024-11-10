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
    <nav class="navbar navbar-expand-lg bg-light shadow-sm mb-4">
        <div class="container-fluid">
            <a class="navbar-brand text-primary" href="#">··</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav" 
                    aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav ms-auto">
                    <li class="nav-item">
                        <a class="nav-link text-dark" href="../index.html">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-dark" href="../Personajes/asistente.html">Personajes</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link text-dark" href="../General/general.html">General</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
`;

// Crear el contenido del footer
const footerContent = `
    <footer class="bg-dark text-light py-4 mt-5">
        <div class="container">
            <div class="row">
                <div class="col-md-6 text-center text-md-start mb-3 mb-md-0">
                    <p class="mb-0">&copy; 2024 Wiki de Orbitos. Todos los derechos reservados.</p>
                </div>
                <div class="col-md-6">
                    <ul class="nav justify-content-center justify-content-md-end">
                        <li class="nav-item">
                            <a class="nav-link text-light" href="privacidad.html">Privacidad</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-light" href="terminos.html">Términos</a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link text-light" href="../contacto/contacto.html">Contacto</a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </footer>
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



// Esperar a que el DOM esté completamente cargado
document.addEventListener('DOMContentLoaded', function() {
    createHeaderAndFooter();
    
    // Añadir el evento de scroll
    window.addEventListener('scroll', handleScroll);
});


