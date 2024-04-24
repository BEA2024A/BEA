<template>
    <PlantillaPsico>
    <div class="login-container">
      <div class="background-image"></div>
      <div class="login-box" @mouseover="changeCursor">
        <div class="content">
          <h2 class="titulo">Registro de nuevo administrador</h2>
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
         
        </div>
        <button @click="submit" class="submit-button">Registrarse</button>
      </div>
    </div>
</PlantillaPsico>
  </template>
  
  <script>
import axios from 'axios';
import PlantillaPsico from './plantillaPsico.vue';
import Swal from 'sweetalert2';

export default {
  components: {
    PlantillaPsico,
  },
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
        Swal.fire(
          'Error',
          'El ID debe contener 8 dígitos numéricos',
          'error'
        );
        return;
      }
      if (!/^[a-zA-ZáéíóúÁÉÍÓÚ\s]+$/.test(this.nombre)) {
        Swal.fire(
          'Error',
          'El nombre solo puede contener letras y espacios',
          'error'
        );
        return;
      }
      if (!/^[a-zA-ZáéíóúÁÉÍÓÚ\s]+$/.test(this.apellidoPaterno)) {
        Swal.fire(
          'Error',
          'El Apellido Paterno solo puede contener letras y espacios',
          'error'
        );
        return;
      }
      if (!/^[a-zA-ZáéíóúÁÉÍÓÚ\s]+$/.test(this.apellidoMaterno)) {
        Swal.fire(
          'Error',
          'El Apellido Materno solo puede contener letras y espacios',
          'error'
        );
        return;
      }
      if (!/(?=.*[A-Z])(?=.*\d).{8,}/.test(this.password)) {
        Swal.fire(
          'Error',
          'La contraseña debe tener al menos 8 caracteres, una letra mayúscula y un número',
          'error'
        );
        return;
      }
      if (this.password !== this.confirmPassword) {
        Swal.fire(
          'Error',
          'Las contraseñas no coinciden',
          'error'
        );
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
      axios.post('http://localhost/BEA/back/agregarAdministrador.php', formData)
        .then(response => {
          // Manejar la respuesta del servidor
          if (response.data === "El ID ya está registrado. Por favor, inicia sesión con tu cuenta." ||
              response.data === "El correo ya está en uso con otra cuenta.") {
            Swal.fire(
              'Error',
              response.data,
              'error'
            );
          } else if (response.data === "Registro exitoso") {
            // Registro exitoso
            Swal.fire(
              'Éxito',
              'Registro exitoso',
              'success'
            ).then(() => {
              this.$router.push('/inicioPsico');
            });
          } else {
            // Otros mensajes del servidor
            Swal.fire(
              'Error',
              'Error desconocido: ' + response.data,
              'error'
            );
          }
        })
        .catch(error => {
          // Error en la petición
          console.error('Error en la petición:', error);
          Swal.fire(
            'Error',
            'Ocurrió un error al realizar el registro.',
            'error'
          );
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
  
  .background-image {
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      background-image: linear-gradient(to bottom, #ff5900, #c21c02);
      background-size: cover;
      z-index: -1;
    }

    .logo {
      position: absolute;
      top: 30px;
      left: 30px;
      width: 150px;
      height: auto;
    }
  
  .login-box {
  width: 300px;
  margin: 0 auto; /* Centra el cuadro horizontalmente */
  background-color: #f4f4f4;
  padding: 20px;
  border-radius: 10px;
  box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
  margin-top: 30px;
  margin-bottom: 30px;
  padding-left: 40px;
  padding-right: 40px;
}

.content {
  padding: 10px;
}

.title {
  margin-top: 0;
  color: #333;
}

.input-group {
  margin-bottom: 15px;
  position: relative;
}

.input-field {
  width: calc(100% - 10px);
  padding: 10px;
  border: none;
  border-bottom: 1px solid #ccc;
  background-color: transparent;
  border-radius: 0;
}

.input-field:focus {
  outline: none;
}

.input-line {
  position: absolute;
  bottom: 0;
  left: 0;
  width: 100%;
  height: 1px;
  background-color: #007bff;
  transition: all 0.3s ease;
}

.input-field:focus + .input-line {
  height: 2px;
}

.input-field::placeholder {
  color: #555;
}

.submit-button {
  background-color: #007bff;
  color: #fff;
  border: none;
  border-radius: 5px;
  padding: 10px 20px;
  cursor: pointer;
  transition: background-color 0.3s ease;
}

.submit-button:hover {
  background-color: #0056b3;
}

.titulo{
  padding: 5px;
  border-radius: 10px;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
  transition: all 0.3s ease-in-out; 
  margin-bottom: 10px;
}

.titulo:hover {
  box-shadow: 0 0 20px rgba(0, 0, 0, 0.3);
  transform: translateY(-5px); 
  border: 1px solid #ccc;
}

.titulo{
  margin: 0;
  font-weight: bold;
  color: #333;
  margin-bottom: 10px;
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
    </style>
    
    