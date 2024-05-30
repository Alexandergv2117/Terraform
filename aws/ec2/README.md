# Crear instancia EC2 en AWS con Terraform

## Crear un par de claves ssh
  
```bash
aws ec2 create-key-pair --key-name blackwell --query 'KeyMaterial' --output text > ~/.ssh/blackwell.pem
```

## Darle permisos

```bash
chmod 600 ~/.ssh/blackwell.pem
```