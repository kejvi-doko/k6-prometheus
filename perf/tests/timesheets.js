import http from 'k6/http';
import { check, sleep } from 'k6';

export const options = {
  thresholds: {
    http_req_failed: ['rate<0.01'],
    http_req_duration: ['p(95)<1000'],
  },
  scenarios: {
    load: {
      executor: 'ramping-vus',
      startVUs: 1,
      stages: [
        { duration: '1m', target: 5 },
        { duration: '3m', target: 10 },
        { duration: '1m', target: 0 },
      ],
      tags: { plan: 'timesheets', env: 'local' },
    },
  },
  discardResponseBodies: true,
};

export default function () {
  const base = __ENV.BASE_URL || 'https://httpbin.test.k6.io';
  const res = http.get(`${base}/get`);
  check(res, { '200': (r) => r.status === 200 });
  sleep(Math.random() * 1 + 0.5);
}
