---
title: Storage, Databases & Scaling
tags: [storage, scaling]
---

# Storage Solutions and Database Architecture

Storage is fundamental to any application. Cloud platforms offer diverse storage options ranging from object storage to managed databases, each optimized for different use cases.

## Storage Types

### Object Storage
Ideal for unstructured data like images, videos, and backups. Objects are stored with metadata and accessed via HTTP APIs.

- **Amazon S3**: Industry-leading object storage service
- **Google Cloud Storage**: Multi-region and dual-region options
- **Azure Blob Storage**: Hot, cool, and archive tiers

### Block Storage
High-performance storage attached to compute instances. Used for databases, enterprise applications, and file systems.

- **Amazon EBS**: Elastic block storage volumes
- **Google Persistent Disk**: Zonal and regional options
- **Azure Managed Disks**: Multiple performance tiers

### File Storage
Network-attached storage for shared file systems. Supports standard protocols like NFS and SMB.

- **Amazon EFS**: Scalable file system for Linux workloads
- **Azure Files**: Fully managed file shares

## Database Services

### Relational Databases (RDBMS)
Structured data with ACID compliance. Managed services handle patching, backups, and replication.

- **Amazon RDS**: MySQL, PostgreSQL, Oracle, SQL Server
- **Cloud SQL**: Google Cloud's managed relational database
- **Azure Database**: Managed MySQL, PostgreSQL, SQL Server

### NoSQL Databases
Flexible schemas for unstructured and semi-structured data. Optimized for specific access patterns.

- **DynamoDB**: Fully managed NoSQL with automatic scaling
- **MongoDB Atlas**: Document database as a service
- **Amazon DocumentDB**: MongoDB-compatible database

### In-Memory Databases
Ultra-fast data access for caching and real-time analytics.

- **Amazon ElastiCache**: Redis and Memcached
- **Google Cloud Memorystore**: Managed Redis and Memcached

## Database Scaling Strategies

### Read Replicas
Create read-only copies to distribute query load. Improves performance for read-heavy workloads.

### Sharding
Partition data across multiple database instances. Enables horizontal scaling but increases complexity.

### Connection Pooling
Reuse database connections to reduce overhead. Essential for applications with many short-lived queries.

## Backup and Recovery

- **Automated backups**: Scheduled snapshots with point-in-time recovery
- **Cross-region replication**: Disaster recovery capability
- **Point-in-time recovery**: Restore to any second within the retention period

## Data Security

Encrypt data at rest and in transit. Use IAM policies for access control and audit logging for compliance.

## Related Topics

- [Security & Compliance](./02-security.md) — Controls for encryption, IAM, and auditing of storage systems
- [Compute Resources and Containerization](../01-concepts/02-compute.md) — Workload scaling patterns that drive storage choices
