# 📊 Web Audit Report Action

Genera un reporte de auditoría de seguridad para proyectos JavaScript/TypeScript utilizando `npm audit` u otras herramientas de runtime. Este reporte se guarda como archivo JSON y puede ser publicado automáticamente en otro repositorio.

---

## 🚀 ¿Qué hace esta Action?

- Ejecuta un script remoto que genera un reporte de auditoría.
- Soporta múltiples runtimes: `npm`, `bun`, `pnpm`, `yarn`.
- Guarda el reporte como artefacto.
- Publica el reporte en un repositorio externo (ideal para monitoreo continuo).

---

## 🔧 Inputs

| Nombre        | Descripción                                                                 | Requerido | Default         |
|---------------|------------------------------------------------------------------------------|-----------|-----------------|
| `runtime`     | Runtime para ejecutar el script de auditoría (`npm`, `bun`, `pnpm`, `yarn`) | ✅        | `npm`           |
| `report_name` | Nombre base del archivo de reporte generado                                 | ✅        | `react-base-app`|

---

## 📦 Output

- Archivo JSON con el nombre: `{report_name}--web-audit.json`
- Guardado como artefacto llamado `audit-report`

---

## 🧪 Ejemplo de uso

```yaml
name: Web Audit Report

on:
  workflow_dispatch:

jobs:
  audit:
    uses: ElJijuna/web-audit-report-action/.github/workflows/audit.yml@v1
    with:
      runtime: npm
      report_name: react-base-app
