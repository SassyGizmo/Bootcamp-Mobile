package com.bootcamp.firstapp.firstapp

import android.os.Bundle
import androidx.activity.enableEdgeToEdge
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import com.bootcamp.firstapp.R
import androidx.appcompat.widget.*
import android.content.*


class LoginActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        enableEdgeToEdge()
        setContentView(R.layout.activity_login)
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main)) { v, insets ->
            val systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars())
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom)
            insets
        }

        val btnSignIn = findViewById<AppCompatButton>(R.id.signIn)
        val etUsuario = findViewById<AppCompatEditText>(R.id.usuario)


        btnSignIn.setOnClickListener {
            val usuarioInput = etUsuario.text.toString()

            if (usuarioInput.isNotEmpty()) {
                val intent = Intent(this, SecondActivity::class.java)
                intent.putExtra("NAME", usuarioInput)
                startActivity(intent)
            }
        }
    }
}