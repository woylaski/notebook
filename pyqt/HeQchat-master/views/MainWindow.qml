import QtQuick 2.1

import QtQuick.Controls 1.0
import QtQuick.Dialogs 1.0
import QtQuick.Layouts 1.0

ApplicationWindow {
	id: window

	title: {
		var currentTab = (tabView.currentIndex < tabView.count) ? tabView.getTab(tabView.currentIndex) : null;
		var result = "HeQchat";

		if (currentTab != null) {
			result += ": " + currentTab.children[0].children[0].children[0].mainWindowTitle; // Item -> Loader -> Component
		}

		return result;
	}

	visible: true

	TabView {
		id: tabView

		anchors.fill: parent

		Repeater {
			model: mainModel.tabs

			Tab {
				property var tabModel: model

				title: tabModel.name

				Item {
					Loader {
						sourceComponent: {
							switch (tabModel.objectType) {
								case "ServerTab":
									return serverViewDelegate;
								case "ChannelTab":
									return channelViewDelegate;
							}
						}

						anchors.fill: parent
					}

					Component {
						id: serverViewDelegate

						ServerView { }
					}

					Component {
						id: channelViewDelegate

						ChannelView { }
					}
				}
			}
		}
	}
}
