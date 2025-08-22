// This is a simplified example of the submission function
async function submitGrievance(categoryId, details, email) {

    // The URL is now the n8n Webhook URL
    const webhookUrl = 'https://ayushbeniwal.app.n8n.cloud/webhook/b98d7ac1-2784-4483-9af9-0e3cdf301923'; // Use the PRODUCTION URL here

    const data = {
        category_id: categoryId,
        details: details,
        email: email // Optional
    };

    try {
        const response = await fetch(webhookUrl, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(data)
        });

        if (response.ok) {
            // The webhook can send a response back!
            const result = await response.json();
            console.log('Successfully submitted via n8n:', result.message);
            // Show the final confirmation message in the chat
        } else {
            console.error('Submission failed.');
        }

    } catch (error) {
        console.error('Error submitting grievance:', error);
    }
}