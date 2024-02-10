<template>
    <div class="payments-container">
        <div class="title">
            <h2>Pagos</h2>
        </div>
        <div class="payment-list">
            <ul>
                <li v-if="isVisible">Sin pagos</li>
                <li v-for="(item, index) in payments">
                    <div class="icon">
                        <svg-icon type="mdi" :path="item.icon"></svg-icon>
                    </div>
                    <div class="type">
                        {{ item.type }}
                    </div>
                    <div class="tip">
                        {{ item.tip }}
                        <button @click="removeItem(index)">
                            x
                        </button>
                    </div>
                </li>
            </ul>
        </div>
    </div>
</template>
    
<script lang="ts">

import { defineComponent } from 'vue'
import { ref } from "vue";
import SvgIcon from '@jamescoyle/vue-icon'
import { mdiWalletBifoldOutline } from '@mdi/js';
import { mdiCashMultiple } from '@mdi/js';
import { mdiCreditCardOutline } from '@mdi/js';
import { mdiCashFast } from '@mdi/js';
import { mdiWindowClose } from '@mdi/js';
import { directive as VNumber } from '@coders-tm/vue-number-format'

export default defineComponent({
    components: {
        SvgIcon
    },
    data() {
        return {
            walletIcon: mdiWalletBifoldOutline,
            cashIcon: mdiCashMultiple,
            cardIcon: mdiCreditCardOutline,
            otherIcon: mdiCashFast,
            cancelIcon: mdiWindowClose,
            isVisible: true,
            payments: [],
            totalPayments: 0,
            number: {
                decimal: '.',
                separator: ',',
                prefix: '$',
                precision: 2,
            }
        }
    },
    directives: {
        number: VNumber,
    },
    methods: {
        toggleVisibility() {
            
            if (this.payments.length > 0) {
                this.isVisible = false;
            }else{
                this.isVisible = true;
            }
        },
        newPaymentItem(paymentInfo) {
            
            this.payments.push(paymentInfo);
            this.toggleVisibility();
            this.totalPayments = 0;

            for (let i = 0; i < this.payments.length; i++) {
                 this.totalPayments = parseInt(this.totalPayments) + parseInt(this.payments[i].tip);
            }

            this.$emit('totalPayments', {type: "n/a", paymentlist: this.payments, totalpaymets:  this.totalPayments});


        },
        removeItem(index){
            this.payments.splice(index, 1);
            this.toggleVisibility();

            this.totalPayments = 0;

            for (let i = 0; i < this.payments.length; i++) {
                 this.totalPayments = parseInt(this.totalPayments) + parseInt(this.payments[i].tip);
            }
            this.$emit('totalPayments', {type: "n/a", paymentlist: this.payments, totalpaymets:  this.totalPayments});

        },
        updateList(payments){
            
            this.payments = payments;
            this.toggleVisibility();

            this.totalPayments = 0;

            for (let i = 0; i < this.payments.length; i++) {
                 this.totalPayments = parseInt(this.totalPayments) + parseInt(this.payments[i].tip);
            }
            this.$emit('totalPayments', {type: "saved", paymentlist: this.payments, totalpaymets:  this.totalPayments});

        }
    },
    props: {
        paymentData: {
            type: Object
        },
        newPayments: {
            type: Object
        }
    },
    watch: {
        paymentData: {
            immediate: true, // Esto asegura que se ejecute el watcher tan pronto como se inicialice el componente
            handler(newValue, olvValue) {
                
                // Aquí puedes ejecutar la función que desees al recibir un nuevo valor en la prop
                if(Object.keys(newValue).length > 0){
                    this.newPaymentItem(newValue);
                }
            }
        },
        newPayments: {
            immediate: true, // Esto asegura que se ejecute el watcher tan pronto como se inicialice el componente
            handler(newValue, olvValue) {
                
                // Aquí puedes ejecutar la función que desees al recibir un nuevo valor en la prop
                if(Object.keys(newValue).length > 0){

                    if(newValue.status == "payment"){
                        this.updateList(newValue.payments);
                    }
                }
            }
        }
    }

})

</script>
    