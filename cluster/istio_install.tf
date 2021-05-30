resource "null_resource" "install_istio" {
  provisioner "local-exec" {
    command = "istioctl install -f \"istio-operator.yaml\" --kubeconfig /root/.kube/config -y"
  }
  depends_on = [   
      aws_eks_cluster.istio-cluster,
      aws_eks_node_group.demo
  ]
}