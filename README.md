# Hub Proto Contracts

Shared Protocol Buffer contracts for Hub Investments microservices.

## 📋 Overview

This repository contains all gRPC service definitions and protobuf messages used across the Hub Investments platform. It serves as the single source of truth for service contracts.

## 🏗️ Structure

```
hub-proto-contracts/
├── auth/                    # Authentication & User services
│   ├── auth_service.proto
│   ├── user_service.proto
│   └── common.proto
├── monolith/                # Monolith services
│   ├── balance_service.proto
│   ├── market_data_service.proto
│   ├── order_service.proto
│   ├── portfolio_service.proto
│   ├── position_service.proto
│   └── common.proto
├── common/                  # Shared types
│   └── common.proto
└── generate.sh              # Code generation script
```

## 🚀 Usage

### As a Go Module

```bash
# Add to your service
go get github.com/RodriguesYan/hub-proto-contracts@latest

# Import in your code
import (
    authpb "github.com/RodriguesYan/hub-proto-contracts/auth"
    monolithpb "github.com/RodriguesYan/hub-proto-contracts/monolith"
)
```

### Generating Code

```bash
# Generate Go code from proto files
./generate.sh
```

## 📦 Services

### Authentication Services (`auth/`)
- **AuthService**: User authentication (Login, ValidateToken)
- **UserService**: User management operations

### Monolith Services (`monolith/`)
- **BalanceService**: Account balance management
- **MarketDataService**: Market data and quotes
- **OrderService**: Order submission and management
- **PortfolioService**: Portfolio summary and analytics
- **PositionService**: Position tracking and management

## 🔄 Versioning

This repository follows [Semantic Versioning](https://semver.org/):

- **MAJOR**: Incompatible API changes
- **MINOR**: Backwards-compatible functionality additions
- **PATCH**: Backwards-compatible bug fixes

### Version History

- **v1.0.0** (2025-10-20): Initial release with all service contracts

## 🛠️ Development

### Prerequisites

```bash
# Install Protocol Buffers compiler
brew install protobuf

# Install Go plugins
go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
```

### Adding New Services

1. Create proto file in appropriate directory
2. Run `./generate.sh` to generate Go code
3. Commit changes
4. Tag new version: `git tag v1.x.0`
5. Push: `git push origin main --tags`

### Making Breaking Changes

1. Increment MAJOR version
2. Update CHANGELOG.md
3. Notify all service teams
4. Coordinate migration

## 📝 Best Practices

### Backwards Compatibility

- ✅ **DO**: Add new fields with default values
- ✅ **DO**: Add new RPC methods
- ✅ **DO**: Deprecate old fields (don't remove)
- ❌ **DON'T**: Remove fields
- ❌ **DON'T**: Change field types
- ❌ **DON'T**: Rename fields

### Field Numbering

- Reserve field numbers 1-15 for frequently used fields (1-byte encoding)
- Never reuse field numbers
- Document reserved field numbers

## 🔗 Related Repositories

- [hub-api-gateway](https://github.com/RodriguesYan/hub-api-gateway) - API Gateway
- [hub-user-service](https://github.com/RodriguesYan/hub-user-service) - User Service
- [HubInvestmentsServer](https://github.com/RodriguesYan/HubInvestmentsServer) - Monolith

## 📄 License

Private - Hub Investments Platform

## 🤝 Contributing

1. Create feature branch
2. Make changes to proto files
3. Run `./generate.sh`
4. Test with dependent services
5. Create pull request
6. After merge, tag new version

## 📞 Support

For questions or issues, contact the Platform Team.

