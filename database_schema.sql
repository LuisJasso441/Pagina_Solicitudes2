-- ============================================
-- BASE DE DATOS: Portal de Solicitudes TI
-- GrupoVerden
-- ============================================

-- Crear base de datos
CREATE DATABASE IF NOT EXISTS solicitudes_ti CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE solicitudes_ti;

-- ============================================
-- TABLA: usuarios
-- ============================================
CREATE TABLE usuarios (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nombre_completo VARCHAR(255) NOT NULL,
    departamento VARCHAR(50) NOT NULL,
    usuario VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    activo TINYINT(1) DEFAULT 1,
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
    ultimo_acceso DATETIME NULL,
    INDEX idx_departamento (departamento),
    INDEX idx_usuario (usuario)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- TABLA: solicitudes_atencion
-- ============================================
CREATE TABLE solicitudes_atencion (
    id INT PRIMARY KEY AUTO_INCREMENT,
    folio VARCHAR(50) NOT NULL UNIQUE,
    usuario_id INT NOT NULL,
    departamento VARCHAR(50) NOT NULL,
    tipo_problema VARCHAR(100) NULL,
    asunto VARCHAR(255) NOT NULL,
    descripcion TEXT NOT NULL,
    prioridad ENUM('baja', 'media', 'alta', 'urgente') DEFAULT 'media',
    estado ENUM('pendiente', 'en_proceso', 'finalizada', 'cancelada') DEFAULT 'pendiente',
    tecnico_asignado INT NULL,
    observaciones_tecnico TEXT NULL,
    fecha_creacion DATETIME DEFAULT CURRENT_TIMESTAMP,
    fecha_actualizacion DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    fecha_finalizacion DATETIME NULL,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
    FOREIGN KEY (tecnico_asignado) REFERENCES usuarios(id),
    INDEX idx_folio (folio),
    INDEX idx_usuario (usuario_id),
    INDEX idx_departamento (departamento),
    INDEX idx_estado (estado),
    INDEX idx_fecha_creacion (fecha_creacion)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- TABLA: mantenimientos_equipos_computo
-- ============================================
CREATE TABLE mantenimientos_equipos_computo (
    id INT PRIMARY KEY AUTO_INCREMENT,
    folio VARCHAR(50) NOT NULL UNIQUE,
    usuario_id INT NOT NULL,
    departamento VARCHAR(50) NOT NULL,
    solicitante VARCHAR(255) NOT NULL,
    marca VARCHAR(100) NULL,
    modelo VARCHAR(100) NOT NULL,
    numero_serie VARCHAR(100) NULL,
    tipo_mantenimiento ENUM('preventivo', 'correctivo') NOT NULL,
    descripcion TEXT NOT NULL,
    fecha_solicitud DATE NOT NULL,
    fecha_mantenimiento DATE NULL,
    tecnico_asignado INT NULL,
    observaciones TEXT NULL,
    estado ENUM('pendiente', 'realizado', 'cancelado') DEFAULT 'pendiente',
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
    FOREIGN KEY (tecnico_asignado) REFERENCES usuarios(id),
    INDEX idx_folio (folio),
    INDEX idx_departamento (departamento),
    INDEX idx_fecha_solicitud (fecha_solicitud)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- TABLA: mantenimientos_telefonos
-- ============================================
CREATE TABLE mantenimientos_telefonos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    folio VARCHAR(50) NOT NULL UNIQUE,
    usuario_id INT NOT NULL,
    departamento VARCHAR(50) NOT NULL,
    solicitante VARCHAR(255) NOT NULL,
    marca VARCHAR(100) NULL,
    modelo VARCHAR(100) NOT NULL,
    imei VARCHAR(50) NULL,
    numero_linea VARCHAR(20) NULL,
    tipo_mantenimiento ENUM('preventivo', 'correctivo') NOT NULL,
    descripcion TEXT NOT NULL,
    fecha_solicitud DATE NOT NULL,
    fecha_mantenimiento DATE NULL,
    tecnico_asignado INT NULL,
    observaciones TEXT NULL,
    estado ENUM('pendiente', 'realizado', 'cancelado') DEFAULT 'pendiente',
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
    FOREIGN KEY (tecnico_asignado) REFERENCES usuarios(id),
    INDEX idx_folio (folio),
    INDEX idx_departamento (departamento),
    INDEX idx_fecha_solicitud (fecha_solicitud)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- TABLA: mantenimientos_impresoras
-- ============================================
CREATE TABLE mantenimientos_impresoras (
    id INT PRIMARY KEY AUTO_INCREMENT,
    folio VARCHAR(50) NOT NULL UNIQUE,
    usuario_id INT NOT NULL,
    departamento VARCHAR(50) NOT NULL,
    solicitante VARCHAR(255) NOT NULL,
    marca VARCHAR(100) NULL,
    modelo VARCHAR(100) NOT NULL,
    numero_serie VARCHAR(100) NULL,
    ubicacion VARCHAR(255) NULL,
    tipo_mantenimiento ENUM('preventivo', 'correctivo') NOT NULL,
    descripcion TEXT NOT NULL,
    fecha_solicitud DATE NOT NULL,
    fecha_mantenimiento DATE NULL,
    tecnico_asignado INT NULL,
    observaciones TEXT NULL,
    estado ENUM('pendiente', 'realizado', 'cancelado') DEFAULT 'pendiente',
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
    FOREIGN KEY (tecnico_asignado) REFERENCES usuarios(id),
    INDEX idx_folio (folio),
    INDEX idx_departamento (departamento),
    INDEX idx_fecha_solicitud (fecha_solicitud)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- TABLA: mantenimientos_camaras
-- ============================================
CREATE TABLE mantenimientos_camaras (
    id INT PRIMARY KEY AUTO_INCREMENT,
    folio VARCHAR(50) NOT NULL UNIQUE,
    usuario_id INT NOT NULL,
    departamento VARCHAR(50) NOT NULL,
    solicitante VARCHAR(255) NOT NULL,
    marca VARCHAR(100) NULL,
    modelo VARCHAR(100) NOT NULL,
    ubicacion VARCHAR(255) NOT NULL,
    direccion_ip VARCHAR(50) NULL,
    tipo_mantenimiento ENUM('preventivo', 'correctivo') NOT NULL,
    descripcion TEXT NOT NULL,
    fecha_solicitud DATE NOT NULL,
    fecha_mantenimiento DATE NULL,
    tecnico_asignado INT NULL,
    observaciones TEXT NULL,
    estado ENUM('pendiente', 'realizado', 'cancelado') DEFAULT 'pendiente',
    fecha_registro DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
    FOREIGN KEY (tecnico_asignado) REFERENCES usuarios(id),
    INDEX idx_folio (folio),
    INDEX idx_departamento (departamento),
    INDEX idx_fecha_solicitud (fecha_solicitud)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- TABLA: archivos_adjuntos
-- ============================================
CREATE TABLE archivos_adjuntos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    solicitud_id INT NULL,
    mantenimiento_id INT NULL,
    tipo_mantenimiento VARCHAR(50) NULL COMMENT 'computo, telefono, impresora, camara',
    tipo_archivo ENUM('solicitud', 'mantenimiento', 'colaborativo', 'otro') NOT NULL,
    nombre_archivo VARCHAR(255) NOT NULL,
    nombre_original VARCHAR(255) NOT NULL,
    extension VARCHAR(10) NOT NULL,
    tamano_bytes INT NOT NULL,
    ruta_archivo VARCHAR(500) NOT NULL,
    subido_por INT NOT NULL,
    fecha_subida DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (solicitud_id) REFERENCES solicitudes_atencion(id) ON DELETE CASCADE,
    FOREIGN KEY (subido_por) REFERENCES usuarios(id),
    INDEX idx_solicitud (solicitud_id),
    INDEX idx_tipo (tipo_archivo)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- TABLA: documentos_colaborativos
-- ============================================
CREATE TABLE documentos_colaborativos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(255) NOT NULL,
    descripcion TEXT NULL,
    nombre_archivo VARCHAR(255) NOT NULL,
    nombre_original VARCHAR(255) NOT NULL,
    extension VARCHAR(10) NOT NULL,
    tamano_bytes INT NOT NULL,
    ruta_archivo VARCHAR(500) NOT NULL,
    subido_por INT NOT NULL,
    departamento_origen VARCHAR(50) NOT NULL,
    fecha_subida DATETIME DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (subido_por) REFERENCES usuarios(id),
    INDEX idx_departamento (departamento_origen),
    INDEX idx_fecha (fecha_subida)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- TABLA: historial_estados
-- ============================================
CREATE TABLE historial_estados (
    id INT PRIMARY KEY AUTO_INCREMENT,
    solicitud_id INT NOT NULL,
    estado_anterior VARCHAR(50) NOT NULL,
    estado_nuevo VARCHAR(50) NOT NULL,
    comentario TEXT NULL,
    cambiado_por INT NOT NULL,
    fecha_cambio DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (solicitud_id) REFERENCES solicitudes_atencion(id) ON DELETE CASCADE,
    FOREIGN KEY (cambiado_por) REFERENCES usuarios(id),
    INDEX idx_solicitud (solicitud_id),
    INDEX idx_fecha (fecha_cambio)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- TABLA: descargas_log
-- ============================================
CREATE TABLE descargas_log (
    id INT PRIMARY KEY AUTO_INCREMENT,
    usuario_id INT NOT NULL,
    archivo_id INT NULL,
    nombre_archivo VARCHAR(255) NOT NULL,
    tipo_descarga VARCHAR(50) NOT NULL,
    fecha_descarga DATETIME DEFAULT CURRENT_TIMESTAMP,
    ip_descarga VARCHAR(45) NULL,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
    FOREIGN KEY (archivo_id) REFERENCES archivos_adjuntos(id) ON DELETE SET NULL,
    INDEX idx_usuario (usuario_id),
    INDEX idx_fecha (fecha_descarga)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- ============================================
-- DATOS DE EJEMPLO
-- ============================================

-- Insertar usuario de prueba TI/Sistemas
-- Password: admin123456789 (15 caracteres)
INSERT INTO usuarios (nombre_completo, departamento, usuario, password) VALUES
('Administrador del Sistema', 'sistemas', 'admin', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi');

-- Insertar usuario de prueba Ventas
-- Password: ventas1234567890 (15 caracteres)
INSERT INTO usuarios (nombre_completo, departamento, usuario, password) VALUES
('Juan Pérez García', 'ventas', 'jperez', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi');

-- Insertar usuario de prueba Contabilidad
-- Password: conta12345678901 (15 caracteres)
INSERT INTO usuarios (nombre_completo, departamento, usuario, password) VALUES
('María García López', 'contabilidad', 'mgarcia', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi');

-- Insertar usuario de prueba Laboratorio (colaborativo)
-- Password: labora1234567890 (15 caracteres)
INSERT INTO usuarios (nombre_completo, departamento, usuario, password) VALUES
('Carlos Martínez Díaz', 'laboratorio', 'cmartinez', '$2y$10$92IXUNpkjO0rOQ5byMi.Ye4oKoEa3Ro9llC/.og/at2.uheWG/igi');

-- Insertar solicitudes de ejemplo
INSERT INTO solicitudes_atencion (folio, usuario_id, departamento, asunto, descripcion, estado) VALUES
('SOL-20251002-ABC123', 2, 'ventas', 'Error en sistema de ventas', 'Al intentar generar un reporte aparece un error', 'pendiente'),
('SOL-20251001-DEF456', 3, 'contabilidad', 'No puedo acceder al sistema', 'Me sale error de credenciales', 'en_proceso'),
('SOL-20250930-GHI789', 2, 'ventas', 'Problema con impresora', 'La impresora no está imprimiendo', 'finalizada');

-- Insertar mantenimientos de ejemplo
INSERT INTO mantenimientos_equipos_computo (folio, usuario_id, departamento, solicitante, modelo, tipo_mantenimiento, descripcion, fecha_solicitud) VALUES
('MAN-20251002-COM001', 2, 'ventas', 'Juan Pérez García', 'HP Pavilion 15', 'preventivo', 'Mantenimiento preventivo anual', '2025-10-02'),
('MAN-20251001-COM002', 3, 'contabilidad', 'María García López', 'Dell OptiPlex 7090', 'correctivo', 'Equipo muy lento', '2025-10-01');

INSERT INTO mantenimientos_impresoras (folio, usuario_id, departamento, solicitante, modelo, tipo_mantenimiento, descripcion, fecha_solicitud) VALUES
('MAN-20251002-IMP001', 3, 'contabilidad', 'María García López', 'Canon G6000 Series', 'preventivo', 'Limpieza de cabezales', '2025-10-02');

-- ============================================
-- FIN DEL SCRIPT
-- ============================================