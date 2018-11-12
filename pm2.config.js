const java = 'java'

module.exports = {
    apps: [
        {
            name: 'api',
            script: java,
            args: [
                '-jar',
                './target/lng-api-service-1.1.1.jar',
            ],
            cwd: './lng-api/lng-api-service',
            interpreter: 'none',
        },
        {
            name: 'upms',
            script: java,
            args: [
                '-jar',
                './target/lng-upms-service-1.1.1.jar',
            ],
            cwd: './lng-upms/lng-upms-service',
            interpreter: 'none',
        },
        {
            name: 'message',
            script: java,
            args: [
                '-jar',
                './target/lng-message-1.1.1.jar',
            ],
            cwd: './lng-message',
            interpreter: 'none',
        },
        {
            name: 'task',
            script: java,
            args: [
                '-jar',
                './target/lng-time-task-1.1.1.jar',
            ],
            cwd: './lng-time-task',
            interpreter: 'none',
        },
        {
            name: 'pay',
            script: java,
            args: [
                '-jar',
                './target/lng-pay-service-1.1.1.jar',
            ],
            cwd: './lng-pay/lng-pay-service',
            interpreter: 'none',
        },
    ]
}

