resource "null_resource" "install_istio" {
  provisioner "local-exec" {
    command = "istioctl install -f \"istio-operator.yaml\" --kubeconfig var.kubeconfig -y"
  }
  depends_on = [
      local_file.setup_istio_config,
      aws_eks_cluster.istio-cluster,
      aws_eks_node_group.demo
  ]
}