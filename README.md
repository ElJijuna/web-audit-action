# Web Audit Action

Esta GitHub Action ejecuta una auditoría web y guarda el reporte en otro repositorio (`MonitoringTool-DB`).

## Requerido

Crea el repositorio MonitoringTool-DB en tu github y un token necesario para poder escribir los reportes aqui.

## Inputs

| Nombre  | Descripción                             | Obligatorio | Valor por defecto |
|---------|-----------------------------------------|-------------|-------------------|
| runtime | Gestor de paquetes (`npm`, `bun`, etc.) | No          | `npm`             |
| token   | Token para push a MonitoringTool-DB     | Sí          | -                 |

## Ejemplo de uso

```yaml
- uses: ElJijuna/web-audit-action@v2.0.1
  with:
    runtime: npm
    token: ${{ secrets.MONITORING_TOOL_DB }}
