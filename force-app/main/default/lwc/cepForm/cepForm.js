import { LightningElement } from 'lwc';
import buscarEndereco from '@salesforce/apex/ViaCepService.buscarEndereco';

export default class CepForm extends LightningElement {
    cep = '';
    endereco = null;

    handleCepChange(event) {
        this.cep = event.target.value;
    }

    handleBuscar() {
        buscarEndereco({ cep: this.cep })
            .then(result => {
                this.endereco = result;
            })
            .catch(error => {
                console.error(error);
                this.endereco = null;
            });
    }
}