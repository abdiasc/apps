// lib/screens/settings_screen.dart
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  bool _biometricAuthEnabled = false;
  bool _autoSyncEnabled = false;
  String _selectedLanguage = 'Español';
  double _volumeLevel = 0.7;

  final List<String> _languages = [
    'Español',
    'English',
    'Français',
    'Deutsch',
    'Italiano',
    'Português',
  ];

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkMode ? Colors.white : Colors.black87;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Ajustes'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              isDarkMode ? Icons.light_mode : Icons.dark_mode,
              color: Colors.orange,
            ),
            onPressed: () {
              // Aquí iría la lógica para cambiar tema
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Cambio de tema aplicado'),
                  backgroundColor: Colors.orange,
                ),
              );
            },
          ),
        ],
      ),
      body: _buildContent(context, textColor, isDarkMode),
    );
  }

  Widget _buildContent(BuildContext context, Color textColor, bool isDarkMode) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header con avatar
            _buildProfileHeader(isDarkMode),

            const SizedBox(height: 30),

            // Sección: Cuenta
            _buildSectionTitle('Cuenta', Icons.person_outline),
            _buildSettingsCard(
              children: [
                _buildSettingItem(
                  icon: Icons.person,
                  title: 'Perfil',
                  subtitle: 'Edita tu información personal',
                  onTap: () => _showProfileSettings(context),
                ),
                _buildDivider(),
                _buildSettingItem(
                  icon: Icons.security,
                  title: 'Privacidad y seguridad',
                  subtitle: 'Controles de privacidad',
                  onTap: () => _showPrivacySettings(context),
                ),
                _buildDivider(),
                _buildSettingItem(
                  icon: Icons.credit_card,
                  title: 'Métodos de pago',
                  subtitle: 'Gestiona tus formas de pago',
                  onTap: () => _showPaymentSettings(context),
                ),
              ],
              isDarkMode: isDarkMode,
            ),

            const SizedBox(height: 25),

            // Sección: Preferencias
            _buildSectionTitle('Preferencias', Icons.settings_outlined),
            _buildSettingsCard(
              children: [
                _buildToggleSetting(
                  icon: Icons.notifications_active,
                  title: 'Notificaciones',
                  subtitle: 'Activa o desactiva notificaciones',
                  value: _notificationsEnabled,
                  onChanged: (value) {
                    setState(() {
                      _notificationsEnabled = value;
                    });
                    _showNotificationChange(context, value);
                  },
                ),
                _buildDivider(),
                _buildToggleSetting(
                  icon: Icons.dark_mode,
                  title: 'Modo oscuro',
                  subtitle: 'Activar tema oscuro',
                  value: _darkModeEnabled,
                  onChanged: (value) {
                    setState(() {
                      _darkModeEnabled = value;
                    });
                  },
                ),
                _buildDivider(),
                _buildToggleSetting(
                  icon: Icons.fingerprint,
                  title: 'Autenticación biométrica',
                  subtitle: 'Usar huella digital o rostro',
                  value: _biometricAuthEnabled,
                  onChanged: (value) {
                    setState(() {
                      _biometricAuthEnabled = value;
                    });
                  },
                ),
                _buildDivider(),
                _buildToggleSetting(
                  icon: Icons.sync,
                  title: 'Sincronización automática',
                  subtitle: 'Sincronizar datos en segundo plano',
                  value: _autoSyncEnabled,
                  onChanged: (value) {
                    setState(() {
                      _autoSyncEnabled = value;
                    });
                  },
                ),
              ],
              isDarkMode: isDarkMode,
            ),

            const SizedBox(height: 25),

            // Sección: Configuración de app
            _buildSectionTitle('Aplicación', Icons.apps),
            _buildSettingsCard(
              children: [
                _buildSliderSetting(
                  icon: Icons.volume_up,
                  title: 'Volumen de notificaciones',
                  value: _volumeLevel,
                  onChanged: (value) {
                    setState(() {
                      _volumeLevel = value;
                    });
                  },
                ),
                _buildDivider(),
                _buildDropdownSetting(
                  icon: Icons.language,
                  title: 'Idioma',
                  value: _selectedLanguage,
                  items: _languages,
                  onChanged: (value) {
                    setState(() {
                      _selectedLanguage = value!;
                    });
                    _showLanguageChange(context, value);
                  },
                ),
                _buildDivider(),
                _buildSettingItem(
                  icon: Icons.storage,
                  title: 'Almacenamiento y datos',
                  subtitle: '2.4 GB usados de 5 GB',
                  onTap: () => _showStorageSettings(context),
                ),
                _buildDivider(),
                _buildSettingItem(
                  icon: Icons.help_outline,
                  title: 'Ayuda y soporte',
                  subtitle: 'Centro de ayuda, contacto',
                  onTap: () => _showHelpSupport(context),
                ),
                _buildDivider(),
                _buildSettingItem(
                  icon: Icons.info_outline,
                  title: 'Acerca de',
                  subtitle: 'Versión 2.1.0 • Licencia',
                  onTap: () => _showAboutDialog(context),
                ),
              ],
              isDarkMode: isDarkMode,
            ),

            const SizedBox(height: 30),

            // Botones de acción
            _buildActionButtons(context),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(bool isDarkMode) {
    return Row(
      children: [
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: Colors.orange, width: 2),
          ),
          child: CircleAvatar(
            radius: 32,
            backgroundColor: Colors.orange.withOpacity(0.1),
            child: const Icon(Icons.person, size: 40, color: Colors.orange),
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Usuario Demo',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 5),
              Text(
                'usuario@demo.com',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              const SizedBox(height: 5),
              Text(
                'Plan: Premium',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.orange,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          icon: const Icon(Icons.edit, color: Colors.orange),
          onPressed: () => _showEditProfile(context),
        ),
      ],
    );
  }

  Widget _buildSectionTitle(String title, IconData icon) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0, bottom: 12),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.orange),
          const SizedBox(width: 10),
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsCard({
    required List<Widget> children,
    required bool isDarkMode,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[800] : Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.orange.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: Colors.orange, size: 22),
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(fontSize: 13, color: Colors.grey[600]),
      ),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
    );
  }

  Widget _buildToggleSetting({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.orange.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: Colors.orange, size: 22),
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(fontSize: 13, color: Colors.grey[600]),
      ),
      trailing: Switch.adaptive(
        value: value,
        activeColor: Colors.orange,
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildSliderSetting({
    required IconData icon,
    required String title,
    required double value,
    required ValueChanged<double> onChanged,
  }) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.orange.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: Colors.orange, size: 22),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 5),
          Slider(
            value: value,
            min: 0,
            max: 1,
            divisions: 10,
            activeColor: Colors.orange,
            inactiveColor: Colors.grey[300],
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownSetting({
    required IconData icon,
    required String title,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return ListTile(
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.orange.withOpacity(0.1),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: Colors.orange, size: 22),
      ),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      trailing: DropdownButton<String>(
        value: value,
        icon: const Icon(Icons.arrow_drop_down, color: Colors.orange),
        underline: Container(),
        items: items.map((String item) {
          return DropdownMenuItem<String>(value: item, child: Text(item));
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Divider(height: 1, color: Colors.grey[300]),
    );
  }

  Widget _buildActionButtons(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () => _showBackupOptions(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange,
              padding: const EdgeInsets.symmetric(vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            icon: const Icon(Icons.backup, size: 22),
            label: const Text(
              'Hacer Copia de Seguridad',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        const SizedBox(height: 15),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => _exportData(context),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  side: BorderSide(color: Colors.orange),
                ),
                icon: Icon(Icons.download, color: Colors.orange),
                label: Text(
                  'Exportar Datos',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.orange,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () => _showLogoutDialog(context),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  side: BorderSide(color: Colors.red),
                ),
                icon: Icon(Icons.logout, color: Colors.red),
                label: Text(
                  'Cerrar Sesión',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.red,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Métodos para mostrar diálogos
  void _showNotificationChange(BuildContext context, bool enabled) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          enabled ? 'Notificaciones activadas' : 'Notificaciones desactivadas',
        ),
        backgroundColor: enabled ? Colors.green : Colors.orange,
      ),
    );
  }

  void _showLanguageChange(BuildContext context, String? language) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Idioma cambiado a $language'),
        backgroundColor: Colors.orange,
      ),
    );
  }

  void _showProfileSettings(BuildContext context) {
    _showFeatureDialog(context, 'Configuración de Perfil');
  }

  void _showPrivacySettings(BuildContext context) {
    _showFeatureDialog(context, 'Privacidad y Seguridad');
  }

  void _showPaymentSettings(BuildContext context) {
    _showFeatureDialog(context, 'Métodos de Pago');
  }

  void _showStorageSettings(BuildContext context) {
    _showFeatureDialog(context, 'Almacenamiento y Datos');
  }

  void _showHelpSupport(BuildContext context) {
    _showFeatureDialog(context, 'Ayuda y Soporte');
  }

  void _showAboutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Acerca de la Aplicación'),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Versión: 2.1.0 (Build 2100)',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  'Desarrollado por Tu Empresa © 2024',
                  style: TextStyle(color: Colors.grey[600]),
                ),
                const SizedBox(height: 15),
                const Text(
                  'Características:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                const Text('• Navegación fluida'),
                const Text('• Diseño moderno'),
                const Text('• Temas claro/oscuro'),
                const Text('• Seguridad avanzada'),
                const SizedBox(height: 15),
                const Text('Términos y condiciones aplican'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }

  void _showEditProfile(BuildContext context) {
    _showFeatureDialog(context, 'Editar Perfil');
  }

  void _showBackupOptions(BuildContext context) {
    _showFeatureDialog(context, 'Opciones de Copia de Seguridad');
  }

  void _exportData(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Exportando datos...'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Cerrar Sesión'),
          content: const Text('¿Estás seguro de que deseas cerrar sesión?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Sesión cerrada exitosamente'),
                    backgroundColor: Colors.orange,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Cerrar Sesión'),
            ),
          ],
        );
      },
    );
  }

  void _showFeatureDialog(BuildContext context, String feature) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(feature),
          content: Text(
            'Esta funcionalidad ($feature) está en desarrollo. '
            'Estará disponible en la próxima actualización.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Entendido'),
            ),
          ],
        );
      },
    );
  }
}
