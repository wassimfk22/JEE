/**
 * Custom Modern Modal Logic - UnivSalles
 */

(function() {
    function initModal() {
        if (document.getElementById('customModal')) return;

        const modalHTML = `
            <div id="customModal" class="modal-overlay">
                <div class="modal-container">
                    <div class="modal-title" id="modalTitle">Confirmation</div>
                    <div class="modal-body" id="modalBody">Êtes-vous sûr de vouloir continuer ?</div>
                    <div class="modal-footer">
                        <button class="btn btn-secondary modal-btn" id="modalCancel">Annuler</button>
                        <button class="btn btn-primary modal-btn" id="modalConfirm">Confirmer</button>
                    </div>
                </div>
            </div>
        `;

        document.body.insertAdjacentHTML('beforeend', modalHTML);

        const overlay = document.getElementById('customModal');
        const titleEl = document.getElementById('modalTitle');
        const bodyEl = document.getElementById('modalBody');
        const cancelBtn = document.getElementById('modalCancel');
        const confirmBtn = document.getElementById('modalConfirm');

        let currentCallback = null;

        window.customConfirm = function(message, callback) {
            titleEl.textContent = 'Confirmation requise';
            bodyEl.textContent = message;
            currentCallback = callback;
            cancelBtn.style.display = 'flex';
            confirmBtn.textContent = 'Confirmer';
            confirmBtn.className = 'btn btn-primary modal-btn';
            if (message.toLowerCase().includes('supprimer') || message.toLowerCase().includes('annuler')) {
                confirmBtn.className = 'btn btn-danger modal-btn';
            }
            overlay.classList.add('active');
        };

        window.customAlert = function(message) {
            titleEl.textContent = 'Notification';
            bodyEl.textContent = message;
            currentCallback = null;
            cancelBtn.style.display = 'none';
            confirmBtn.textContent = 'OK';
            confirmBtn.className = 'btn btn-primary modal-btn';
            overlay.classList.add('active');
        };

        cancelBtn.onclick = () => overlay.classList.remove('active');
        confirmBtn.onclick = () => {
            overlay.classList.remove('active');
            if (currentCallback) currentCallback();
        };

        document.addEventListener('keydown', (e) => {
            if (e.key === 'Escape') overlay.classList.remove('active');
        });
    }

    if (document.readyState === 'loading') {
        document.addEventListener('DOMContentLoaded', initModal);
    } else {
        initModal();
    }
})();
