---
title: Networking & VPC
tags: [networking, vpc, security]
---

# Networking & Virtual Private Clouds

Network architecture forms the backbone of any cloud infrastructure. Understanding VPC design, subnetting, and security groups is essential for building secure, scalable cloud environments.

## Virtual Private Cloud (VPC) Fundamentals

A VPC is an isolated virtual network within a cloud region. It provides complete control over your network environment, including IP address ranges, subnets, routing tables, and network gateways.

### VPC Components

- **CIDR Block**: The IP address range (e.g., 10.0.0.0/16)
- **Subnets**: Smaller network segments within the VPC
- **Route Tables**: Determine where network traffic is directed
- **Internet Gateway**: Enables internet access for resources
- **NAT Gateway**: Allows private subnet instances to access the internet

## Subnet Design Strategies

### Public Subnets
Resources with public IP addresses that can communicate directly with the internet. Typically used for load balancers, web servers, and bastion hosts.

### Private Subnets
Resources without direct internet access. Used for application servers, databases, and internal services. Outbound traffic routes through a NAT gateway.

### Database Subnets
Isolated subnets often spanning multiple availability zones for high availability. No direct internet access permitted.

## Security Groups

Security groups act as virtual firewalls at the instance level. They control inbound and outbound traffic based on rules you define.

### Best Practices

- Follow the principle of least privilege
- Restrict SSH/RDP access to specific IP ranges
- Use security groups for layer-based segmentation
- Regularly audit rules for unnecessary permissions

## Network Access Control Lists (NACLs)

NACLs provide an additional layer of security at the subnet level. Unlike security groups, NACLs are stateless and can deny specific traffic.

## VPC Peering

VPC peering enables direct traffic routing between two VPCs, even across different accounts or regions. It's a cost-effective way to enable private communication.

## VPN and Direct Connect

- **VPN**: Encrypted tunnel over the internet for hybrid cloud setups
- **Direct Connect**: Dedicated physical connection for higher bandwidth and lower latency

## Related Topics

Continue to security infrastructure to learn about advanced networking security measures.
