extends CanvasLayer

enum FadeType {FADE_IN, FADE_OUT}

func fade(type: FadeType, duration: float = 0.5):
	match type:
		FadeType.FADE_IN:
			$AnimationPlayer.play("fade_in", -1, 1.0/duration)
		FadeType.FADE_OUT:
			$AnimationPlayer.play("fade_out", -1, 1.0/duration)
	
	await $AnimationPlayer.animation_finished
