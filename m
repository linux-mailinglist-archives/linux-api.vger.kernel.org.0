Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6307404202
	for <lists+linux-api@lfdr.de>; Thu,  9 Sep 2021 02:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347801AbhIIAD5 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 8 Sep 2021 20:03:57 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:65534 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236059AbhIIAD5 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 8 Sep 2021 20:03:57 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 188LUsVL031111;
        Thu, 9 Sep 2021 00:02:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2021-07-09; bh=7lhhCiiXq+cfxiOxhHdRjF0shwkv9w9F2QKtC0iEFg4=;
 b=BGtPT5HdI+rD6B6IuA+BWkztgH6VYWDWg8HQWtD7u9Q+VQFjq3UrY0rTsQIdJwl/U4Br
 xNIryYh1SwY5TwXaXbga6iOkrSmXsLgvtnEIPlqZBB8nNttCvH/dpILlCTDRh0xUTglL
 mlRrpaTXpTAHJ3TgIwFggRivO+eIj8iRZGKblsOJ4S5XiL+5apGvEr0w+en4AUfFtT/y
 g9qp03Fen3u2T4t1sR6PhrZArtg5ttNHFXX1MwqfuVBBq2tQoL79fIPmivne9euw6zz9
 8KmCj5YLaUUxhCsLsMN44zeBRrSdOyTY6CGZgjR3u6DVhI0Wj4js9EqsQEI98vrBbD2M RA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2020-01-29; bh=7lhhCiiXq+cfxiOxhHdRjF0shwkv9w9F2QKtC0iEFg4=;
 b=Et+dlUWQgUZT8Yy8+tpSriVBB0D62t/+j3bcOl83crakqhYuR4Vzauu+m89gPveYAwx2
 86NPh6CtfG2NPInOWOpIuyWC0Mk8O+RGjwrphnQC70fGsqbGuxFz7vCPIwhRe137+6Qd
 jtsevAHLmGMCG+wn5rGahiMiGMmZTGcN9ram9TGrQsx+NpibzarMA87YsqLicCjeFSAE
 xdiiTDVJy3Z7cx0sRDEYhQs3wTTRNMd8iWM1+6T6lSLHXrzQF8MExKC60GrXOW2kXN4i
 VPCqlbAJNEw40rgs8irSANYnnx0o7Q/Iu7l5cPGwNAq/fwGh3vrx1qTHRxjWfYWrdXdz 4g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3axcw6cgw7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Sep 2021 00:02:46 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18900sUW066616;
        Thu, 9 Sep 2021 00:02:45 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by userp3030.oracle.com with ESMTP id 3axcq24yse-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Sep 2021 00:02:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AuMBkk8h3/bRse0hEGed3CXnnaTAkIbVNqT9HP2jnZaa8WcmDewz/WOHKeIjexeDRUk0ntLvcT2/czBocwqQ4w2dRBaahz8lEWljl5BukACDZA5u3Yy52hljLHFJ8yxfD3ThlUNizBDwI/5B16Y7piKazwl5spc32AhgRYEn+Pn9KZCTaLJ5yzQ/f6MkL6z0afwt7QmhxIPDgE9Uz0B72OUmRE55nFvwtN/dwd08dmbG05iwF22oYZ639ErBy1/FeuEawL3mVNriwSAIoSqeO25t1q/9F8Z4rYFuuqq7M7wTlhH1M8Gi6TsnbEaxm97dIilGCHWMh5QB2ndw1hBuBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=7lhhCiiXq+cfxiOxhHdRjF0shwkv9w9F2QKtC0iEFg4=;
 b=lmCZYbEOv+tFPm205xuuZAMd928wjz1ZLmGvt1n1xd3ff5aKlJWRtzufzY69PZIjyOKfkTHVmWuPcgDxCTtromugYPg7f5FYHTe1GqM0IgJEMmwWAdKPgwv5Mz79hGFAJvOyiTHj4sumf4TxMkFrtCxsWj35ZDVPxGxycHqyVwZxscwatx3cmULRYr1ZpA5dWLDNiCnNU6cbJ8k/wDABRx6QiNTm1JTVlJEp+POPIXFH2Mb23c/46/WxCYDXXuGgrY5V8sQnjIW8GdEH/s7iQGtQ2Y6c5ZjyzuA/Z2WBNoGyfVZp14MUoCemi8TeUuFIi2qe8gOK97cIN7qXvlzwFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7lhhCiiXq+cfxiOxhHdRjF0shwkv9w9F2QKtC0iEFg4=;
 b=X+/YlVp2VI59R/mMfhQjecOinurvGydhUSD4crjKGEqw2jPpHE7vQCrPckdxZ4x0MM4BkCuNwYgMQUGqgSN8QOne2dgf6YaIXXI+0XbN0QE/mhAb7LiM7Kmy4dpDV6F3+mhHWJbmulk+PUbakii7FiMHNqj8q06VdZlDUA3luk8=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2629.namprd10.prod.outlook.com (2603:10b6:a02:b7::24)
 by SJ0PR10MB5472.namprd10.prod.outlook.com (2603:10b6:a03:303::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Thu, 9 Sep
 2021 00:02:43 +0000
Received: from BYAPR10MB2629.namprd10.prod.outlook.com
 ([fe80::c9c2:64d4:c67f:6837]) by BYAPR10MB2629.namprd10.prod.outlook.com
 ([fe80::c9c2:64d4:c67f:6837%7]) with mapi id 15.20.4478.025; Thu, 9 Sep 2021
 00:02:43 +0000
From:   Prakash Sangappa <prakash.sangappa@oracle.com>
To:     --to=linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc:     mingo@redhat.com, prakash.sangappa@oracle.com
Subject: [RESEND RFC PATCH 0/3] Provide fast access to thread specific data
Date:   Wed,  8 Sep 2021 17:10:22 -0700
Message-Id: <1631146225-13387-1-git-send-email-prakash.sangappa@oracle.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SN7PR04CA0025.namprd04.prod.outlook.com
 (2603:10b6:806:f2::30) To BYAPR10MB2629.namprd10.prod.outlook.com
 (2603:10b6:a02:b7::24)
MIME-Version: 1.0
Received: from pp-ThinkCentre-M82.us.oracle.com (2606:b400:8024:1010::13d2) by SN7PR04CA0025.namprd04.prod.outlook.com (2603:10b6:806:f2::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4500.14 via Frontend Transport; Thu, 9 Sep 2021 00:02:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 357212f5-9842-4cd0-0133-08d97325256f
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5472:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB54725D67F2B3DAC3676AB08AE4D59@SJ0PR10MB5472.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8x2ac3BkBHxusxp8xQ/7Hi7zDzGvjzXB+wx+NuB1tfVLEDSkQr047o7zsQf9UWEiFAbHgJ4iiI13KeqWVXb3CYbuact+y/Is62wCjfiuhmP6Ghlp6+zH8ifsk/v+ztgEteli501hDK6UhEcCmdTe8b7f9sKs5i/65XfEW0A7LXVTmD+r62yMWlaJ70amw8mEQfayQ5v0pE3dNKa0VEd5J3VUFMRlsuvi9ncmrvwHajLoR39ySLIUQZQUEpvz1Ki5jb0f/I9B6Gq85aV1c/Iflnl9A3BFse2kpj4NMloMeLcBB/ICWu1rV0SAPTK39SyW5DsG/zIGjwumWVJylxl2BHepBqJEj8pxvAd1AxKeL9kzhK5LCIBBpyZ3wPaGdZwKNWDClCHaZZG+duo0/6sW9Y4hEEt6TYPVpV6X+5GU8U1+b1TxACaoDn0RjZuSGUkryFlSVxSmPmScsiuzGmYLBGTo+ilYWV9agVMIjNMGJZ3v3jw5HeEmATfAZGIYwt3kXRbZ8WKMcsLDCJ/gyaxs9Da9kY/Uh5GNZZDOKcY8BJJ4T/AlzsJ4AlKwlnqmo2rI4tOIDNOYTQtWVtEoMXEBJI9q5T9D62LmhInLMZ3XAu/NccYpTeP6lpRrnHjmutPXTfBvlJcp5K2KJxpje/lYmA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2629.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(39860400002)(366004)(136003)(376002)(66476007)(36756003)(2906002)(186003)(83380400001)(107886003)(38100700002)(478600001)(44832011)(2616005)(66556008)(4326008)(66946007)(8936002)(86362001)(6486002)(8676002)(6666004)(316002)(7696005)(52116002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FmAb9W9pNZFnnr5ufG404/wbTfZXwphCB6ppNXF6iqjjEzJ2Mqflwums90/l?=
 =?us-ascii?Q?I7tX6K2Hq3gPlkUCgCyppV/ncsFjjGCxXv3G7LyW38O+DZ4ytQf8yNRAJlKG?=
 =?us-ascii?Q?5oQlh2kTrc/dIHaegGefio3YQ8yLrjrblCpwJXfg6w1XXtg28vX4jleL5Zzz?=
 =?us-ascii?Q?43ywNSSx8mzIDvW/Ec5JoAr1h/Yj/BrG3IA3e5ULk2nIPihFEnQTvUTW4Jpn?=
 =?us-ascii?Q?Uq/oQP1vgK+86OS4TZIDntK/kUSETyQoQ21w6j987Ev4SZleZzC0dUE/7cT4?=
 =?us-ascii?Q?4ODJzBH4bgoxQ++RCmxu+QF2N59XL+yjDtUDgqsWBtm4q6W69HcZ/gZzXGfr?=
 =?us-ascii?Q?CgfVp03xXbhAYJMlU9Hw/A4eVYSveCgq4gTJTZ4Wod/g7mm1MvoLtAFcyFD8?=
 =?us-ascii?Q?TnQCxgCk40gvrBVpYv2WAvCT84mHU2TVlz1cq+MSnUkQwzHzfi6jPPrdVNVO?=
 =?us-ascii?Q?OZlRaK+V8O0V4Tefb7vmuz7uj4dZPEZ4DfzWlwtHYew+P5YDu6mN+hqJEprr?=
 =?us-ascii?Q?4hyyx9ROF7loo4NnYTzisNdwiFdQrXUf9AIZiARGInvV9nWgSnYCZZ13wRiE?=
 =?us-ascii?Q?RPeTjx00hHg77ay78vaiNsSMZ23CbMIsJOwW3pcsp+K0nROZroc+mUKYeXB7?=
 =?us-ascii?Q?UJrDT1ftRd7brpNZi1kjGh68H8vcGxQu2H8eMepkJwYInXEKgEfg/12gNLZb?=
 =?us-ascii?Q?BLUW65Q6Ph73vbVIVzdUmkJD5z3vKjxM+7LtJI6lYfAL1ZS0EaZTzQHvmW9X?=
 =?us-ascii?Q?RVSI3zcufri6EQu+lkPevSJo84jfGXKB8PGXj1to4DlxWS2jiYNSOo4Q+05L?=
 =?us-ascii?Q?5VpPONI4UWdWP1SK3KcMV4VhS4yBbofBr/srIfelsvCNOOy1lWazQlGdkjUf?=
 =?us-ascii?Q?AnVnoHZApIvdK/IN4L3CBCA0lJGxjrvjono6TVkWVfqLfcGxzJb690j637fN?=
 =?us-ascii?Q?NyPCHmtUrQ6D8oR4On320xm8N19k7BtqgwTu+hhqKnz2JLkNpxN/rs6mN0wW?=
 =?us-ascii?Q?7xQjCPHcQ25dJTge15i/sAl6lVj8Ua7NdJAkNc3kML91eXJVlu8Vwbk1SBIB?=
 =?us-ascii?Q?QRYjmOHnrDVBIZqCMNMr6VSwdQaR6cdQbduxGvpIeIQxRJboVRB2fdAkmW7U?=
 =?us-ascii?Q?YzUl97Me08/3x0DAMyWIyQrQZGElpYKojo5uQgasjSeoUYiCGytCqT6BqY8E?=
 =?us-ascii?Q?ls22bVtAn49C1hDd3eQT3L9EU6y1wNWj52+XrfYRqUIJCKUqLFzdiP24+N3i?=
 =?us-ascii?Q?dRdGhTlMthDawg7FYKFTBaG0pQ58oQrjEIIp0Bfhx/ttHG/P/XMmoGdfNjJw?=
 =?us-ascii?Q?F4Qbi+VEk1cd0/BBNvDCJAwjnpF/B1UpbNN2N+eKSthIhw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 357212f5-9842-4cd0-0133-08d97325256f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2629.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2021 00:02:43.3788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lSJNBR9Repni1XOh3UK6wholHoSilX256gJVPuPqlK3RjZ/QK8DSf5GIJtlasCrNV4cB3h8zGDvLx2GY98b/7uDFmj0Iyoq8nxlT0deypSw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5472
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10101 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 mlxscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109080150
X-Proofpoint-GUID: pWnpNQ4w5E7pFMj9d3hWAfkgVxFaCRSj
X-Proofpoint-ORIG-GUID: pWnpNQ4w5E7pFMj9d3hWAfkgVxFaCRSj
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Resending RFC. This patchset is not final. I am looking for feedback on
this proposal to share thread specific data for us in latency sensitive
codepath.

(patchset based on v5.14-rc7)

Cover letter previously sent:
----------------------------

Some applications, like a Databases require reading thread specific stats
frequently from the kernel in latency sensitive codepath. The overhead of
reading stats from kernel using system call affects performance.
One use case is reading thread's scheduler stats from /proc schedstat file
(/proc/pid/schedstat) to collect time spent by a thread executing on the
cpu(sum_exec_runtime), time blocked waiting on runq(run_delay). These
scheduler stats, read several times per transaction in latency-sensitive
codepath, are used to measure time taken by DB operations.

This patch proposes to introduce a mechanism for kernel to share thread
stats thru a per thread shared structure shared between userspace and
kernel. The per thread shared structure is allocated on a page shared
mapped between user space and kernel, which will provide a way for fast
communication between user and kernel. Kernel publishes stats in this
shared structure. Application thread can read from it in user space
without requiring system calls.

Similarly, there can be other use cases for such shared structure
mechanism.

Introduce 'off cpu' time:

The time spent executing on a cpu(sum_exec_runtime) by a thread,
currently available thru thread's schedstat file, can be shared thru
the shared structure mentioned above. However, when a thread is running 
on the cpu, this time gets updated periodically, can take upto 1ms or
more as part of scheduler tick processing. If the application has to 
measure cpu time consumed across some DB operations, using
'sum_exec_runtime' will not be accurate. To address this the proposal
is to introduce a thread's 'off cpu' time, which is measured at context
switch, similar to time on runq(ie run_delay in schedstat file) is and
should be more accurate. With that the application can determine cpu time
consumed by taking the elapsed time and subtracting off cpu time. The
off cpu time will be made available thru the shared structure along with
the other schedstats from /proc/pid/schedstat file.

The elapsed time itself can be measured using clock_gettime, which is
vdso optimized and would be fast. The schedstats(runq time & off cpu time)
published in the shared structure will be accumulated time, same as what
is available thru schedstat file, all in units of nanoseconds. The
application would take the difference of the values from before and after
the operation for measurement.

Preliminary results from a simple cached read Database workload shows
performance benefit, when the database uses shared struct for reading
stats vs reading from /proc directly.

Implementation:

A new system call is added to request use of shared structure by a user
thread. Kernel will allocate page(s), shared mapped with user space in
which per-thread shared structures will be allocated. These structures
are padded to 128 bytes. This will contain struct members or nested
structures corresponding to supported stats, like the thread's schedstats,
published by the kernel for user space consumption. More struct members
can be added as new feature support is implemented. Multiple such shared
structures will be allocated from a page(upto 32 per 4k page) and avoid
having to allocate one page per thread of a process. Although, will need
optimizing for locality. Additional pages will be allocated as needed to
accommodate more threads requesting use of shared structures. Aim is to
not expose the layout of the shared structure itself to the application,
which will allow future enhancements/changes without affecting the
existing APIs.

The system call will return a pointer(user space mapped address) to the per
thread shared structure members. Application would save this per thread
pointer in a TLS variable and reference it.

The system call is of the form.
int task_getshared(int option, int flags, void __user *uaddr)

// Currently only TASK_SCHEDSTAT option is supported - returns pointer
// to struct task_schedstat. The struct task_schedstat is nested within
// the shared structure.

struct task_schedstat {
        volatile u64    sum_exec_runtime;
        volatile u64    run_delay;
        volatile u64    pcount;
        volatile u64    off_cpu;
};

Usage:

__thread struct task_schedstat *ts;
task_getshared(TASK_SCHEDSTAT, 0, &ts);

Subsequently the stats are accessed using the 'ts' pointer by the thread

Prakash Sangappa (3):
  Introduce per thread user-kernel shared structure
  Publish tasks's scheduler stats thru the shared structure
  Introduce task's 'off cpu' time

 arch/x86/entry/syscalls/syscall_32.tbl |   1 +
 arch/x86/entry/syscalls/syscall_64.tbl |   1 +
 include/linux/mm_types.h               |   2 +
 include/linux/sched.h                  |   9 +
 include/linux/syscalls.h               |   2 +
 include/linux/task_shared.h            |  92 ++++++++++
 include/uapi/asm-generic/unistd.h      |   5 +-
 include/uapi/linux/task_shared.h       |  23 +++
 kernel/fork.c                          |   7 +
 kernel/sched/deadline.c                |   1 +
 kernel/sched/fair.c                    |   1 +
 kernel/sched/rt.c                      |   1 +
 kernel/sched/sched.h                   |   1 +
 kernel/sched/stats.h                   |  55 ++++--
 kernel/sched/stop_task.c               |   1 +
 kernel/sys_ni.c                        |   3 +
 mm/Makefile                            |   2 +-
 mm/task_shared.c                       | 314 +++++++++++++++++++++++++++++++++
 18 files changed, 501 insertions(+), 20 deletions(-)
 create mode 100644 include/linux/task_shared.h
 create mode 100644 include/uapi/linux/task_shared.h
 create mode 100644 mm/task_shared.c

-- 
2.7.4

