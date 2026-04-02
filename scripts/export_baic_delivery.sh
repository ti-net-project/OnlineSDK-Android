#!/usr/bin/env bash
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT_DIR"

./gradlew -PbuildProfile=baic :onlineservicesdk:clean cleanBaicDelivery exportBaicDelivery "$@"

DELIVERY_DIR="$ROOT_DIR/build/deliveries"
LATEST_ZIP="$(ls -1t "$DELIVERY_DIR"/OnlineSDK-Android-BAIC-*-delivery.zip 2>/dev/null | head -n 1 || true)"

if [[ -z "$LATEST_ZIP" ]]; then
  echo "未找到导出的交付包，请检查 Gradle 输出。" >&2
  exit 1
fi

echo
echo "交付包已生成：$LATEST_ZIP"
echo "解压后请查看 README-Usage.md"
