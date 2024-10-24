extends Node

signal player_crazy

var ItemsHistory : Array[String] = []
var DoorsOppened : Array[String] = []
var PlayerItems : Array[Item] = []
var PlayerSanity := 100
var PlayerCurrentScene : String


func reset_game():
	ItemsHistory = []
	DoorsOppened = []
	PlayerItems = []
	PlayerSanity = 100
	PlayerCurrentScene = ""
	Dialogic.VAR.clear_game_state()
	Global.first_play = true
	pass
