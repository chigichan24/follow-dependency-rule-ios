protoc proto/ParrotService.proto \
  --swift_out=./followDependencyApp/data/gen --swift_opt=Visibility=Public \
  --grpc-swift_out=./followDependencyApp/data/gen --grpc-swift_opt=Visibility=Public,Server=false,Client=true,TestClient=true
