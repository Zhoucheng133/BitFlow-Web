import 'package:bitflow_web/components/sidebar/sidebar.dart';
import 'package:bitflow_web/getx/status_get.dart';
import 'package:bitflow_web/getx/store_get.dart';
import 'package:bitflow_web/desktop/pages/download.dart';
import 'package:bitflow_web/desktop/pages/finish.dart';
import 'package:bitflow_web/desktop/pages/settings.dart';
import 'package:bitflow_web/service/funcs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainWindow extends StatefulWidget {
  const MainWindow({super.key});

  @override
  State<MainWindow> createState() => _MainWindowState();
}

class _MainWindowState extends State<MainWindow> {
  bool isMax=false;
  final FuncsService funcsService=Get.find();

  @override
  void initState() {
    super.initState();
    sidebarWidth=storeGet.sidebarWidth.value;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      funcsService.init(context);
    });
  }

  final StoreGet storeGet=Get.find();
  final StatusGet statusGet=Get.find();

  double sidebarWidth=150.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Row(
            children: [
              SizedBox(
                width: sidebarWidth,
                child: Sidebar(),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 10, bottom: 10, top: 5),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).brightness==Brightness.dark ? Colors.grey[850] : Colors.white,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Obx(()=>
                        IndexedStack(
                          index: statusGet.page.value.index,
                          children: [
                            DownloadPage(),
                            FinishPage(),
                            SettingsPage()
                          ],
                        ),
                      )
                    ),
                  ),
                )
              )
            ],
          ),
          Transform.translate(
            offset: Offset(sidebarWidth-5, 0),
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onHorizontalDragUpdate: (details) {
                setState(() {
                  sidebarWidth += details.delta.dx;
                  sidebarWidth = sidebarWidth.clamp(150, 300);
                });
              },
              onHorizontalDragEnd: (details) {
                storeGet.saveSideBarWidth(sidebarWidth);
              },
              child: MouseRegion(
                cursor: SystemMouseCursors.resizeLeftRight,
                child: Container(
                  width: 10,
                  color: Colors.transparent,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}