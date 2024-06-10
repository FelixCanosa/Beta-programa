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
		
func prompt_with_history() -> String:
	if (conversation_history.size() > max_history):
		conversation_history.remove_at(0)
	var prompt = "" 
	for d in conversation_history:
		if (d.character == "a"):
			prompt += "<|im_start|>user\n" + d.text +"<|im_end|>\n" 
		else:
			prompt += "<|im_start|>system\n" + d.text  + "<|im_end|>\n"
	prompt += "<|im_start|>system\n"
	print(prompt)
	return prompt

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

