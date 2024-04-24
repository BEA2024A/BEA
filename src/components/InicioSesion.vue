<template>
  <div class="login-container">
    <div class="background-image"></div>
    <div class="login-box" @mouseover="changeCursor">
      <div class="back-to-home" @click="goToHome">
        <span class="arrow">←</span>
        <span class="text">Regresar al inicio</span>
      </div>
      <img src="https://www.anahuac.mx/sites/default/files/LogoRUA_HUB_1.png" class="logo">
      <div class="content">
        <h3 class="title" v-if="paso === 1">Iniciar sesión</h3>
        <h3 class="title" v-if="paso === 2">Escribir Contraseña</h3>

        <!-- Correo -->
        <div class="email-input" v-if="paso === 1">
          <input type="email" v-model="email" placeholder="user@anahuac.mx" class="input-field" @focus="hideBottomBorder" @blur="showBottomBorder" @keyup.enter="avanzarOPostear">
          <div class="input-line"></div>
        </div>

        <!-- Contraseña -->
        <div class="email-input" v-if="paso === 2">
          <input type="password" v-model="password" class="input-field" placeholder="Contraseña" @focus="hideBottomBorder" @blur="showBottomBorder" @keyup.enter="avanzarOPostear">
          <div class="input-line"></div>
        </div>

        <div class="register-link" @click="goToRegister" v-if="paso === 1">
          <span class="text">¿Es tu primera vez? Regístrate</span>
        </div>
      </div>
      <button @click="avanzarOPostear" class="submit-button">{{ botonTexto }}</button>
    </div>
  </div>
</template>


<script>
import axios from 'axios';
import { mapActions } from 'vuex';
import Swal from 'sweetalert2';

export default {
  data() {
    return {
      email: '',
      password: '',
      paso: 1, // Nuevo estado para controlar el paso actual
    };
  },
  computed: {
    botonTexto() {
      return this.paso === 1 ? 'Siguiente' : 'Iniciar Sesión';
    },
  },
  methods: {
    ...mapActions(['iniciarSesion']),
    avanzarOPostear() {
      if (this.paso === 1) {
        this.paso = 2; // Avanza al siguiente paso
      } else {
        this.postearLogin(); // Intenta iniciar sesión
      }
    },
    postearLogin() {
      const formData = new FormData();
      formData.append('CORREO', this.email);
      formData.append('CONTRASEÑA', this.password);

      axios.post('http://localhost/BEA/back/verificar_credenciales.php', formData)
        .then(response => {
          if (response.data.exito) {
            this.$store.dispatch('iniciarSesion', {
              nombre: response.data.nombreUsuario,
              correo: response.data.correoUsuario,
              a_paterno: response.data.a_paternoUsuario,
              a_materno: response.data.a_maternoUsuario,
              id: response.data.idUsuario,
              tipo: response.data.tipoUsuario, // Agregamos el tipo de usuario
            });

            // Redirige según el tipo de usuario
            if (response.data.tipoUsuario === 'administrador') {
              this.$router.push('/inicioPsico');
            } else {
              this.$router.push('/');
            }
          } else {
            this.showErrorAlert('Correo electrónico o contraseña incorrectos.');
            this.paso = 1;
          }
        })
        .catch(error => {
          console.error('Error en la petición:', error);
          this.showErrorAlert('Ocurrió un error al intentar iniciar sesión.');
          this.paso = 1;
        });
    },
    showErrorAlert(message) {
      Swal.fire({
        icon: 'error',
        title: '¡Error!',
        text: message,
        confirmButtonText: 'Aceptar'
      });
    },
    hideBottomBorder() {
      this.$refs.emailInput.style.borderBottom = 'none';
    },
    showBottomBorder() {
      this.$refs.emailInput.style.borderBottom = '2px solid blue';
    },
    changeCursor() {
      this.$refs.emailInput.style.cursor = 'text';
    },
    goToHome() {
      this.$router.push('/');
    },
    goToRegister() {
      this.$router.push('/register');
    }
  }
}
</script>


  <style scoped>

@keyframes fadeIn {
  from {
    opacity: 0; 
  }
  to {
    opacity: 1; 
  }
}




  .login-container {
    position: relative;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    animation: fadeIn 1s ease forwards;
  }
  
  .background-image {
    position: absolute;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-image: url("https://i.postimg.cc/RCgngn7k/fondo-sesion.png");
    background-size: cover;
    z-index: -1;
  }
  
  .login-box {
    background-color: rgb(255, 255, 255);
    padding: 60px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
    text-align: left;
    position: relative;
    width: 500px;
    height: 370px;
    display: flex;
    flex-direction: column;
    justify-content: center;
  }
  
  .logo {
    position: absolute;
    top: 30px;
    left: 30px;
    width: 150px;
    height: auto;
  }
  
  .title {
    font-size: 25px;
    margin-bottom: 20px;
    color:rgb(24, 23, 23)
  }
  .email-input {
    position: relative;
    margin-bottom: 20px;
  }
  .input-field {
    width: 100%;
    padding: 10px 0;
    border: none;
    border-bottom: 2px solid blue;
    background-color: transparent;
    font-size: 16px;
    outline: none; 
  }
  .input-line {
    position: absolute;
    bottom: 0;
    left: 0;
    width: 100%;
    height: 2px;
    background-color:#0078d4;
  }
  .input-line:hover {
    background-color: grey;
  }
  .submit-button {
    display: inline-block;
    background-color: #0078d4;
    color: white;
    padding: 10px 20px;
    text-decoration: none;
    border-radius: 5px;
    margin-top: 20px;
    margin-bottom: 20px; 
  }
  .submit-button:hover {
    background-color: #005a9e;
  }
  .back-to-home {
    display: flex;
    align-items: center;
    cursor: pointer;
    color:grey;
    margin-top: 60px;
  }
  .arrow {
    font-size: 20px;
    margin-right: 5px;
  }
  .text {
    font-size: 14px;
  }
  .register-link {
  margin-top: 10px;
  cursor: pointer;
  color: #005a9e;
}
.register-link:hover {
  color: grey;
}

@media (max-width: 639px) {

  .login-box {
    padding: 50px;
    width: 200px;
    height: 270px;
  }
  
  .logo {
    width: 80px;
  }

}



  </style>
