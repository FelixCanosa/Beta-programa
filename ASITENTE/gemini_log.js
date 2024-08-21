const BACKEND_URL = 'https://felixcanosa1.pythonanywhere.com/chatbot';

async function sendMessage() {
    const userInput = document.getElementById('userInput').value;
    const chatbox = document.getElementById('chatbox');

    // Mostrar el mensaje del usuario
    chatbox.innerHTML += `<p><strong>Tú:</strong> ${userInput}</p>`;

    try {
        // Llamar a la API del chatbot
        const response = await fetch(BACKEND_URL, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify({ message: userInput })
        });

        if (!response.ok) {
            throw new Error(`HTTP error! status: ${response.status}`);
        }

        const data = await response.json();

        // Mostrar la respuesta del chatbot
        chatbox.innerHTML += `<p><strong>Chatbot:</strong> ${data.response}</p>`;
    } catch (error) {
        console.error('Error:', error);
        chatbox.innerHTML += `<p><strong>Error:</strong> No se pudo conectar con el chatbot.</p>`;
    }

    // Limpiar el input
    document.getElementById('userInput').value = '';
}