// lib/screens/profile_screen.dart
// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final TextEditingController _nameController = TextEditingController(
    text: 'Abdias Cuellar Prado',
  );
  final TextEditingController _emailController = TextEditingController(
    text: 'abdias.cuellar@email.com',
  );
  final TextEditingController _phoneController = TextEditingController(
    text: '+1 234 567 8900',
  );
  final TextEditingController _bioController = TextEditingController(
    text: 'Desarrollador Flutter • Amante de la tecnología • Fotógrafo amateur',
  );

  bool _isEditing = false;
  String _selectedGender = 'Masculino';
  DateTime _selectedDate = DateTime(1995, 6, 15);
  String _selectedCountry = 'México';

  final List<String> _countries = [
    'México',
    'España',
    'Estados Unidos',
    'Colombia',
    'Argentina',
    'Chile',
  ];
  final List<String> _genders = [
    'Masculino',
    'Femenino',
    'No binario',
    'Prefiero no decirlo',
  ];

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Colors.purple;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Perfil'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              _isEditing ? Icons.check : Icons.edit,
              color: primaryColor,
            ),
            onPressed: _toggleEditing,
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            // Header del perfil
            _buildProfileHeader(primaryColor),

            // Estadísticas
            _buildStatsSection(isDarkMode),

            // Información del perfil
            _buildProfileInfo(primaryColor, isDarkMode),

            // Intereses y habilidades
            _buildInterestsSection(isDarkMode),

            // Redes sociales
            _buildSocialMediaSection(isDarkMode),

            // Botones de acción
            _buildActionButtons(context, primaryColor),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileHeader(Color primaryColor) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            primaryColor.withOpacity(0.8),
            primaryColor.withOpacity(0.4),
          ],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
      ),
      child: Column(
        children: [
          Stack(
            alignment: Alignment.bottomRight,
            children: [
              Container(
                width: 200,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(60),
                  child: Image.asset(
                    'assets/profile_picture.jpg', // Asegúrate de tener esta imagen
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.9),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.person,
                          size: 60,
                          color: Colors.purple,
                        ),
                      );
                    },
                  ),
                ),
              ),
              if (_isEditing)
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: IconButton(
                    icon: const Icon(
                      Icons.camera_alt,
                      size: 20,
                      color: Colors.purple,
                    ),
                    onPressed: _changeProfilePicture,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            _nameController.text,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            _emailController.text,
            style: const TextStyle(fontSize: 16, color: Colors.white70),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'Usuario Premium',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsSection(bool isDarkMode) {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[800] : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem('128', 'Seguidores', Icons.people),
          _buildStatItem('56', 'Siguiendo', Icons.group),
          _buildStatItem('342', 'Publicaciones', Icons.photo_library),
          _buildStatItem('89', 'Likes', Icons.favorite),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label, IconData icon) {
    return Column(
      children: [
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.purple.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.purple, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      ],
    );
  }

  Widget _buildProfileInfo(Color primaryColor, bool isDarkMode) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[800] : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info_outline, color: primaryColor),
              const SizedBox(width: 10),
              const Text(
                'Información Personal',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildInfoField(
            icon: Icons.person,
            label: 'Nombre completo',
            value: _nameController,
            isEditable: _isEditing,
          ),
          const SizedBox(height: 15),
          _buildInfoField(
            icon: Icons.email,
            label: 'Correo electrónico',
            value: _emailController,
            isEditable: _isEditing,
          ),
          const SizedBox(height: 15),
          _buildInfoField(
            icon: Icons.phone,
            label: 'Teléfono',
            value: _phoneController,
            isEditable: _isEditing,
          ),
          const SizedBox(height: 15),
          _buildInfoField(
            icon: Icons.cake,
            label: 'Fecha de nacimiento',
            value: TextEditingController(
              text:
                  '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
            ),
            isEditable: false,
            onTap: _isEditing ? _selectDate : null,
          ),
          const SizedBox(height: 15),
          _buildDropdownField(
            icon: Icons.transgender,
            label: 'Género',
            value: _selectedGender,
            items: _genders,
            isEditable: _isEditing,
            onChanged: (value) {
              setState(() {
                _selectedGender = value!;
              });
            },
          ),
          const SizedBox(height: 15),
          _buildDropdownField(
            icon: Icons.location_on,
            label: 'País',
            value: _selectedCountry,
            items: _countries,
            isEditable: _isEditing,
            onChanged: (value) {
              setState(() {
                _selectedCountry = value!;
              });
            },
          ),
          const SizedBox(height: 15),
          _buildInfoField(
            icon: Icons.description,
            label: 'Biografía',
            value: _bioController,
            isEditable: _isEditing,
            maxLines: 3,
          ),
        ],
      ),
    );
  }

  Widget _buildInfoField({
    required IconData icon,
    required String label,
    required TextEditingController value,
    required bool isEditable,
    int maxLines = 1,
    VoidCallback? onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            color: isEditable ? Colors.grey[50] : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey[300]!, width: 1),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Icon(icon, color: Colors.purple, size: 20),
              ),
              Expanded(
                child: TextField(
                  controller: value,
                  enabled: isEditable,
                  maxLines: maxLines,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(vertical: 15),
                  ),
                  style: const TextStyle(fontSize: 16),
                ),
              ),
              if (onTap != null)
                IconButton(
                  icon: const Icon(Icons.calendar_today, size: 20),
                  onPressed: onTap,
                ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDropdownField({
    required IconData icon,
    required String label,
    required String value,
    required List<String> items,
    required bool isEditable,
    required ValueChanged<String?> onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 5),
        Container(
          decoration: BoxDecoration(
            color: isEditable ? Colors.grey[50] : Colors.transparent,
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.grey[300]!, width: 1),
          ),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Icon(icon, color: Colors.purple, size: 20),
              ),
              Expanded(
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: value,
                    isExpanded: true,
                    icon: const Icon(
                      Icons.arrow_drop_down,
                      color: Colors.purple,
                    ),
                    items: items.map((String item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(item),
                        ),
                      );
                    }).toList(),
                    onChanged: isEditable ? onChanged : null,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInterestsSection(bool isDarkMode) {
    final List<String> interests = [
      'Flutter',
      'Dart',
      'UI/UX',
      'Fotografía',
      'Viajes',
      'Música',
      'Tecnología',
      'Deportes',
    ];

    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[800] : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.interests_outlined, color: Colors.purple),
              const SizedBox(width: 10),
              const Text(
                'Intereses y Habilidades',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: interests.map((interest) {
              return Chip(
                label: Text(interest),
                backgroundColor: Colors.purple.withOpacity(0.1),
                labelStyle: const TextStyle(color: Colors.purple),
                deleteIcon: _isEditing
                    ? const Icon(Icons.close, size: 16)
                    : null,
                onDeleted: _isEditing ? () => _removeInterest(interest) : null,
              );
            }).toList(),
          ),
          if (_isEditing) ...[
            const SizedBox(height: 15),
            TextField(
              decoration: InputDecoration(
                hintText: 'Añadir nuevo interés...',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.add, color: Colors.purple),
                  onPressed: _addInterest,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onSubmitted: (value) {
                if (value.isNotEmpty) {
                  // Lógica para agregar interés
                }
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSocialMediaSection(bool isDarkMode) {
    final List<Map<String, dynamic>> socialMedias = [
      {
        'icon': Icons.facebook,
        'name': 'Facebook',
        'username': '@abdias.cuellar',
      },
      {
        'icon': Icons.camera_alt,
        'name': 'Instagram',
        'username': '@abdias.dev',
      },
      {'icon': Icons.code, 'name': 'GitHub', 'username': 'abdias-cuellar'},
      {'icon': Icons.work, 'name': 'LinkedIn', 'username': 'abdias-cuellar'},
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[800] : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.link, color: Colors.purple),
              const SizedBox(width: 10),
              const Text(
                'Redes Sociales',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Column(
            children: socialMedias.map((social) {
              return ListTile(
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.purple.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(social['icon'], color: Colors.purple),
                ),
                title: Text(social['name']),
                subtitle: Text(social['username']),
                trailing: _isEditing
                    ? IconButton(
                        icon: const Icon(Icons.edit, size: 20),
                        onPressed: () => _editSocialMedia(social['name']),
                      )
                    : const Icon(Icons.open_in_new, size: 20),
                onTap: () => _openSocialMedia(social['name']),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, Color primaryColor) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _isEditing
                  ? _saveProfile
                  : () => setState(() => _isEditing = true),
              style: ElevatedButton.styleFrom(
                backgroundColor: primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
              ),
              icon: Icon(_isEditing ? Icons.save : Icons.edit, size: 22),
              label: Text(
                _isEditing ? 'Guardar Cambios' : 'Editar Perfil',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: _shareProfile,
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    side: BorderSide(color: primaryColor),
                  ),
                  icon: Icon(Icons.share, color: primaryColor),
                  label: Text(
                    'Compartir',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: primaryColor,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () => _showPrivacySettings(context),
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    side: BorderSide(color: Colors.grey[600]!),
                  ),
                  icon: Icon(Icons.privacy_tip, color: Colors.grey[600]),
                  label: Text(
                    'Privacidad',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[600],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Métodos de la lógica
  void _toggleEditing() {
    setState(() {
      _isEditing = !_isEditing;
      if (!_isEditing) {
        // Aquí guardarías los cambios en una base de datos
        _showSaveSuccess(context);
      }
    });
  }

  void _saveProfile() {
    // Lógica para guardar el perfil
    setState(() {
      _isEditing = false;
    });
    _showSaveSuccess(context);
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _changeProfilePicture() {
    // Lógica para cambiar la foto de perfil
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Cambiar foto de perfil'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Tomar foto'),
                onTap: () {
                  Navigator.pop(context);
                  // Lógica para tomar foto
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Elegir de la galería'),
                onTap: () {
                  Navigator.pop(context);
                  // Lógica para elegir de galería
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _removeInterest(String interest) {
    // Lógica para remover interés
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Interés "$interest" eliminado'),
        backgroundColor: Colors.purple,
      ),
    );
  }

  void _addInterest() {
    // Lógica para agregar interés
  }

  void _editSocialMedia(String platform) {
    // Lógica para editar red social
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Editando $platform'),
        backgroundColor: Colors.purple,
      ),
    );
  }

  void _openSocialMedia(String platform) {
    // Lógica para abrir red social
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Abriendo $platform'),
        backgroundColor: Colors.purple,
      ),
    );
  }

  void _shareProfile() {
    // Lógica para compartir perfil
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Perfil compartido'),
        backgroundColor: Colors.purple,
      ),
    );
  }

  void _showPrivacySettings(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Configuración de Privacidad'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('Controla quién puede ver tu información:'),
                const SizedBox(height: 15),
                _buildPrivacyOption('Perfil público', true),
                _buildPrivacyOption('Mostrar email', false),
                _buildPrivacyOption('Mostrar teléfono', false),
                _buildPrivacyOption('Mostrar fecha de nacimiento', true),
                _buildPrivacyOption('Mostrar ubicación', false),
              ],
            ),
          ),
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
                    content: Text('Configuración de privacidad guardada'),
                    backgroundColor: Colors.purple,
                  ),
                );
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.purple),
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildPrivacyOption(String label, bool value) {
    return Row(
      children: [
        Switch(
          value: value,
          activeColor: Colors.purple,
          onChanged: (newValue) {},
        ),
        const SizedBox(width: 10),
        Text(label),
      ],
    );
  }

  void _showSaveSuccess(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Perfil actualizado correctamente'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }
}
