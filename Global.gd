extends Node

var isdragging = false
var sendInfo = {"license" : null, "att" : null, "sa" : null, "nc" : null, "nd" : null, "app" : null}
var user_responses : Array[Dictionary] = []
var correct_responses : Array[Dictionary] = []

var tickSpeed = 1

var health : int = 3

var score = 15

