Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA720404227
	for <lists+linux-api@lfdr.de>; Thu,  9 Sep 2021 02:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348187AbhIIAR1 (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Wed, 8 Sep 2021 20:17:27 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:39696 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241998AbhIIAR0 (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Wed, 8 Sep 2021 20:17:26 -0400
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 188LUsXS031111;
        Thu, 9 Sep 2021 00:16:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2021-07-09; bh=vGolCZaIKZ2C6gxe+rx1Dpv+0MJKJS4f9RCK/5e0MO0=;
 b=MP4/TW3SUqX+6JVYOCkmCl/q5NPQB1Z40+XTBQUdoTbPmXZ/VRUxNGPDV0MK/6cnAXbB
 07neb3bLgz/34tyuuXzENnOE9xOBUXWuLGdalM5YYkuQxZR0RxvpY9DoC1dTfGdwe5QO
 3TEA6dDNjC3+zsvjc2l/aeGec+/S7ndy2aJWQWWM+bZY4f98RL219O6w7DbM2Gaa2PUW
 DWWW2Tn3Grz3b1vIBQjC2ZSxLCfjszECG+EFuAtsCua/inC1dvBuDu1v8/71Pxk3u9w1
 OmN+hgqs5ND9a4rvGQ/RsQXB61tGE9lpFQjyvcpjym33jSjoXqhgfgdF1INM0joQKv27 Hw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2020-01-29; bh=vGolCZaIKZ2C6gxe+rx1Dpv+0MJKJS4f9RCK/5e0MO0=;
 b=Mi17g+crb4guuLYl8w0N/fDxrQ0tcEoVbOiJG4IzB2B5tGRc/OMCXa3naZN1ci2NfM04
 y2+c0kzh3EplwqKDgDJXYdmbS4NjkwBGgqlAH+FJD9xHShtsR9nieJr/ZjE/yF2URMXP
 Bzu+JNLGjfP9ZPRgTIHvgE3oGV5foDsmjsoWFcR9NgNKwKwZfxDXB5NUGethSGVZK4Xc
 wj4Bhcl68OIHu7q3xD2v5VTBUBwk2uCVEbSzX9Yq9m3z3/C5hL4n0T4WGtLk9bq5lL2j
 mhA/tREOxtDFL1dsngKwMETQM39011dKUZPEh42wfccsUE9Dt9ZvqfyMDfxLdrgehGCk fg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3axcw6chu6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Sep 2021 00:16:16 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1890GEmT180423;
        Thu, 9 Sep 2021 00:16:15 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2047.outbound.protection.outlook.com [104.47.51.47])
        by aserp3030.oracle.com with ESMTP id 3axcppf5gy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Sep 2021 00:16:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ka3Rjib+pRSFc6jkH3Rq2oYdRLpPvtiSlyFGqSBbdzrbB7vkY//9RzXVt/PWKk7arBB2olPxMLswr5m5yibMryK2BVgrsAmtP/IOcs28FWJahQ6LO7L8aUA31TBw1Eok+caCn/nu6JedSP9hCp8fbjuPsQ5vuzTzWd4XDiUTI121wfuFIrm+4f3mNPlQWQ9KI0dypOu2pCbnru/N/9ScwsBzTPMXDZYmiXw9gb0BKLylSZ8N1fJk1yRwyVpYN7f57a3JhunEPt2ZwnD+E+jms50iqEyAyaf915OTqX2qwbw6mMKVtGzTyF5jRSpOnN7qca9OKRcYSx8vkwWLwtfbpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=vGolCZaIKZ2C6gxe+rx1Dpv+0MJKJS4f9RCK/5e0MO0=;
 b=gVbft20AO4ikKDWFTzoAsftAypTlWmYLAPPPG+QqCNA6KHmjIcK7qRlCuiq0+US0tahfENsedIoIKCi8ZlxtRE9BFP0PYK7N2NuA00JF65sRuQY6pJzcKHXLzWq5AbAqz3CieeKm0LfYpFoyQrJMLq2u51Q8dh76+t9pBAuy4G5cE3Oi9TWCV4OdJWShANaubvoMN7/w3a17cXnXPXV6HIqeC8tc+ygiUheyvwrtintNDMsUMxONmQJvg+11hLmNMJ+qIWBu3f49XmNeAFdvxNnndeA5W0C3n2JyC5vj9gFRfpR02R/ZrS4lfUmmEZmISaWUVuxUt9nhD7BdDZt0tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vGolCZaIKZ2C6gxe+rx1Dpv+0MJKJS4f9RCK/5e0MO0=;
 b=j2rS1EBkcD7CeUs5+PYp7c441t4qAONjNhAslereT5MiXZElCTYCDB2RPq+ez1rLgG5JEofsAFAsGqHjf4I9YfNsc8DF5zfw2NgnJOFgIPTiYofw3nK6nzbXpRw7w+TrOsPtYB/Zfp55TuYhLsfUrWtXn/BncZYfaLKBBLaNsuI=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2629.namprd10.prod.outlook.com (2603:10b6:a02:b7::24)
 by BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.21; Thu, 9 Sep
 2021 00:16:03 +0000
Received: from BYAPR10MB2629.namprd10.prod.outlook.com
 ([fe80::c9c2:64d4:c67f:6837]) by BYAPR10MB2629.namprd10.prod.outlook.com
 ([fe80::c9c2:64d4:c67f:6837%7]) with mapi id 15.20.4478.025; Thu, 9 Sep 2021
 00:16:03 +0000
From:   Prakash Sangappa <prakash.sangappa@oracle.com>
To:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Cc:     mingo@redhat.com, prakash.sangappa@oracle.com
Subject: [RESEND RFC PATCH 0/3] Provide fast access to thread specific data
Date:   Wed,  8 Sep 2021 17:23:53 -0700
Message-Id: <1631147036-13597-1-git-send-email-prakash.sangappa@oracle.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0171.namprd03.prod.outlook.com
 (2603:10b6:a03:338::26) To BYAPR10MB2629.namprd10.prod.outlook.com
 (2603:10b6:a02:b7::24)
MIME-Version: 1.0
Received: from pp-ThinkCentre-M82.us.oracle.com (2606:b400:8024:1010::13d2) by SJ0PR03CA0171.namprd03.prod.outlook.com (2603:10b6:a03:338::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.4500.16 via Frontend Transport; Thu, 9 Sep 2021 00:16:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d7ae6bf-1124-495e-a464-08d973270248
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB288855891B670F324AB064D6E4D59@BYAPR10MB2888.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FFiGGq6fljva+FD1yDsmLhqCxlEh50Ja1JJ0M6tlwDvUWh7mWVt4Jtn0tMe7OTXDIllLwrDEp4sSIJuKFmQqNYNFboF/XI9v4q6bulScx6AMvF1h7/hthbf4O98AU3q4prAMjfTZ0o+qcFGuFpzpZdfY1J3VFmcgSib8CMm4rcqSLVHXw+14B6FWiJaVtqBh/jRYGrFXCtA/YjwzCu2wT8S5XwpvzXAxyHPpf9My6siDjV3omwQ39kbiP70SCNFkUCr18TDj87hnYSY7YzkiGBroB+nHnHixqwyGrKMt6o2pW3AbyK+ZFgRbiUyF7sSP9dhPp02DjiRjScEZ1a5gnWlGu3Z42GrM6bpN7C9Ue10czwfrTPynUlWMKkZRrJtVX+K1dCMBq5DNB8txeP3rVLhhMu5EU8s+ITXUMbt+rdGSLvur7OGi5yyBrulx5ARayAK06Bn4fGGd/ovlhXhXjAfV2cTJv+mR9bSRHp8UT0REzyuE8CJ5opbFSZtTSpuYHo4OXX8T6D7o0B4jBb9Qj7EXqKn9WS+vi3wuSD9cWmT4V7CYBVoJdTVP2UnvswQ/SoQgb5KyqN0Rqtl3UdSzhPv+QjhyTNxiGHaVv6Pt1sFo1ySg93pFbzAlHhyceaNbosmKiocnjYHi9NtpX8MvBQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2629.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(376002)(366004)(396003)(39860400002)(346002)(8676002)(2616005)(8936002)(5660300002)(66476007)(6486002)(83380400001)(6666004)(7696005)(52116002)(44832011)(107886003)(316002)(186003)(66556008)(2906002)(66946007)(36756003)(38100700002)(478600001)(86362001)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AQsxKRk4CQZB9/2/Ratnqx+Y8cGVxmNpnR9alfQI+++OTJfgOYhor7ojIxEa?=
 =?us-ascii?Q?+0BN7fy9GxhwXHujL3u09jV3yqeyV0u+Bp7uN+x7rqc2EXmrjstn9rg/TkrB?=
 =?us-ascii?Q?Yc8rexF+V7LGN1Pjhe9Ap5zYl4h6M3iz8GV2O+csbjENsNXFASryWzmTW9KP?=
 =?us-ascii?Q?wsWc7inMccqcO8zoRz5cy3eaHtZxtSZNgDdysting+LT01wPPr0CyHC/ROyV?=
 =?us-ascii?Q?cDNJ9IYafYiF4mPpszbSKHhRa8zze/xxZooAtEmMjMl0iiCRzw3780hlnP2r?=
 =?us-ascii?Q?5D27zEyc6RLOgdcY1y5mp/joxNfMxGwphFZQgJ96uq96rZ/6oveR8V6Haqja?=
 =?us-ascii?Q?A+0/fZKG3bH+gdCnTHAWm2iemzbXEN6Z6mLMNVpuV8Jze1fMuSYkSWwrUC0n?=
 =?us-ascii?Q?B0zRngHKeHvALyBOty7b/4TD0+k0HZ/UToITbSUHeUCgjBlK0FNbO1BBU97W?=
 =?us-ascii?Q?as/d5fLdB/Rm57p6mIQQY5qeHRRoB3ABUUe+LjeCpFbHYMRM5emOnMNxMfT7?=
 =?us-ascii?Q?OaNdjs/01j6PMuH/gPcIJrK66WttP+4gGhZMX9kIeYaSzKjbXil1AW2nODAi?=
 =?us-ascii?Q?oUFv3Zp8YLfEgEPJtvTvSpvx4FeDihIpkTFS+3oD2TfXOR87ZVHEATKbrFqS?=
 =?us-ascii?Q?4N3TYQaG5W5o6DH8orLbMtSAxdSvGE4FdiYjtSkcnpzZngx+o7Rl0Y1GIBoP?=
 =?us-ascii?Q?PXBMAdE0qHkldg2O7qqI0DQI9E+RzS7YDnw3A2N+FoOZangdmEDVmgpuuEff?=
 =?us-ascii?Q?ii3iCyHxzAR4VAgDOXKjWl09JAU0tW/SvaporFzyNqr/YMAXWNy8qR5HJ/Rl?=
 =?us-ascii?Q?QNHymk0TSrLNOc0OhPM+ae4RgZWldJugr2UhpIZQq2MB9M6Jgd0M4LuuxI7e?=
 =?us-ascii?Q?TlRzoNzphTUygxuqBEj277bzXDN0up46UhNbd+AeAUxeRvKAf+DHpcvKQ1Dm?=
 =?us-ascii?Q?hGpd5j6dnbfvab9JxdZWOJFxl7t+yIetMNaK6Qd38fxlvxmM0QcZlt3ofNZv?=
 =?us-ascii?Q?uILxoFOn56/lXtVZG0hYAJOxmKYQHH+thaHCDMpwqDEEDcmCSr5Mavx2k6/C?=
 =?us-ascii?Q?TTJkNFpYFe4xL1cyvLRZ9xO32eJgMFZtNI8b1NDf4uTAvGmeUAJZ263WIZvl?=
 =?us-ascii?Q?1rOSPkp7ATg5f8dNmTz198RGdMDULIKio6+7AzgMi+Lo6Jkr72BzkKNVPR0R?=
 =?us-ascii?Q?c4DBvMXnqFOB/hkXC6CXaTCbYtTEnFsJJ+RiTns8CiKjy3r/hWo4+fnOaOdW?=
 =?us-ascii?Q?kaHyZbuurynvHfG3B8LkYVrhLg7eCGOBDJQGlDIwBsiEMkRUYovsS85/OXCB?=
 =?us-ascii?Q?Cev6xxcuePV6/WswfAyU4GXP4VDleK67zjsRBN09T43J/Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d7ae6bf-1124-495e-a464-08d973270248
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2629.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2021 00:16:03.0958
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YoDKDdNwHbXfOSYhyzbjbYqvszAQzaKeX+Z0A9SGUZ21HZZY5nfSz7Z6gtz4oe1pgrKuyoNRSrxNaQLio/Qs0cgzNvGvNEc3OBrqwZxnQlM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2888
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10101 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109090000
X-Proofpoint-GUID: NKgD1KCXCl8KRPxtqspTiOSXlr_yUu8r
X-Proofpoint-ORIG-GUID: NKgD1KCXCl8KRPxtqspTiOSXlr_yUu8r
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

Including liunx-kernel..

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

