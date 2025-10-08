FROM alpine:latest
ADD https://raw.githubusercontent.com/ElJijuna/Bash-Scripts/refs/heads/main/web-audit-report.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]