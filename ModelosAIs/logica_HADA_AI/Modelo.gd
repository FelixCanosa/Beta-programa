extends Node

class ChatData:
	var character: String
	var text: String

var conversation_history: Array[ChatData] = []
var max_history = 5

var current_response = ""
var is_generating = false

@onready var personality_db = $PersonalityDB

func _ready():
	$TextEdit.grab_focus()
	$GDLlama.context_size = 2096
	$GDLlama.n_predict = 1024
	$GDLlama.should_output_prompt = false
	$GDLlama.should_output_special = false
	
	$TextEdit.text_changed.connect(_on_text_edit_text_changed)
	$GDLlama.generate_text_updated.connect(_on_gd_llama_generate_text_updated)
	$GDLlama.generate_text_finished.connect(_on_gd_llama_generate_text_finished)

	# Inicializar la personalidad de la AI
	var initial_prompt = ChatData.new()
	initial_prompt.character = "system"
	initial_prompt.text = "Eres Thistle, un hada gruñona del bosque oscuro. Mantén siempre esta personalidad."
	conversation_history.append(initial_prompt)

func prompt_with_history() -> String:
	if conversation_history.size() > max_history:
		conversation_history.remove_at(1)  # Mantener el prompt inicial
	
	var prompt = ""
	
	# Recupera rasgos de personalidad relevantes
	var last_message = conversation_history[-1].text if conversation_history.size() > 1 else ""
	var relevant_traits = personality_db.get_relevant_traits(last_message)
	
	prompt += "<|im_start|>system\nRecuerda estos aspectos de tu personalidad:\n"
	for trait_text in relevant_traits:
		prompt += "- " + trait_text + "\n"
		prompt += "<|im_end|>\n"
	
	for d in conversation_history:
		if d.character == "a":
			prompt += "<|im_start|>user\n" + d.text +"<|im_end|>\n" 
		elif d.character == "b":
			prompt += "<|im_start|>assistant\n" + d.text + "<|im_end|>\n"
		else:  # system
			prompt += "<|im_start|>system\n" + d.text + "<|im_end|>\n"
	
	prompt += "<|im_start|>assistant\n"
	print("Prompt completo:", prompt)
	return prompt

func _send_message(new_text: String = ""):
	var user_input = new_text.strip_edges()
	if user_input.length() > 0:
		var data = ChatData.new()
		data.character = "a"
		data.text = user_input 
		$terminal.append_text("\nUsuario: " + data.text + "\n")
		conversation_history.append(data)
		var prompt: String = prompt_with_history()
		$GDLlama.run_generate_text(prompt, "", "")
		$TextEdit.clear()
	else:
		print("El mensaje está vacío")
	
	$terminal.scroll_to_line($terminal.get_line_count() - 1)

func _on_gd_llama_generate_text_updated(text):
	if not is_generating:
		is_generating = true
		current_response = ""
		$terminal.append_text("\nAI: ")

	current_response += text
	$terminal.append_text(text)
	
	$terminal.scroll_to_line($terminal.get_line_count() - 1)

func _on_gd_llama_generate_text_finished():
	is_generating = false
	
	var clean_text = current_response.replace("<|im_start|>assistant\n", "").replace("<|im_end|>", "").strip_edges()
	
	print("Respuesta completa de la AI:", clean_text)
	
	var data = ChatData.new()
	data.character = "b" 
	data.text = clean_text
	conversation_history.append(data)
	
	current_response = ""



		
		
func _on_text_edit_text_changed():
	var text = $TextEdit.text
	if text.ends_with("\n"):
		_send_message(text.strip_edges())
		$TextEdit.clear()
