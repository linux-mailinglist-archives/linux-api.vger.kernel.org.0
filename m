Return-Path: <linux-api-owner@vger.kernel.org>
X-Original-To: lists+linux-api@lfdr.de
Delivered-To: lists+linux-api@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E86746905A
	for <lists+linux-api@lfdr.de>; Mon,  6 Dec 2021 07:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237684AbhLFGSR (ORCPT <rfc822;lists+linux-api@lfdr.de>);
        Mon, 6 Dec 2021 01:18:17 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46662 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236571AbhLFGSQ (ORCPT
        <rfc822;linux-api@vger.kernel.org>); Mon, 6 Dec 2021 01:18:16 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B64I2TH028793;
        Mon, 6 Dec 2021 06:14:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : content-type :
 mime-version; s=pp1; bh=K/Paca94JaAFzf+FMtTON0EOr2JuJkoWvhRnGgBo5wQ=;
 b=AWY9s22GWrJ7pQPvmxHRqajnvsEu0NoI+XXBq3GtyWITFiSbYv+ZN6KKMbM0STo72QIP
 pSyXHTJlfNUJDBwRc8C8njhytsHfonMsEKFr5ekDJQYVDSLcWRqY/5dv6AEyl7DCeeMh
 WkmGDqwoCpbNez933cEcojKDYfym6WtFDiySAXlMl3uVgwmXk2NAdtI7NWyPW1zMynwm
 Rxj7QeHAIN5g+o79PmWaW4PU3L8nh9RtxoLIXI99i8ha4c4ZTY3X/UwCH969lIMc4Yw1
 BFKZFqyOWB2kmQHUwyP3m01M95Oa1cvnCl/qwhE5Tnb+nZ6a4HYY18jXXGpc6++loDZf 7g== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3csbc51jr8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 06:14:37 +0000
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 1B66BHdC030312;
        Mon, 6 Dec 2021 06:14:36 GMT
Received: from ppma02wdc.us.ibm.com (aa.5b.37a9.ip4.static.sl-reverse.com [169.55.91.170])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3csbc51jr4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 06:14:36 +0000
Received: from pps.filterd (ppma02wdc.us.ibm.com [127.0.0.1])
        by ppma02wdc.us.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 1B66Dfn3005019;
        Mon, 6 Dec 2021 06:14:35 GMT
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com [9.57.198.29])
        by ppma02wdc.us.ibm.com with ESMTP id 3cqyy9e3f3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 06 Dec 2021 06:14:35 +0000
Received: from b01ledav001.gho.pok.ibm.com (b01ledav001.gho.pok.ibm.com [9.57.199.106])
        by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 1B66EZQj55509250
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 6 Dec 2021 06:14:35 GMT
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5D60028067;
        Mon,  6 Dec 2021 06:14:35 +0000 (GMT)
Received: from b01ledav001.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id AA3F028066;
        Mon,  6 Dec 2021 06:14:30 +0000 (GMT)
Received: from skywalker.linux.ibm.com (unknown [9.43.89.70])
        by b01ledav001.gho.pok.ibm.com (Postfix) with ESMTP;
        Mon,  6 Dec 2021 06:14:30 +0000 (GMT)
X-Mailer: emacs 28.0.50 (via feedmail 11-beta-1 I)
From:   "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To:     kernel test robot <lkp@intel.com>, akpm@linux-foundation.org,
        aarcange@redhat.com, ak@linux.intel.com, ben.widawsky@intel.com,
        dan.j.williams@intel.com, dave.hansen@linux.intel.com,
        feng.tang@intel.com, linux-api@vger.kernel.org,
        mgorman@techsingularity.net, mhocko@kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org
Subject: Re: + mm-mempolicy-wire-up-syscall-set_mempolicy_home_node.patch
 added to -mm tree
In-Reply-To: <202112060718.JbZsyJcP-lkp@intel.com>
References: <20211202225542.A2LkS8Bho%akpm@linux-foundation.org>
 <202112060718.JbZsyJcP-lkp@intel.com>
Date:   Mon, 06 Dec 2021 11:44:28 +0530
Message-ID: <87o85ub6pn.fsf@linux.ibm.com>
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: qY71JCU_pS3T8Xyoe668lhYBq_p4H-sO
X-Proofpoint-GUID: yad0agPixeWI7UGnr3SVN8RK6pT2MMY8
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-06_02,2021-12-06_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 clxscore=1011 priorityscore=1501 suspectscore=0 spamscore=0
 impostorscore=0 mlxscore=0 bulkscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112060037
Precedence: bulk
List-ID: <linux-api.vger.kernel.org>
X-Mailing-List: linux-api@vger.kernel.org

kernel test robot <lkp@intel.com> writes:

> Hi,
>
> I love your patch! Perhaps something to improve:
>
> [auto build test WARNING on arm64/for-next/core]
> [also build test WARNING on deller-parisc/for-next linus/master v5.16-rc3]
> [cannot apply to geert-m68k/for-next powerpc/next s390/features arnd-asm-generic/master tip/x86/asm davem-sparc/master next-20211203]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch]
>
> url:    https://github.com/0day-ci/linux/commits/akpm-linux-foundation-org/mm-mempolicy-wire-up-syscall-set_mempolicy_home_node-patch-added-to-mm-tree/20211203-065847
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
> config: arm64-randconfig-r025-20211203 (https://download.01.org/0day-ci/archive/20211206/202112060718.JbZsyJcP-lkp@intel.com/config)
> compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 1e328b06c15273edf4a40a27ca24931b5efb3a87)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm64 cross compiling tool for clang build
>         # apt-get install binutils-aarch64-linux-gnu
>         # https://github.com/0day-ci/linux/commit/d7bb34dec7840474ed1ad87136b47eb1ea0c8bee
>         git remote add linux-review https://github.com/0day-ci/linux
>         git fetch --no-tags linux-review akpm-linux-foundation-org/mm-mempolicy-wire-up-syscall-set_mempolicy_home_node-patch-added-to-mm-tree/20211203-065847
>         git checkout d7bb34dec7840474ed1ad87136b47eb1ea0c8bee
>         # save the config file to linux build tree
>         mkdir build_dir
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash
>
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
> All warnings (new ones prefixed by >>):
>
>            asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
>                                   ^
>    <scratch space>:161:1: note: expanded from here
>    __arm64_sys_process_madvise
>    ^
>    kernel/sys_ni.c:292:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
>    arch/arm64/include/asm/syscall_wrapper.h:76:13: note: expanded from macro 'COND_SYSCALL'
>            asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
>                       ^
>    kernel/sys_ni.c:293:1: warning: no previous prototype for function '__arm64_sys_process_mrelease' [-Wmissing-prototypes]
>    COND_SYSCALL(process_mrelease);
>    ^
>    arch/arm64/include/asm/syscall_wrapper.h:76:25: note: expanded from macro 'COND_SYSCALL'
>            asmlinkage long __weak __arm64_sys_##name(const struct pt_regs *regs)   \
>                                   ^
>    <scratch space>:162:1: note: expanded from here
>    __arm64_sys_process_mrelease

These build warnings with W=1 are related to arm header includes. arm64
expand syscall macro such that '__arm64_' is added to the syscall
handler name. Hence the include  linux/syscall.h that have below
prototype is not sufficient.   
asmlinkage long sys_set_mempolicy_home_node(unsigned long start, unsigned long len,
					    unsigned long home_node,
					    unsigned long flags);


That should be fixed outside this series.

-aneesh


