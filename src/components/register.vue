<template>
  <div class="login-container">
    <div class="background-image"></div>
    <div class="login-box" @mouseover="changeCursor">
      <img src="https://www.anahuac.mx/sites/default/files/LogoRUA_HUB_1.png" class="logo">
      <div class="content">
        <h3 class="title">Registro</h3>
        <div class="input-group">
          <input type="text" v-model="id" class="input-field" placeholder="ID" @focus="hideBottomBorder" @blur="showBottomBorder">
          <div class="input-line"></div>
        </div>
        <div class="input-group">
          <input type="text" v-model="nombre" class="input-field" placeholder="Nombre" @focus="hideBottomBorder" @blur="showBottomBorder">
          <div class="input-line"></div>
        </div>
        <div class="input-group">
          <input type="text" v-model="apellidoPaterno" class="input-field" placeholder="Apellido Paterno" @focus="hideBottomBorder" @blur="showBottomBorder">
          <div class="input-line"></div>
        </div>
        <div class="input-group">
          <input type="text" v-model="apellidoMaterno" class="input-field" placeholder="Apellido Materno" @focus="hideBottomBorder" @blur="showBottomBorder">
          <div class="input-line"></div>
        </div>
        <div class="input-group">
          <input type="text" v-model="email" class="input-field" placeholder="user@anahuac.mx" @focus="hideBottomBorder" @blur="showBottomBorder">
          <div class="input-line"></div>
        </div>
        <div class="input-group">
          <input type="password" v-model="password" class="input-field" placeholder="Contraseña" @focus="hideBottomBorder" @blur="showBottomBorder">
          <div class="input-line"></div>
        </div>
        <div class="input-group">
          <input type="password" v-model="confirmPassword" class="input-field" placeholder="Confirmar Contraseña" @focus="hideBottomBorder" @blur="showBottomBorder" @keyup.enter="submit"  >
          <div class="input-line"></div>
        </div>
        <div class="back-to-home" @click="goToHome">
          <span class="arrow">←</span>
          <span class="text">Regresar al inicio</span>
        </div>
      </div>
      <button @click="submit" class="submit-button">Registrarse</button>
    </div>
  </div>
</template>

<script>
import axios from 'axios';
import Swal from 'sweetalert2';

export default {
  data() {
    return {
      id: '',
      nombre: '',
      apellidoPaterno: '',
      apellidoMaterno: '',
      email: '',
      password: '',
      confirmPassword: ''
    }
  },
  methods: {
    submit() {
      if (!/^\d{8}$/.test(this.id)) {
        this.showAlert('Error', 'El ID debe contener 8 dígitos numéricos');
        return;
      }
      if (!/^[a-zA-ZáéíóúÁÉÍÓÚ\s]+$/.test(this.nombre)) {
        this.showAlert('Error', 'El nombre solo puede contener letras y espacios');
        return;
      }
      if (!/^[a-zA-ZáéíóúÁÉÍÓÚ\s]+$/.test(this.apellidoPaterno)) {
        this.showAlert('Error', 'El Apellido Paterno solo puede contener letras y espacios');
        return;
      }
      if (!/^[a-zA-ZáéíóúÁÉÍÓÚ\s]+$/.test(this.apellidoMaterno)) {
        this.showAlert('Error', 'El Apellido Materno solo puede contener letras y espacios');
        return;
      }
      if (!this.email.endsWith('@anahuac.mx')) {
        this.showAlert('Error', 'El correo electrónico debe ser @anahuac.mx');
        return;
      }
      if (!/(?=.*[A-Z])(?=.*\d).{8,}/.test(this.password)) {
        this.showAlert('Error', 'La contraseña debe tener al menos 8 caracteres, una letra mayúscula y un número');
        return;
      }
      if (this.password !== this.confirmPassword) {
        this.showAlert('Error', 'Las contraseñas no coinciden');
        return;
      }
      // Preparar los datos para enviar al servidor
      const formData = new FormData();
      formData.append('ID_ALUMNO', this.id);
      formData.append('NOMBRE', this.nombre);
      formData.append('APELLIDO_PATERNO', this.apellidoPaterno);
      formData.append('APELLIDO_MATERNO', this.apellidoMaterno);
      formData.append('CORREO', this.email);
      formData.append('CONTRASEÑA', this.password);

      // Enviar la petición al servidor
      axios.post('http://localhost/BEA/back/registro.php', formData)
        .then(response => {
          // Manejar la respuesta del servidor
          if (response.data === "El ID ya está registrado. Por favor, inicia sesión con tu cuenta." ||
              response.data === "El correo ya está en uso con otra cuenta.") {
            this.showAlert('Error', response.data);
            this.$router.push('/iniciosesion');
          } else if (response.data === "Registro exitoso") {
            // Registro exitoso
            this.showAlert('Éxito', 'Registro exitoso', 'success').then(() => {
              this.$router.push('/iniciosesion');
            });
          } else {
            // Otros mensajes del servidor
            this.showAlert('Error', 'Error desconocido: ' + response.data);
          }
        })
        .catch(error => {
          // Error en la petición
          console.error('Error en la petición:', error);
          this.showAlert('Error', 'Ocurrió un error al realizar el registro.');
        });
    },
    showAlert(title, text, icon = 'error') {
      return Swal.fire({
        title: title,
        text: text,
        icon: icon,
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
    }
  }
};
</script>


  <style scoped>

@keyframes fadeIn {
  from {
    opacity: 0; /* Opacidad inicial */
  }
  to {
    opacity: 1; /* Opacidad final */
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
    padding: 40px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.3);
    text-align: left;
    position: relative;
    width: 500px;
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
    font-size: 30px;
    margin-top: 60px;
    margin-bottom: 10px; 
    color: rgb(24, 23, 23);
  }
  
  .input-group {
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
    background-color: #0078d4;
  }
  
  .input-line:hover {
    background-color: grey;
  }
  
  .submit-button {
    background-color: #0078d4;
    color: white;
    padding: 15px 30px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-size: 18px;
    transition: background-color 0.3s ease;
  }
  
  .submit-button:hover {
    background-color: #005a9e;
  }
  
  .back-to-home {
    position: absolute;
    top: 20px;
    right: 20px;
    display: flex;
    align-items: center;
    cursor: pointer;
    color: grey;
  }
  
  .arrow {
    font-size: 20px;
    margin-right: 5px;
  }
  
  .text {
    font-size: 14px;
  }

  @media (max-width: 639px) {

  
  .login-box {
    padding: 20px;
    width: 300px;
  }
  
  .logo {
    position: absolute;
    top: 30px;
    left: 30px;
    width: 80px;
    height: auto;
  }
  
  .title {
    font-size: 30px;
    margin-top: 60px;
    margin-bottom: 10px; 
    color: rgb(24, 23, 23);
  }
  
  .input-group {
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
    background-color: #0078d4;
  }
  
  .input-line:hover {
    background-color: grey;
  }
  
  .submit-button {
    background-color: #0078d4;
    color: white;
    padding: 15px 30px;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-size: 18px;
    transition: background-color 0.3s ease;
  }
  
  .submit-button:hover {
    background-color: #005a9e;
  }
  
  .back-to-home {
    position: absolute;
    top: 20px;
    right: 20px;
    display: flex;
    align-items: center;
    cursor: pointer;
    color: grey;
  }
  
  .arrow {
    font-size: 20px;
    margin-right: 5px;
  }
  
  .text {
    font-size: 14px;
  }

}

  </style>
  
  