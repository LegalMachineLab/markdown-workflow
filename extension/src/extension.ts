// The module 'vscode' contains the VS Code extensibility API
// Import the module and reference it with the alias vscode in your code below
import * as vscode from 'vscode';

// This method is called when your extension is activated
// Your extension is activated the very first time the command is executed
export function activate(context: vscode.ExtensionContext) {

	// Use the console to output diagnostic information (console.log) and errors (console.error)
	// This line of code will only be executed once when your extension is activated
	console.log('Congratulations, your extension "markdownworkflow" is now active!');

	context.subscriptions.push(
		vscode.commands.registerCommand('markdownworkflow.fulltext-markdown', async () => {
			await setIssueMetadata();
			const terminal = vscode.window.createTerminal(`Markdown Workflow terminal`);
			terminal.show();
		    terminal.sendText("fulltext-markdown.sh");
		})
	);

	context.subscriptions.push(
		vscode.commands.registerCommand('markdownworkflow.markdown-galleys', () => {
			var path = "";
			var currentlyOpenTabFilePath = vscode.window.activeTextEditor?.document.uri.fsPath;
			if (currentlyOpenTabFilePath && currentlyOpenTabFilePath.endsWith(".md")) {
				path = currentlyOpenTabFilePath;
			}
			const terminal = vscode.window.createTerminal(`Markdown Workflow terminal`);
			terminal.show();
		    terminal.sendText("markdown-galleys.sh --pdf " + path);
		})
	);
}

// This method is called when your extension is deactivated
export function deactivate() {}

/**
 * Shows an input box using window.showInputBox().
 */
export async function setIssueMetadata() {
	if (vscode.workspace.rootPath === undefined) {
		console.log("ERROR");
		return;
	} else {
		var basePath = vscode.workspace.rootPath + "/issue.yaml";
	}
	try {
		await vscode.workspace.fs.stat(vscode.Uri.file(basePath));
		console.log("Issue configuration exists. Skipping...");
		return;
	}
	catch {
		const result = await vscode.window.showInputBox({
			placeHolder: 'For example: 2024 17 1',
			validateInput: text => {
				// vscode.window.showInformationMessage(`Validating: ${text}`);
				return text.split(" ").length !== 3 ? 'Invalid input!' : null;
			}
		});
		vscode.window.showInformationMessage(`Got: ${result}`);
		let values = result ? result?.split(' '): [];
		var issueContent = `---
# Issue Level Customizations
volume: "` + values[2] + `"
issue: "` + values[1] + `"
year: "` + values[0] + `"
#issuetitle: # placeholder
#issuedescription: # placeholder
issuedisplay: "Vol. ` + values[2] + ` n. ` + values[1] + ` (` + values[0] + `)" # how you are going to show in PDF & HTML the issue reference
---
`;

		await vscode.workspace.fs.writeFile(vscode.Uri.file(basePath), new TextEncoder().encode(issueContent));
	}
}
