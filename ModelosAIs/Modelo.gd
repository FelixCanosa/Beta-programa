extends Node2D

class ChatData:
	extends RefCounted
	var character: String
	var text: String

var personal_prompt_a = "soy B59,una inteligencia artificial avanzada creada por Vault-Tec en los días previos al gran cataclismo. Soy una máquina de guerra implacable"
var conversation_history: Array[ChatData] = []
var current_character = ""
var max_history = 2

func _ready():
	$GDLlama.context_size = 2096
	$GDLlama.n_predict = 1024
	$GDLlama.should_output_prompt = false
	$GDLlama.should_output_special = false

func _process(_delta):
	if ($GDLlama.is_running()):
		$StartButton.disabled = true;
	else:
		$StartButton.disabled = false
		
var prompt = "<bos>"

var start_index = max(1, conversation_history.size() - max_history)
for i in range(start_index, conversation_history.size()):
	var d = conversation_history[i]
	prompt += "<start_of_turn>"
	if d.character == "system":
		prompt += "system\n" + d.text
	elif d.character == "user":
		prompt += "user\n" + d.text
	elif d.character == "assistant":
		prompt += "model\n" + d.text
	prompt += "<end_of_turn>\n"

# Añadir la entrada actual del usuario
prompt += "<start_of_turn>user\n" + user_input + "<end_of_turn>\n"
prompt += "<start_of_turn>model\n"

func _on_start_button_pressed():
	var user_input = $TextEdit.text + "\n"# Asume que TextEdit es el nodo donde el usuario introduce su entrada
	var data = ChatData.new()
	data.character = "a:"
	data.text = user_input 
	$terminal.text += "\n" + data.character + data.text
	conversation_history.append(data)
	var prompt: String = prompt_with_history()
	$GDLlama.run_generate_text(prompt, "", "")

func _on_gd_llama_generate_text_finished(text):
	$terminal.text +=  text
	print(text)
	var data = ChatData.new()
	data.character = "b" 
	data.text = text
	conversation_history.append(data)
	print(conversation_history)

