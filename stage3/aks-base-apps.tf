#--------------------------------------------------------------------------------
# HELM
#--------------------------------------------------------------------------------

resource "kubernetes_namespace" "csi_driver_namespace" {
  metadata {
    name = "csi-driver"
  }
}

resource "helm_release" "csi_azure_release" {
  name       = "csi-keyvault"
  repository = "https://raw.githubusercontent.com/Azure/secrets-store-csi-driver-provider-azure/master/charts"
  chart      = "csi-secrets-store-provider-azure"
  # version    = "0.0.6"
  namespace = kubernetes_namespace.csi_driver_namespace.metadata[0].name

  # values = [
  #   "${file("values.yaml")}"
  # ] 

  // depends_on = [
  //   azurerm_kubernetes_cluster.aks,
  // ]
}

resource "helm_release" "pod_identity_release" {
  name       = "pod-identity"
  repository = "https://raw.githubusercontent.com/Azure/aad-pod-identity/master/charts"
  chart      = "aad-pod-identity"
  namespace  = "default"

  // depends_on = [
  //   azurerm_kubernetes_cluster.aks,
  // ]
}
