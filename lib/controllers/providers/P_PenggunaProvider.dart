import 'package:fluent_ui/fluent_ui.dart';
import 'package:sibagjaapps/controllers/apiservices/S_APIFetchUsers.dart';
import '../../models/M_Pengguna.dart';

class ProviderPengguna extends ChangeNotifier {
  List<M_Pengguna> _allData = []; // Store all data
  List<M_Pengguna> filteredData = []; // Filtered data to be displayed
  String idUsers ='';
  String selectedDropdown = '--';
  TextEditingController finderbyname = TextEditingController();
  List<String> dropdown = ['--','Administrator', 'Keperawatan', 'Pelayanan'];
  APIFetchPengguna _service = APIFetchPengguna();

  ProviderPengguna(){
    FetchData();
    finderbyname.addListener(_applyFilter);
  }

  void changeDropdown(String idxDrop) {
    selectedDropdown = idxDrop;
    _applyFilter();
    notifyListeners();
  }

  void selectedUserId(String idxUsers) {
    idUsers = idxUsers;
    notifyListeners();
  }

  void FetchData() async {
    filteredData.clear();
    notifyListeners();
    _allData = await _service.FetchDataUsers();
    _applyFilter(); // Apply initial filter
    notifyListeners();
  }

  void _applyFilter() {
    filteredData = _allData.where((user) {
      bool matchesDescription = selectedDropdown == '--' || 
        user.deskripsi?.toLowerCase() == selectedDropdown.toLowerCase();
      
      bool matchesName = finderbyname.text.isEmpty ||
        user.nama?.toLowerCase().contains(finderbyname.text.toLowerCase()) == true;

      return matchesDescription && matchesName;
    }).toList();

    notifyListeners();
  }

  @override
  void dispose() {
    finderbyname.removeListener(_applyFilter);
    finderbyname.dispose();
    super.dispose();
  }
}