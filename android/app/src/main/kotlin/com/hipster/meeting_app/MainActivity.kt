package com.hipster.meeting_app

import com.hipster.meeting_app.chime.ChimeBridge
import com.hipster.meeting_app.chime.ChimeVideoViewFactory
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine

class MainActivity : FlutterActivity() {
    private var chimeBridge: ChimeBridge? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        val messenger = flutterEngine.dartExecutor.binaryMessenger
        val bridge = ChimeBridge(applicationContext, messenger)
        chimeBridge = bridge

        flutterEngine.platformViewsController.registry
            .registerViewFactory("chime/video-tile", ChimeVideoViewFactory(bridge))
    }
}
