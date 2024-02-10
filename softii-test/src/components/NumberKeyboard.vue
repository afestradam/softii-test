<template>
  <div class="keyboard-container">
    <div class="keyboard">
      <div class="value">
        <span>{{ inputSymbol }}</span>
        <input type="text" v-model="inputValue" v-number="number" disabled>
        <button @click="ereaseCharacter">
          <svg-icon type="mdi" :path="backSpaceIcon"></svg-icon>
        </button>
      </div>
      <div class="keys">
        <div class="row">
          <button @click="writeNumber(1)">1</button>
          <button @click="writeNumber(2)">2</button>
          <button @click="writeNumber(3)">3</button>
        </div>
        <div class="row">
          <button @click="writeNumber(4)">4</button>
          <button @click="writeNumber(5)">5</button>
          <button @click="writeNumber(6)">6</button>
        </div>
        <div class="row">
          <button @click="writeNumber(7)">7</button>
          <button @click="writeNumber(8)">8</button>
          <button @click="writeNumber(9)">9</button>
        </div>
        <div class="row">
          <button @click="writeNumber('00')">00</button>
          <button @click="writeNumber(0)">0</button>
          <button @click="sendData()" class="send" :disabled="isDisabled">
            <svg-icon type="mdi" :path="checkIcon"></svg-icon>
          </button>
        </div>
      </div>
    </div>
  </div>
</template>
  
<script lang="ts">

import { defineComponent } from 'vue'
import { ref } from "vue";
import SvgIcon from '@jamescoyle/vue-icon'
import { mdiBackspaceOutline } from '@mdi/js'
import { mdiCheckCircleOutline } from '@mdi/js'
import { directive as VNumber } from '@coders-tm/vue-number-format'

/*const cashValue = ref('');
const path = mdiPencil;
const disabled = ref(true);*/

export default defineComponent({
  components: {
    SvgIcon
  },
  data() {
    return {
      backSpaceIcon: mdiBackspaceOutline,
      checkIcon: mdiCheckCircleOutline,
      inputValue: 0,
      inputSymbol: "$",
      inputName: "payment",
      isDisabled: false,
      number: {
        decimal: '.',
        separator: ',',
        prefix: '',
        precision: 2
      }
    }
  },
  directives: {
    number: VNumber,
  },
  methods: {
    writeNumber(value) {
      if (this.inputValue == 0) {
        this.inputValue = value;
      } else {
        this.inputValue = this.inputValue + "" + value;
      }
    },
    ereaseCharacter() {
      if (this.inputValue > 0 || this.inputValue != 0) {
        if (this.inputValue.length > 1) {
          this.inputValue = this.inputValue.slice(0, -1);
        } else {
          this.inputValue = 0;
        }
      }
      if (this.inputValue == "") {
        this.inputValue = 0;
      }
    },
    sendData() {
      if (this.inputValue != 0 && (this.inputName == "total" || this.inputName == "split")) {
        this.$emit('keyValue', { type: "fill", field: this.inputName, value: this.inputValue });
        this.inputName = "payment"
        this.inputSymbol = "$";
        this.inputValue = 0;
      }

    },
    sendDataForPay() {
      
      if (this.inputName == "payment") {
        this.$emit('keyValue', { type: "n/a", field: "n/a", value: this.inputValue });
        this.inputValue = 0;
      }

    }
  },

  props: {
    inputToEdit: {
      type: String
    },
    newPayment: {
      type: String
    }
  },
  watch: {
    inputToEdit: {
      immediate: true, // Esto asegura que se ejecute el watcher tan pronto como se inicialice el componente
      handler(newValue, olvValue) {

        // Aquí puedes ejecutar la función que desees al recibir un nuevo valor en la prop
        if (newValue != "") {
          this.inputName = newValue;

          if (this.inputName == "total") {
            this.inputSymbol = "$";
            this.isDisabled = false;
          }

          if (this.inputName == "split") {
            this.inputSymbol = "#"
            this.isDisabled = false;
          }

          if (this.inputName == "payment") {
            this.isDisabled = true;
          }

        }
      }
    },
    newPayment: {
      immediate: true, // Esto asegura que se ejecute el watcher tan pronto como se inicialice el componente
      handler(newValue, olvValue) {
        
        // Aquí puedes ejecutar la función que desees al recibir un nuevo valor en la prop
        if (newValue != "") {
          this.sendDataForPay();
        }
      }
    }
  }
})

</script>
  