$DEPLOYMENT = "licznik-deployment"
$TIMEOUT = "60s"

Write-Host "Weryfikacja wdrozenia: $DEPLOYMENT (timeout: $TIMEOUT)"

kubectl rollout status deployment/$DEPLOYMENT --timeout=$TIMEOUT

if ($LASTEXITCODE -eq 0) {
    Write-Host "OK - Wdrozenie zakonczone sukcesem!"
    kubectl get pods -l app=licznik
} else {
    Write-Host "BLAD - Wdrozenie nie zakonczone w czasie!"
    kubectl get pods -l app=licznik
    kubectl describe deployment $DEPLOYMENT | Select-Object -Last 20
    exit 1
}