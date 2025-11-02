# vLLM의 OpenAI 호환 서버 이미지 (CUDA 12.x 기반)
# 3090 + 최신 드라이버 조합에서 안정적입니다.
FROM vllm/vllm-openai:latest

# (선택) 한국 미러 등 네트워크 환경 최적화가 필요하면 여기서 설정

# 런타임 기본 설정
ENV VLLM_NO_USAGE_STATS=1 \
    HUGGINGFACE_HUB_CACHE=/data/hf-cache \
    HF_HOME=/data/hf-cache \
    TRANSFORMERS_CACHE=/data/hf-cache

# 모델/캐시/로그 디렉토리 준비
RUN mkdir -p /data/hf-cache /app
WORKDIR /app

# 헬스체크용 간단 스크립트 (선택)
RUN printf '#!/usr/bin/env bash\ncurl -sf http://localhost:8000/v1/models >/dev/null\n' > /healthcheck.sh \
 && chmod +x /healthcheck.sh

# 기본 엔트리포인트는 docker-compose에서 vllm serve로 지정
