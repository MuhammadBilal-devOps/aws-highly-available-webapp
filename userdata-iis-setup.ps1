<powershell>
# ============================================================
# IIS Web Server Setup Script — AWS EC2 Windows
# Project: Highly Available Web Application
# Author: Muhammad Bilal
# ============================================================

# Install IIS Web Server
Install-WindowsFeature -Name Web-Server -IncludeManagementTools

# Start IIS service
Start-Service -Name W3SVC
Set-Service -Name W3SVC -StartupType Automatic

# Get instance metadata
$instanceId   = (Invoke-RestMethod -Uri "http://169.254.169.254/latest/meta-data/instance-id")
$az           = (Invoke-RestMethod -Uri "http://169.254.169.254/latest/meta-data/placement/availability-zone")
$privateIp    = (Invoke-RestMethod -Uri "http://169.254.169.254/latest/meta-data/local-ipv4")

# Create project web page
$htmlContent = @"
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>AWS Capstone Project - Muhammad Bilal</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body {
            font-family: 'Segoe UI', sans-serif;
            background: #f0f4f8;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
        }
        .card {
            background: white;
            border-radius: 12px;
            padding: 48px;
            max-width: 700px;
            width: 100%;
            box-shadow: 0 4px 24px rgba(0,0,0,0.08);
        }
        h1 { color: #1a2b3c; font-size: 2rem; margin-bottom: 6px; }
        .subtitle { color: #ff9900; font-size: 1.1rem; margin-bottom: 32px; font-weight: 600; }
        .section {
            border-left: 4px solid #ff9900;
            padding-left: 20px;
            margin-bottom: 28px;
        }
        .section h2 { color: #1a2b3c; margin-bottom: 12px; font-size: 1rem; text-transform: uppercase; letter-spacing: 1px; }
        ul { list-style: none; }
        ul li { padding: 5px 0; color: #4a5568; font-size: 0.95rem; }
        ul li strong { color: #1a2b3c; }
        .instance-info {
            background: #1a2b3c;
            color: #ff9900;
            border-radius: 8px;
            padding: 16px 20px;
            font-family: 'Courier New', monospace;
            font-size: 0.85rem;
            margin-top: 24px;
        }
        .instance-info p { margin-bottom: 4px; color: #cdd8e3; }
        .instance-info span { color: #ff9900; }
        footer { text-align: center; color: #a0aec0; font-size: 0.8rem; margin-top: 28px; }
    </style>
</head>
<body>
    <div class="card">
        <h1>Muhammad Bilal</h1>
        <p class="subtitle">AWS Final Project</p>

        <div class="section">
            <h2>Project Objective: Highly Available Web Architecture</h2>
            <p style="color:#4a5568; margin-bottom:12px;">This project demonstrates a secure and scalable infrastructure deployed on AWS US East (N. Virginia).</p>
            <ul>
                <li><strong>Infrastructure:</strong> Custom VPC with Public & Private Subnets.</li>
                <li><strong>Security:</strong> Multi-tier Security Groups & Bastion Host access.</li>
                <li><strong>Compute:</strong> Auto Scaling Group with Windows EC2 (IIS Server).</li>
                <li><strong>Availability:</strong> Internet-facing Application Load Balancer.</li>
                <li><strong>Database:</strong> Amazon RDS (MySQL) in a private subnet.</li>
            </ul>
        </div>

        <div class="instance-info">
            <p>Instance ID:   <span>$instanceId</span></p>
            <p>Private IP:    <span>$privateIp</span></p>
            <p>AZ:            <span>$az</span></p>
        </div>

        <footer>Deployed via AWS AMI & Launch Templates | 2026</footer>
    </div>
</body>
</html>
"@

# Write to IIS default web root
$htmlContent | Out-File -FilePath "C:\inetpub\wwwroot\index.html" -Encoding utf8 -Force

Write-Host "IIS setup complete. Website deployed successfully."
</powershell>
