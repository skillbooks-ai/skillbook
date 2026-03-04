---
title: Security & Compliance
tags: [security, networking, compliance]
---

# Cloud Security and Compliance

Security is a shared responsibility between the cloud provider and the customer. Understanding your responsibilities and implementing defense-in-depth strategies is essential.

## Shared Responsibility Model

### Provider Responsibilities
- Physical infrastructure security
- Network infrastructure
- Hypervisor security
- Hardware maintenance

### Customer Responsibilities
- Data classification and encryption
- Identity and access management
- Application security
- Operating system patches
- Network configuration

## Identity and Access Management (IAM)

### Principle of Least Privilege
Grant users only the permissions required for their job function. Regularly review and remove unnecessary access.

### IAM Best Practices

- Use IAM roles instead of long-term credentials
- Enable multi-factor authentication (MFA)
- Implement password policies
- Use service control policies for organization-wide guardrails

## Network Security

### Firewall Rules
Configure security groups and network ACLs to restrict traffic. Default to deny all, then explicitly allow required traffic.

### DDoS Protection
Use managed DDoS mitigation services to protect against volumetric attacks. Configure rate limiting and traffic filtering.

### Private Connectivity
Use VPC endpoints and private links to access cloud services without internet exposure. Avoid public IPs for sensitive workloads.

## Data Encryption

### Encryption at Rest
Encrypt storage volumes, databases, and object storage. Use customer-managed keys (CMK) for additional control.

### Encryption in Transit
Enforce TLS for all network communication. Use certificate management services for automated rotation.

### Key Management
- Cloud KMS: Managed key storage and lifecycle
- Hardware Security Modules (HSM): FIPS 140-2 Level certified key protection

## Compliance Frameworks

Cloud providers maintain certifications for various compliance requirements:

- **SOC 2**: Security, availability, and confidentiality
- **ISO 27001**: Information security management
- **GDPR**: European data protection
- **HIPAA**: Healthcare data in the US
- **PCI DSS**: Payment card industry standards

## Security Monitoring

### Logging and Auditing
Enable CloudTrail, AWS Config, or equivalent services. Log all API calls and resource changes.

### Intrusion Detection
Use managed threat detection services to identify suspicious activity. Configure alerts for security events.

### Incident Response
Develop and test incident response procedures. Maintain runbooks for common security scenarios.

## Vulnerability Management

- Scan container images for vulnerabilities
- Patch operating systems regularly
- Use managed services that handle underlying security
- Conduct regular penetration testing

## Related Topics

Return to networking concepts for deeper coverage of VPC security and network segmentation strategies.
