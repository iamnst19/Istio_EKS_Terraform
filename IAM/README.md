# IAM

To authenticate the users with the EKS cluster, a role was created (eks-admin) and a user (jenkins) was created in AWS IAM. Policies (role_policy.json) were attached to the user and a trust relation(trust_relation_policy.json) was created between the user and the role.

To autheticate the user with cluster, the aws-auth configmap was edited to include the role entry.

```
- rolearn: ${var.role}
      username: eks-admin
      groups:
        - system:masters
```

As the role belongs to the admin group, users that have a trust relation with this role have access to the cluster as admins.
