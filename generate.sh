#!/bin/bash

# Proto Generation Script for hub-proto-contracts
# Generates Go code from all proto files

set -e  # Exit on error

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

echo -e "${YELLOW}🔨 Generating Go code from proto files...${NC}"
echo ""

# Check if protoc is installed
if ! command -v protoc &> /dev/null; then
    echo -e "${RED}❌ protoc not found. Please install Protocol Buffers compiler.${NC}"
    echo "   brew install protobuf  # macOS"
    exit 1
fi

# Check if Go plugins are installed
if ! command -v protoc-gen-go &> /dev/null; then
    echo -e "${YELLOW}⚠️  protoc-gen-go not found. Installing...${NC}"
    go install google.golang.org/protobuf/cmd/protoc-gen-go@latest
fi

if ! command -v protoc-gen-go-grpc &> /dev/null; then
    echo -e "${YELLOW}⚠️  protoc-gen-go-grpc not found. Installing...${NC}"
    go install google.golang.org/grpc/cmd/protoc-gen-go-grpc@latest
fi

# Generate common first (no dependencies)
echo -e "${YELLOW}📂 Generating common...${NC}"
cd common
for proto_file in *.proto; do
    if [ -f "$proto_file" ]; then
        echo "   Processing: $proto_file"
        protoc --go_out=. --go-grpc_out=. \
            --go_opt=paths=source_relative \
            --go-grpc_opt=paths=source_relative \
            "$proto_file"
    fi
done
cd ..
echo -e "${GREEN}✅ common complete${NC}"
echo ""

# Generate auth and monolith (depend on common)
for dir in auth monolith; do
    if [ -d "$dir" ] && [ "$(ls -A $dir/*.proto 2>/dev/null)" ]; then
        echo -e "${YELLOW}📂 Generating $dir...${NC}"
        cd "$dir"
        
        for proto_file in *.proto; do
            if [ -f "$proto_file" ]; then
                echo "   Processing: $proto_file"
                protoc --go_out=. --go-grpc_out=. \
                    --go_opt=paths=source_relative \
                    --go-grpc_opt=paths=source_relative \
                    -I. -I.. \
                    "$proto_file"
            fi
        done
        
        cd ..
        echo -e "${GREEN}✅ $dir complete${NC}"
        echo ""
    fi
done

# Count generated files
total_pb=$(find . -name "*.pb.go" | wc -l | tr -d ' ')
total_grpc=$(find . -name "*_grpc.pb.go" | wc -l | tr -d ' ')

echo "═══════════════════════════════════════"
echo "  Summary"
echo "═══════════════════════════════════════"
echo -e "${GREEN}✅ Generation complete${NC}"
echo "   Generated $total_pb .pb.go files"
echo "   Generated $total_grpc _grpc.pb.go files"
echo ""
echo -e "${GREEN}🎉 Done!${NC}"

