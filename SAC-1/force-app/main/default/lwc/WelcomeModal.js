import { LightningElement, track } from 'lwc';

export default class WelcomePopup extends LightningElement {
    isModalOpen = false;

    openModal() {
        this.isModalOpen = true;
    }

    closeModal() {
        this.isModalOpen = false;
    }

    handleOverlayClick(event) {
        if (event.target.className === 'modal-overlay') {
            this.closeModal();
        }
    }
}