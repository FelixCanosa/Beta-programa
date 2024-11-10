document.addEventListener('DOMContentLoaded', () => {
    const botonesCharlar = document.querySelectorAll('.btn-primary');
    const chatModal = new bootstrap.Modal(document.getElementById('chatModal'));
    const chatModalLabel = document.getElementById('chatModalLabel');
    const chatPersonajeImagen = document.getElementById('chatPersonajeImagen');
    const chatPersonajeDescripcion = document.getElementById('chatPersonajeDescripcion');
    const chatMessages = document.getElementById('chatMessages');
    const userMessage = document.getElementById('userMessage');
    const sendMessageBtn = document.getElementById('sendMessageBtn');
    let personajeActual = null;

    botonesCharlar.forEach(boton => {
        boton.addEventListener('click', () => {
            const card = boton.closest('.card');
            personajeActual = card.querySelector('.card-title').textContent;
            const imagenSrc = card.querySelector('.card-img-top').src;
            const descripcion = card.querySelector('.card-text').textContent;
            mostrarChat(personajeActual, imagenSrc, descripcion);
        });
    });

    function mostrarChat(nombrePersonaje, imagenSrc, descripcion) {
        chatModalLabel.textContent = nombrePersonaje;
        chatPersonajeImagen.src = imagenSrc;
        chatPersonajeDescripcion.textContent = truncateText(descripcion, 100);
        chatMessages.innerHTML = '';
        chatModal.show();
        userMessage.focus();
    }

    function truncateText(text, maxLength) {
        if (text.length <= maxLength) return text;
        return text.substr(0, maxLength) + '...';
    }

    sendMessageBtn.addEventListener('click', enviarMensaje);
    userMessage.addEventListener('keypress', (e) => {
        if (e.key === 'Enter') enviarMensaje();
    });

    async function enviarMensaje() {
        const mensaje = userMessage.value.trim();
        if (!mensaje) return;

        agregarMensajeAlChat('Tú', mensaje);
        userMessage.value = '';

        const backendURL = 'https://felixcanosa1.pythonanywhere.com/chatbot';

        try {
            const response = await fetch(backendURL, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ personaje: personajeActual, message: mensaje })
            });

            if (!response.ok) {
                const errorData = await response.json();
                throw new Error(errorData.error || `Error HTTP: ${response.status}`);
            }

            const data = await response.json();
            agregarMensajeAlChat(personajeActual, data.response);

        } catch (error) {
            console.error('Error:', error);
            agregarMensajeAlChat('Error', error.message);
        }
    }

    function agregarMensajeAlChat(remitente, mensaje) {
        const messageElement = document.createElement('div');
        messageElement.className = `mb-3 ${remitente === 'Tú' ? 'text-end' : ''}`;
        messageElement.innerHTML = `
            <strong>${remitente}:</strong>
            <p class="mb-0">${mensaje}</p>
        `;
        chatMessages.appendChild(messageElement);
        chatMessages.scrollTop = chatMessages.scrollHeight;
    }
});