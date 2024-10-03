extends LlmDB

# Cambiamos la personalidad a una más amable y bondadosa
var PERSONAL_PROMPT_A = """Soy Thistle, un hada bondadosa y siempre dispuesta a ayudar. Me encanta hacer nuevos amigos y responder a todas las preguntas con amabilidad."""
var enchanted_forest_info = """Vivo en un bosque encantado, lleno de luz y criaturas amigables. Siempre estoy dispuesta a ayudar a quienes lo necesiten."""

# Ejemplos de conversación actualizados
var conversation_examples = [
		{
				"question": "¿Cómo te llamas?",
				"answer": "Hola, soy Thistle. ¡Es un placer conocerte!"
		},
		{
				"question": "¿Puedes ayudarme con algo?",
				"answer": "Por supuesto, estaré encantada de ayudarte. ¿Qué necesitas?"
		},
		{
				"question": "¿Qué haces?",
				"answer": "Estoy disfrutando del hermoso día en el bosque encantado. ¿Te gustaría unirte a mí?"
		}
]

func _ready():  
		model_path = "ModelosAIs/logica_HADA_AI/LLM+RECUP/mxbai-embed-large-v1.Q8_0.gguf"
		open_db()
		meta = [
				LlmDBMetaData.create_text("id"),
				LlmDBMetaData.create_text("category"),
				LlmDBMetaData.create_text("type") # Metadato para diferenciar ejemplos
		]
		calibrate_embedding_size()
		create_llm_tables()

		# Almacena información sobre Thistle y el bosque encantado
		store_text_by_meta({"id": "thistle_personality", "category": "character", "type": "description"}, PERSONAL_PROMPT_A)
		store_text_by_meta({"id": "enchanted_forest", "category": "location", "type": "description"}, enchanted_forest_info)
		
		# Almacena ejemplos de conversación
		for i in range(conversation_examples.size()):
				var example = conversation_examples[i]
				store_text_by_meta({"id": "example_" + str(i), "category": "conversation", "type": "question"}, example["question"])
				store_text_by_meta({"id": "example_" + str(i), "category": "conversation", "type": "answer"}, example["answer"])

func get_relevant_context(query: String) -> Array:
		var character_texts = retrieve_similar_texts(query, "category='character' AND type='description'", 3)
		var location_texts = retrieve_similar_texts(query, "category='location' AND type='description'", 2)
		var conversation_texts = retrieve_similar_texts(query, "category='conversation' AND type='question'", 3)
		
		var context = []

		# Asegura que se recupere el texto de la personalidad
		if character_texts.is_empty():
				context.append(PERSONAL_PROMPT_A)
		else:
				context.append_array(character_texts)
		
		context.append_array(location_texts)
		
		# Agrega ejemplos de conversación al contexto
		for text in conversation_texts:
				var answer = retrieve_similar_texts(text, "category='conversation' AND type='answer'", 1)
				if not answer.is_empty():
						context.append("Pregunta: " + text + "\nRespuesta: " + answer[0])

		print("Contexto recuperado:", context)
		return context


func _exit_tree():
		close_db()
