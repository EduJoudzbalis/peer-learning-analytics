USE education_analytics;

-- =======================================================
-- KPI 1: ANÁLISIS DE IMPACTO POR CATEGORÍA
-- (Valida: "Efecto Nivelador Masivo")
-- =======================================================
SELECT 
    categoria AS 'Perfil del Estudiante',
    COUNT(*) AS 'Total Alumnos',
    ROUND(AVG(nota_individual), 2) AS 'Promedio Inicial (Individual)',
    ROUND(AVG(nota_parejas), 2) AS 'Promedio Final (Parejas)',
    ROUND(AVG(mejora), 2) AS 'Puntos Ganados (Impacto)'
FROM peer_learning_analysis
GROUP BY categoria;

-- =======================================================
-- KPI 2: TASA DE RESCATE (RECOVERY RATE)
-- (Valida: "¿Cuántos reprobados aprobaron gracias al grupo?")
-- =======================================================
SELECT 
    -- Contamos cuántos estaban reprobados (<10)
    (SELECT COUNT(*) FROM peer_learning_analysis WHERE nota_individual < 10) AS 'Total en Riesgo',
    
    -- Contamos cuántos de esos lograron aprobar (>=10) en parejas
    (SELECT COUNT(*) FROM peer_learning_analysis WHERE nota_individual < 10 AND nota_parejas >= 10) AS 'Rescatados',
    
    -- Calculamos el porcentaje
    CONCAT(
        ROUND(
            (SELECT COUNT(*) FROM peer_learning_analysis WHERE nota_individual < 10 AND nota_parejas >= 10) * 100.0 / 
            (SELECT COUNT(*) FROM peer_learning_analysis WHERE nota_individual < 10), 
        1), 
    '%') AS 'Tasa de Éxito del Rescate';

-- =======================================================
-- KPI 3: CONSISTENCIA ENTRE SECCIONES
-- (Verificar si el método funcionó igual en todas las aulas)
-- =======================================================
SELECT 
    seccion,
    ROUND(AVG(mejora), 2) AS 'Mejora Promedio',
    MAX(mejora) AS 'Mejora Máxima Registrada',
    MIN(mejora) AS 'Mejora Mínima'
FROM peer_learning_analysis
GROUP BY seccion
ORDER BY seccion;