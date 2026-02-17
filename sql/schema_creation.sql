-- =======================================================
-- 1. CONFIGURACIÓN DEL ENTORNO
-- =======================================================
CREATE DATABASE IF NOT EXISTS education_analytics;
USE education_analytics;

-- =======================================================
-- 2. CREACIÓN DE LA TABLA (Data Warehouse)
-- =======================================================
DROP TABLE IF EXISTS peer_learning_analysis;

CREATE TABLE peer_learning_analysis (
    student_id VARCHAR(10) PRIMARY KEY,  -- Ej: STD_001
    seccion CHAR(1),                     -- A, C, E
    nota_individual DECIMAL(4,2),        -- Notas con decimales (Ej: 14.50)
    nota_parejas DECIMAL(4,2),
    mejora DECIMAL(4,2),                 -- La diferencia (delta)
    categoria VARCHAR(20)                -- 'Bajo Rendimiento' o 'Alto Rendimiento'
);
