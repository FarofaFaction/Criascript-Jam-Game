extends Node

signal player_crazy

var ItemsHistory : Array[String] = []
var DoorsOppened : Array[String] = []
var PlayerItems : Array[Item] = []
var PlayerSanity := 100
var PlayerCurrentScene : String
