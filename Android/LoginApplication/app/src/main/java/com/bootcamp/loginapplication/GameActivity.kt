package com.bootcamp.loginapplication

import android.os.Bundle
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import com.bootcamp.loginapplication.databinding.ActivityGameBinding
import kotlin.random.Random
import android.graphics.drawable.GradientDrawable
import android.graphics.Color
import android.view.*
import android.os.CountDownTimer

class GameActivity : AppCompatActivity() {

    private lateinit var binding: ActivityGameBinding
    var points = 0
    val drawable = GradientDrawable()
    val timer = object : CountDownTimer(30000, 1000) {
        override fun onTick(millisUntilFinished: Long) {
            binding.tvTimer.text = (millisUntilFinished / 1000).toString()
        }

        override fun onFinish() {
            binding.vClick.visibility = View.INVISIBLE
            binding.tvTimer.text = "FIN"
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {

        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        binding = ActivityGameBinding.inflate(layoutInflater)
        setContentView(binding.root)
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }
        supportActionBar?.hide()
        visuals()


        binding.vClick.setOnClickListener {
            val newX = Random.nextInt(binding.gameField.width - binding.vClick.width)
            val newY = Random.nextInt(binding.gameField.height - binding.vClick.height)

            binding.vClick.x = newX.toFloat()
            binding.vClick.y = newY.toFloat()

            points++
            binding.tvPoints.text = points.toString()
        }

        binding.btnStart.setOnClickListener {
            binding.vClick.visibility = View.VISIBLE
            timer.start()
        }
    }

    fun visuals() {
        drawable.cornerRadius = 30f
        drawable.setColor(Color.RED)
        binding.vClick.background = drawable
        binding.vClick.visibility = View.INVISIBLE
    }

}