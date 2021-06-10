extends Control
var tentativas = 0
var senha = ""
var rng  = RandomNumberGenerator.new()
func _ready():
	rng.randomize()
	for button in $Panel/GridContainer.get_children(): 
		button.connect("pressed", self, "_on_Button_pressed", [button])
	while senha.length() < 4:
		var tentativa = str(rng.randi_range(0,9)) 
		if !(tentativa  in senha):
			senha += tentativa 
	print(senha)	
	pass 
	
func _on_Button_pressed(btn):	
	var numero = btn.text.to_lower()
	print(numero)
	$Panel/Label.text += numero
	if $Panel/Label.text.length() > 3:
		calcula()
	btn.disabled = true
	pass
	
func _process(_delta): 
	pass
	
func calcula():
	tentativas += 1
	var verde = 0
	var amarelo = 0
	var vermelho = 0
	var tentativa = $Panel/Label.text
	if int(senha) - int(tentativa) == 0:
		$resultado.text = "Você ganhou"
		$reset.visible = true
	pass
	for n in 4:
		if senha[n] == tentativa[n]:
			verde += 1
		elif tentativa[n] in senha:
			amarelo += 1 
		else: 
			vermelho += 1
	print(amarelo)
	print(verde)
	print(vermelho)
	desabilita_botoes()
	habilita_botoes()
	$Panel/Label.text = ""
	$Panel/RichTextLabel.bbcode_text += str("                                [b]Tentativa ", tentativas, "[/b] ", " [img]vermelha.png[/img]".repeat(vermelho), " [img]amarelo.png[/img]".repeat(amarelo), 
	 " [img]verde.png[/img]".repeat(verde), tentativa   ) 
	
	if tentativas == 10:
		$resultado.text = "Você perdeu "
		$Panel/Label.text = senha
		desabilita_botoes()
		$reset.visible = true
func desabilita_botoes():
	for button in $Panel/GridContainer.get_children(): 
		button.disabled = true
		
func habilita_botoes():
	for button in $Panel/GridContainer.get_children(): 
		button.disabled = false


func _on_RESET_pressed():
	get_tree().reload_current_scene()
	pass 
