<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Weekly Tasks/Hours Bar Chart</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        @keyframes formalBackgroundAnimation {
            0% { background-position: 0% 0%; }
            50% { background-position: 100% 100%; }
            100% { background-position: 0% 0%; }
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(45deg, #4a90e2, #d0d0d0, #4a90e2, #d0d0d0);
            background-size: 400% 400%;
            animation: formalBackgroundAnimation 20s ease infinite;
            color: #333;
            text-align: center;
            padding: 50px;
            margin: 0;
            overflow-x: hidden;
            overflow-y: auto; /* Enable vertical scrolling */
        }

        h2 {
            color: #fff;
            margin-bottom: 30px;
            font-size: 2.5em;
            font-weight: 600;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.6);
        }

        .chart-container {
            max-width: 800px; /* Larger size for bar chart */
            margin: 0 auto;
            padding: 20px;
            background: rgba(255, 255, 255, 0.4); /* Glass effect */
            border-radius: 12px;
            box-shadow: 0 8px 24px rgba(0,0,0,0.3);
            backdrop-filter: blur(15px); /* Enhanced glass effect */
            border: 1px solid rgba(255, 255, 255, 0.2); /* Subtle border */
        }

        canvas {
            width: 100% !important;
            height: auto !important;
            border-radius: 8px;
        }

        a.button {
            display: inline-flex;
            align-items: center;
            padding: 12px 24px;
            border-radius: 12px;
            background: linear-gradient(45deg, #ff6b6b, #f7d794); /* Vibrant gradient */
            color: #fff;
            text-decoration: none;
            font-size: 1.2em;
            font-weight: bold;
            transition: all 0.3s ease;
            position: relative;
            overflow: hidden;
            text-shadow: 1px 1px 2px rgba(0,0,0,0.3);
            margin-top: 20px;
        }

        a.button::before {
            content: '';
            position: absolute;
            top: 50%;
            left: 50%;
            width: 300%;
            height: 300%;
            background: rgba(255,255,255,0.5);
            transition: all 0.4s ease;
            transform: translate(-50%, -50%) scale(0);
            border-radius: 50%;
            z-index: 0;
        }

        a.button:hover::before {
            transform: translate(-50%, -50%) scale(1);
        }

        a.button:hover {
            background: linear-gradient(45deg, #f7d794, #ff6b6b);
            box-shadow: 0 8px 24px rgba(0,0,0,0.4);
            transform: scale(1.05);
        }

        a.button i {
            margin-right: 12px;
            font-size: 1.5em;
        }
    </style>
</head>
<body>
    <h2>Weekly Tasks/Hours Bar Chart</h2>
    <div class="chart-container">
        <canvas id="AllWeeklyChart" width="400" height="400"></canvas>
    </div>
    <a href="dashboard.jsp" class="button"><i class="fas fa-arrow-left"></i> Back to Dashboard</a>
    <script>
        fetch('AllWeeklyChartServlet')
        .then(response => response.json())
        .then(data => {
            const ctx = document.getElementById('AllWeeklyChart').getContext('2d');

            const labels = [];
            const datasetMap = {};

            data.datasets.forEach(item => {
                if (!labels.includes(item.day)) {
                    labels.push(item.day);
                }
                if (!datasetMap[item.username]) {
                    datasetMap[item.username] = [];
                }
                datasetMap[item.username].push({
                    x: item.day,
                    y: item.duration
                });
            });

            const datasets = Object.keys(datasetMap).map(username => ({
                label: username,
                data: datasetMap[username],
                backgroundColor: 'rgba(54, 162, 235, 0.2)',
                borderColor: 'rgba(54, 162, 235, 1)',
                borderWidth: 1
            }));

            new Chart(ctx, {
                type: 'bar',
                data: {
                    labels: labels,
                    datasets: datasets
                },
                options: {
                    scales: {
                        y: {
                            beginAtZero: true
                        }
                    }
                }
            });
        });
    </script>
</body>
</html>
