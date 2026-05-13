/**
 * Custom Modern Modal Logic - UnivSalles
 */

(function() {
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

    // Inject modal into body
    document.body.insertAdjacentHTML('beforeend', modalHTML);

    const overlay = document.getElementById('customModal');
    const titleEl = document.getElementById('modalTitle');
    const bodyEl = document.getElementById('modalBody');
    const cancelBtn = document.getElementById('modalCancel');
    const confirmBtn = document.getElementById('modalConfirm');

    let currentCallback = null;

    function showModal(title, message, callback, isAlert = false) {
        titleEl.textContent = title;
        bodyEl.textContent = message;
        currentCallback = callback;

        if (isAlert) {
            cancelBtn.style.display = 'none';
            confirmBtn.textContent = 'OK';
            confirmBtn.className = 'btn btn-primary modal-btn';
        } else {
            cancelBtn.style.display = 'flex';
            confirmBtn.textContent = 'Confirmer';
            confirmBtn.className = 'btn btn-primary modal-btn';
            
            // Si c'est une action de suppression, on peut mettre le bouton en rouge
            if (message.toLowerCase().includes('supprimer') || message.toLowerCase().includes('annuler')) {
                confirmBtn.className = 'btn btn-danger modal-btn';
            }
        }

        overlay.classList.add('active');
    }

    function hideModal() {
        overlay.classList.remove('active');
    }

    cancelBtn.onclick = hideModal;
    confirmBtn.onclick = function() {
        hideModal();
        if (currentCallback) currentCallback();
    };

    // Close on escape key
    document.addEventListener('keydown', (e) => {
        if (e.key === 'Escape' && overlay.classList.contains('active')) {
            hideModal();
        }
    });

    // Public API
    window.customConfirm = function(message, callback) {
        showModal('Confirmation Required', message, callback, false);
    };

    window.customAlert = function(message) {
        showModal('Notification', message, null, true);
    };

})();
