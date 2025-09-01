#!/bin/bash
yum update -y
yum install -y httpd mysql

# Configurar Apache
systemctl start httpd
systemctl enable httpd

# Crear página web simple
cat << 'EOF' > /var/www/html/index.html
<!DOCTYPE html>
<html>
<head>
    <title>3-Tier Web Application</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 40px; }
        .container { max-width: 600px; margin: 0 auto; }
        .header { background: #f4f4f4; padding: 20px; border-radius: 5px; }
        .info { margin: 20px 0; padding: 15px; background: #e9f7ef; border-radius: 5px; }
    </style>
</head>
<body>
    <div class="container">
        <div class="header">
            <h1>🚀 3-Tier Web Application</h1>
            <p>Successfully deployed with Terraform!</p>
        </div>
        <div class="info">
            <h3>Architecture Components:</h3>
            <ul>
                <li><strong>Tier 1:</strong> Application Load Balancer (ALB)</li>
                <li><strong>Tier 2:</strong> EC2 Auto Scaling Group</li>
                <li><strong>Tier 3:</strong> RDS MySQL Database</li>
            </ul>
        </div>
        <div class="info">
            <h3>Instance Information:</h3>
            <p><strong>Instance ID:</strong> $(curl -s http://169.254.169.254/latest/meta-data/instance-id)</p>
            <p><strong>Availability Zone:</strong> $(curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone)</p>
            <p><strong>Database Endpoint:</strong> ${db_endpoint}</p>
        </div>
    </div>
</body>
</html>
EOF

# Configurar health check endpoint
cat << 'EOF' > /var/www/html/health
OK
EOF

# Restart Apache para aplicar cambios
systemctl restart httpd