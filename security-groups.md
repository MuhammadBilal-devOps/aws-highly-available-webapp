# Security Groups Reference — Bilal AWS Project

## SG-ELB (Load Balancer)
| Direction | Protocol | Port | Source       | Purpose             |
|-----------|----------|------|--------------|---------------------|
| Inbound   | HTTP     | 80   | 0.0.0.0/0    | Public web traffic  |
| Outbound  | All      | All  | 0.0.0.0/0    | Default             |

## SG-Bastion (Bastion Host)
| Direction | Protocol | Port | Source       | Purpose             |
|-----------|----------|------|--------------|---------------------|
| Inbound   | RDP      | 3389 | My IP only   | Admin RDP access    |
| Outbound  | All      | All  | 0.0.0.0/0    | Default             |

## SG-WebServer (Private EC2)
| Direction | Protocol | Port | Source       | Purpose                    |
|-----------|----------|------|--------------|----------------------------|
| Inbound   | HTTP     | 80   | SG-ELB       | Traffic from Load Balancer |
| Inbound   | RDP      | 3389 | SG-Bastion   | Admin access via Bastion   |
| Outbound  | All      | All  | 0.0.0.0/0    | Default                    |

## SG-RDS (Database)
| Direction | Protocol | Port | Source        | Purpose                   |
|-----------|----------|------|---------------|---------------------------|
| Inbound   | MySQL    | 3306 | SG-WebServer  | DB access from web servers|
| Outbound  | All      | All  | 0.0.0.0/0     | Default                   |

## Key Security Principle
- Web servers have NO public IP
- RDS has NO public access
- Only ALB accepts internet traffic
- Bastion Host is the ONLY way to RDP into private instances
